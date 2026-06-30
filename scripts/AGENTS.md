<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# scripts/

## Purpose

CI helper and attention-check scripts. Currently contains the per-project health scanner used by the oh-my-claudecode orchestration layer to surface actionable signals (missing evals, stale skills, uncommitted changes, missing SKILL.md, stale branches).

## Key Files

| File | Description |
|------|-------------|
| `attention-check.sh` | Bash scanner that emits a JSON array of attention signals; run by the OMC S4.6 harness to surface project health issues |

## For AI Agents

### Working In This Directory

- `attention-check.sh` writes JSON to stdout and diagnostic logs to stderr — preserve this contract.
- The script uses both GNU stat (`-c '%Y'`) and BSD stat (`-f '%m'`) fallbacks for cross-platform compatibility; do not remove either branch.
- Signal items use the schema: `{id, source, project, title, body, score, band}` where `band` is derived from `score` (≥80 critical, ≥50 today, ≥30 soon, else ambient).
- Each detector function is independently wrapped so a crash in one does not abort others.
- Do not add `set -e` to the script — detectors are expected to fail gracefully.

### Testing Requirements

- Run manually: `bash scripts/attention-check.sh 2>/dev/null | python3 -m json.tool` to verify valid JSON output.
- Add a new detector by defining a `detect_*` function and appending its name to the `for detector in ...` loop at the bottom.
- Validate that new detectors emit via the `emit` helper (not raw `echo`) to ensure consistent JSON schema.

### Common Patterns

- Scores are integers: use 75+ for blocking issues (missing SKILL.md), 50–74 for important (no evals), 30–49 for advisory (stale skill/branch), below 30 for informational.
- Use `json_escape` for any user-facing string before embedding in JSON.
- The `PROJECT` variable is set at the top of the script — update it if the project is renamed.

## Dependencies

### External

- Bash 4+ (macOS ships Bash 3; the script avoids `declare -A` and other Bash 4 features)
- Git — required by `detect_uncommitted` and `detect_stale_branches`
- `stat` (GNU or BSD) — required by `detect_stale_skills`

<!-- MANUAL: -->
