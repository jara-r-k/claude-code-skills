#!/usr/bin/env bash
# attention-check.sh — S4.6 per-project detector for claude-code-skills
# Outputs a JSON array of attention signals to stdout. Logs to stderr.
set -uo pipefail

PROJECT="claude-code-skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Accumulate JSON items in an array
ITEMS=()

log() { echo "[scan] $*" >&2; }

# Helper: assign band from score
band_for() {
  local score=$1
  if   (( score >= 80 )); then echo "critical"
  elif (( score >= 50 )); then echo "today"
  elif (( score >= 30 )); then echo "soon"
  else                         echo "ambient"
  fi
}

# Helper: escape a string for JSON (handles quotes, backslashes, newlines)
json_escape() {
  local s="$1"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  s="${s//$'\r'/}"
  s="${s//$'\t'/\\t}"
  echo -n "$s"
}

# Helper: emit one signal item
emit() {
  local id="$1" source="$2" title="$3" body="$4" score="$5"
  local band
  band="$(band_for "$score")"
  local ebody etitle
  etitle="$(json_escape "$title")"
  ebody="$(json_escape "$body")"
  ITEMS+=("{\"id\":\"${id}\",\"source\":\"${source}\",\"project\":\"${PROJECT}\",\"title\":\"${etitle}\",\"body\":\"${ebody}\",\"score\":${score},\"band\":\"${band}\"}")
}

# ─── Detector 1: Skills without evals ────────────────────────────────
detect_no_evals() {
  log "Checking skills without evals..."
  local skills_dir="$PROJECT_ROOT/skills"
  if [[ ! -d "$skills_dir" ]]; then
    emit "no-evals-error" "detect_no_evals" \
      "Skills directory missing" "Cannot find $skills_dir" 20
    return
  fi
  local count=0
  for skill_dir in "$skills_dir"/*/; do
    [[ -d "$skill_dir" ]] || continue
    local name
    name="$(basename "$skill_dir")"
    if [[ ! -d "$skill_dir/eval" && ! -d "$skill_dir/test" && ! -d "$skill_dir/tests" ]]; then
      count=$((count + 1))
      emit "no-evals-${name}" "detect_no_evals" \
        "Skill '${name}' has no evals" \
        "No eval/, test/, or tests/ directory found in skills/${name}/. Add evaluation coverage." \
        55
    fi
  done
  log "  Found $count skills without evals"
}

# ─── Detector 2: Skill age (stale skills) ────────────────────────────
detect_stale_skills() {
  log "Checking skill staleness..."
  local skills_dir="$PROJECT_ROOT/skills"
  [[ -d "$skills_dir" ]] || return

  local now
  now=$(date +%s)
  local threshold=$((30 * 86400))  # 30 days in seconds

  for skill_dir in "$skills_dir"/*/; do
    [[ -d "$skill_dir" ]] || continue
    local name
    name="$(basename "$skill_dir")"

    # Find most recently modified file in the skill directory
    local latest_mod=""
    # Try GNU stat first (Linux), then BSD stat (macOS)
    latest_mod=$(find "$skill_dir" -type f -exec stat -c '%Y' {} + 2>/dev/null | sort -rn | head -1) || true
    if [[ -z "$latest_mod" ]]; then
      latest_mod=$(find "$skill_dir" -type f -exec stat -f '%m' {} + 2>/dev/null | sort -rn | head -1) || true
    fi

    if [[ -n "$latest_mod" ]]; then
      local age_days=$(( (now - latest_mod) / 86400 ))
      if (( age_days >= 30 )); then
        local score
        if   (( age_days >= 180 )); then score=60
        elif (( age_days >= 90  )); then score=45
        else                             score=35
        fi
        emit "stale-skill-${name}" "detect_stale_skills" \
          "Skill '${name}' unchanged for ${age_days} days" \
          "Last modification was ${age_days} days ago. Review whether this skill is still relevant." \
          "$score"
      fi
    fi
  done
}

