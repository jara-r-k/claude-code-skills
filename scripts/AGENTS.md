<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# scripts/

## Purpose

Holds `attention-check.sh`, this repo's per-project detector for the `~/projects` Attention Hub (header: "S4.6"). It is not part of CI. The Hub collector, `~/projects/scripts/attention-collect.sh`, runs it as `bash <repo>/scripts/attention-check.sh 2>/dev/null` from `~/projects` and merges the output into `wiki/attention/state.json`.

## Key Files

| File | Description |
|------|-------------|
| `attention-check.sh` | Bash scanner with five detectors (missing evals, stale skills, uncommitted changes, missing SKILL.md, stale unmerged branches); prints a JSON array of signals to stdout, `[scan]` logs to stderr |

## For AI Agents

### Working In This Directory

- External contract: the collector depends on this exact path, exit status 0, and a JSON array on stdout. A non-zero exit or invalid JSON becomes a critical `scanner_failed` item in the Hub. Do not rename or move the file, and never print anything but the array to stdout.
- Shebang is `#!/usr/bin/env bash`, but the script also runs under macOS `/bin/bash` 3.2 (verified 2026-09-27). Keep it that way — no `declare -A`, `mapfile`, `${var,,}`, or other Bash 4+ features.
- Keep `set -uo pipefail` without `-e`; detectors are meant to fail softly.
- The runner loop reports any detector returning non-zero as a crash (score 40). End every detector on a successful command or `return 0` — a bare `return` after a failed test (e.g. `detect_stale_skills` when `skills/` is missing) counts as a crash.
- `emit` passes `title` and `body` through `json_escape`, but not `id`. Branch or skill names containing `"` or `\` would yield invalid JSON — sanitise any new `id` input.
- `PROJECT_ROOT` is derived from the script's own location, so any cwd works.
- `PROJECT` is hard-coded at the top of the script and embedded in every signal — update it if the project is renamed.

### Testing Requirements

- `bash scripts/attention-check.sh 2>/dev/null | python3 -m json.tool` must parse; also run it once with `/bin/bash` to catch Bash 4-only syntax.
- To add a detector: define `detect_*`, emit only via `emit`, and append its name to the `for detector in …` loop at the bottom.

### Common Patterns

- Signal schema: `{id, source, project, title, body, score, band}`; `band` from `score`: ≥80 critical, ≥50 today, ≥30 soon, else ambient.
- Current scores: missing SKILL.md 75; no `eval/`/`test/`/`tests/` dir 55; stale skill 35/45/60 at 30/90/180 days since newest file mtime; uncommitted files 25/40/55/70 at 1/5/10/20 files; stale branch 30/40/50; detector crash 40; setup errors 15–20. Nothing reaches 80, so this script never emits `critical` itself.
- No skill currently has an eval directory, so each run raises one `today` signal per skill until evals are added.
- Staleness uses the newest mtime of any file in the skill directory, so editing a skill's `AGENTS.md` resets it even when `SKILL.md` is untouched (the 2026-09-27 deepinit pass cleared all four stale-skill signals this way), and a fresh clone looks fresh. Key on `SKILL.md` or `git log` if that matters.
- Stale-branch detection resolves the default branch from `origin/HEAD` and falls back to `main`; this repo uses `master`, so where `origin/HEAD` is unset the check silently finds nothing.

## Dependencies

### External

- Bash 3.2+, git, `find`, `date`, `stat` (GNU `-c '%Y'` tried first, then BSD `-f '%m'`)
- Consumer: `~/projects/scripts/attention-collect.sh` (outside this repo)

<!-- MANUAL: -->
