<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# .github/workflows/

## Purpose

CI for the repo: one GitHub Actions workflow that structurally validates every skill, example, and agent file. It is the only automated gate — a single inline Bash step on `ubuntu-latest` after `actions/checkout@v4`, with no external tooling.

## Key Files

| File | Description |
|------|-------------|
| `validate-skills.yml` | "Validate Skills" — on push/pull_request touching `skills/**`, `agents/**`, `examples/**`, or `.github/workflows/**`, checks `skills/*/SKILL.md`, `examples/*/SKILL.md`, and `agents/*.md` (minus `AGENTS.md`); exits 1 on any hard failure |

## For AI Agents

### Working In This Directory

- Hard checks (increment `errors`, exit 1): line 1 exactly `---`; `name:` present with no uppercase, `_`, or spaces (a trailing space counts); `description:` present, ≤ 1024 chars, no `<`/`>`; `wc -w` of the whole file ≤ 5,000. Agents get only the `---` check and a non-empty `name:`.
- Warnings only: no `## error`/`## troubleshoot` heading, no `## example` heading (case-insensitive substring match).
- Parsing is line-based `grep`, not YAML: `name:`/`description:` are the first matching lines anywhere in the file, and only the description's first line is read — `description: >` fails the angle-bracket check, `description: |` escapes the length check.
- Globs are one level deep: `references/**` and nested files are never validated, and changes to root files, `scripts/`, or `README.md` do not trigger the workflow.
- The per-file log prints `OK (N words)` even after that file's `FAIL` lines — trust the final summary line and exit code.
- Only `agents/*.md` can match a non-agent file; the `AGENTS.md` basename skip (commit f0911af) exists for the deepinit map there. Any other non-agent `.md` in `agents/` will fail.
- GitHub Actions loads only `.yml`/`.yaml` files here, so this `AGENTS.md` is inert — but editing it still triggers a run via the path filter.

### Testing Requirements

- Run the step locally from the repo root before pushing:
  `awk '/^        run: \|/{f=1;next} f' .github/workflows/validate-skills.yml | sed 's/^          //' | bash`
  The extraction assumes `run: |` at 8-space and the script body at 10-space indentation — adjust it if the YAML is reindented.
- After changing a check, prove it fails a deliberately bad file in a scratch copy before relying on it.

### Common Patterns

- Errors print `  FAIL: …` and increment `errors`; warnings print `  WARN: …` and never affect the exit code.
- Add new rules inside the existing loops rather than new jobs — the whole check is one shell step.

## Dependencies

### External

- GitHub-hosted `ubuntu-latest` runner, `actions/checkout@v4`, POSIX tools (`grep`, `sed`, `wc`, `head`)

<!-- MANUAL: -->