# ─── Detector 3: Uncommitted changes ─────────────────────────────────
detect_uncommitted() {
  log "Checking uncommitted changes..."
  if ! cd "$PROJECT_ROOT" 2>/dev/null; then
    emit "uncommitted-error" "detect_uncommitted" \
      "Cannot access project root" "Failed to cd to $PROJECT_ROOT" 20
    return
  fi

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    emit "uncommitted-no-git" "detect_uncommitted" \
      "Not a git repository" "claude-code-skills is not a git repo" 15
    return
  fi

  local count
  count=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

  if (( count > 0 )); then
    local score
    if   (( count >= 20 )); then score=70
    elif (( count >= 10 )); then score=55
    elif (( count >= 5  )); then score=40
    else                         score=25
    fi
    emit "uncommitted" "detect_uncommitted" \
      "${count} uncommitted file(s)" \
      "There are ${count} uncommitted changes in the working tree. Consider committing or stashing." \
      "$score"
  fi
}

# ─── Detector 4: Missing SKILL.md ────────────────────────────────────
detect_missing_skillmd() {
  log "Checking for missing SKILL.md..."
  local skills_dir="$PROJECT_ROOT/skills"
  [[ -d "$skills_dir" ]] || return

  for skill_dir in "$skills_dir"/*/; do
    [[ -d "$skill_dir" ]] || continue
    local name
    name="$(basename "$skill_dir")"
    if [[ ! -f "$skill_dir/SKILL.md" ]]; then
      emit "missing-skillmd-${name}" "detect_missing_skillmd" \
        "Skill '${name}' missing SKILL.md" \
        "No SKILL.md found in skills/${name}/. Every skill must have a SKILL.md file." \
        75
    fi
  done
}

# ─── Detector 5: Stale branches ──────────────────────────────────────
detect_stale_branches() {
  log "Checking for stale unmerged branches..."
  if ! cd "$PROJECT_ROOT" 2>/dev/null || ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    return
  fi

  local main_branch
  main_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")

  local now
  now=$(date +%s)
  local threshold=$((30 * 86400))

  # List local branches not yet merged into main
  while IFS= read -r branch; do
    [[ -z "$branch" ]] && continue
    branch="$(echo "$branch" | sed 's/^[* ]*//')"
    [[ "$branch" == "$main_branch" ]] && continue

    local last_commit_epoch
    last_commit_epoch=$(git log -1 --format='%ct' "$branch" 2>/dev/null || true)
    [[ -z "$last_commit_epoch" ]] && continue

    local age_days=$(( (now - last_commit_epoch) / 86400 ))
    if (( age_days >= 30 )); then
      local score
      if   (( age_days >= 180 )); then score=50
      elif (( age_days >= 90  )); then score=40
      else                             score=30
      fi
      emit "stale-branch-$(echo "$branch" | tr '/' '-')" "detect_stale_branches" \
        "Branch '${branch}' is ${age_days} days old" \
        "Unmerged branch last committed ${age_days} days ago. Consider merging or deleting." \
        "$score"
    fi
  done < <(git branch --no-merged "$main_branch" 2>/dev/null || true)
}

# ─── Run all detectors (each wrapped for safety) ─────────────────────
for detector in detect_no_evals detect_stale_skills detect_uncommitted detect_missing_skillmd detect_stale_branches; do
  if ! "$detector"; then
    emit "${detector}-crash" "$detector" \
      "Detector ${detector} failed" \
      "The ${detector} check crashed or timed out. Investigate manually." \
      40
  fi
done

# ─── Output JSON array ───────────────────────────────────────────────
if (( ${#ITEMS[@]} == 0 )); then
  echo "[]"
else
  echo -n "["
  for i in "${!ITEMS[@]}"; do
    if (( i > 0 )); then echo -n ","; fi
    echo -n "${ITEMS[$i]}"
  done
  echo "]"
fi
