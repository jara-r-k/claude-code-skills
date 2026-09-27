<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# claude-code-skills

## Purpose

Public (MIT) repository of reusable Claude Code skills, agents, and example templates. Published content is Markdown only: skills are `SKILL.md` files Claude Code loads by trigger phrase, agents are YAML-fronted `.md` subagent definitions, and examples are copy-and-customise templates. There is no build step and no package manifest. The only executable code is the CI validator (inline Bash in `.github/workflows/validate-skills.yml`) and `scripts/attention-check.sh`, a health scanner consumed by the `~/projects` Attention Hub.

## Key Files

| File | Description |
|------|-------------|
| `CLAUDE.md` | Canonical conventions — skill/agent frontmatter format, success criteria, gotchas. Read before editing any skill or agent |
| `README.md` | Public docs — skills/agents/examples tables, install commands, MCP requirements, CI summary |
| `LICENSE` | MIT licence |
| `.gitignore` | Ignores `.omc/`, `.claude/`, `.DS_Store`, and secret-bearing patterns (`.env*`, `*.pem`, `*.key`, `credentials.json`, …) |
| `.claudeignore` | Claude Code context exclusions (generic Node/build/log/env patterns; header comment mislabels the repo as TypeScript/Node) |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `skills/` | Published skills, one kebab-case directory each (see `skills/AGENTS.md`) |
| `agents/` | Subagent definition files (see `agents/AGENTS.md`) |
| `examples/` | Adaptation templates with placeholders (see `examples/AGENTS.md`) |
| `scripts/` | `attention-check.sh` — Attention Hub scanner, not used by CI (see `scripts/AGENTS.md`) |
| `.github/` | GitHub Actions CI (see `.github/AGENTS.md`) |
| `.claude/` | Optional gitignored local configuration; contents vary by checkout. |
| `.omc/` | Gitignored oh-my-claudecode session state. Generated — do not edit or document |

## For AI Agents

### Working In This Directory

- Keep published content Markdown-only — no `package.json`, Makefile, or build output.
- Follow `CLAUDE.md` for frontmatter and section rules; bump `metadata.version` on every functional skill change.
- Conventional commits (`feat:`, `fix:`, `docs:`, `chore:`); Australian English (colour, behaviour, organise, licence as noun).
- `/skill-compliance-checklist` only audits what it is pointed at: its `--all` scan covers `~/.claude/skills/`, `~/.claude/scheduled-tasks/`, and `.claude/agents/` — not this repo's `skills/`. Pass explicit paths (e.g. `skills/gmail-workflow/SKILL.md`).
- Keep the README tables in sync when adding, renaming, or removing a skill, agent, or example.
- `scripts/attention-check.sh` is invoked by path from outside this repo — do not move or rename it.
- Never write to `~/projects/raw/` (human-curated wiki layer, protected by a PreToolUse hook).

### Testing Requirements

- No local test runner. CI (`.github/workflows/validate-skills.yml`) runs on push/PR touching `skills/`, `agents/`, `examples/`, or `.github/workflows/`.
- Run the identical checks locally from the repo root:
  `awk '/^        run: \|/{f=1;next} f' .github/workflows/validate-skills.yml | sed 's/^          //' | bash`
- Hard failures: no `---` on line 1, missing or non-kebab `name:`, missing `description:`, description > 1024 chars or containing `<`/`>`, file > 5,000 words (whole file incl. frontmatter). Missing `## Error…`/`## Troubleshoot…` and `## Example…` headings only warn.
- Agents are checked only for the `---` delimiter and a non-empty `name:`; `references/` files are never validated.
- `scripts/`: `bash scripts/attention-check.sh 2>/dev/null | python3 -m json.tool`.

### Common Patterns

- Skill: `skills/{kebab-name}/SKILL.md`, optional `references/` for long material (progressive disclosure).
- Agent: `agents/{kebab-name}.md` with `name`, `description`, `license`, `model: sonnet`, `tools`.
- Example: `examples/{name}/SKILL.md` + `references/` customisation guide; placeholders stay generic.
- Keep `description:` on one line — CI reads only that line, so `description: >` fails and `description: |` escapes the length check.

## Dependencies

### Internal

- `skills/skill-compliance-checklist/` — manual pre-publish validator for every other skill and example

### External

- GitHub Actions (`ubuntu-latest`, `actions/checkout@v4`) — CI
- `gh` CLI — `github-pr-review` skill only (CI does not use it)
- Figma MCP server (`figma-handoff`), Gmail MCP server (`gmail-workflow`)
- `~/projects/scripts/attention-collect.sh` (Attention Hub) — consumes `scripts/attention-check.sh`

<!-- MANUAL: -->
