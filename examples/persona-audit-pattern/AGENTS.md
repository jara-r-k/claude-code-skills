<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# examples/persona-audit-pattern/

## Purpose

Template for a persona-driven UX audit skill. The skill hands off to a project-specific audit agent that generates personas and runs discovery, verification, and fix agent teams in sequential phases, then writes a dated report. To use it: copy the directory into a project's skills, replace the placeholders (`PROJECT_PATH`, `AGENT_PATH`, `APP_URL`, `FOCUS_AREAS`), and create the agent from `references/agent-template.md`.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Skill template (`name: persona-audit`, `user-invocable: true`): configuration placeholders, three-step workflow (locate agent → pass focus argument → expected outputs), error handling, three invocation examples. ~450 words |
| `references/agent-template.md` | Agent frontmatter + body templates and a six-step customisation guide (see `references/AGENTS.md`) |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `references/` | Agent template used to create the project agent (see `references/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- Placeholders stay generic here; fill them in only in the project copy.
- Frontmatter `name` (`persona-audit`) differs from the folder name. The README installs with `cp -r examples/persona-audit-pattern ~/.claude/skills/persona-audit`; if that directory already exists (e.g. an existing `persona-audit` skill), `cp -r` nests the copy one level down, where Claude Code will not load it. Choose an unused target and match `name` to it.
- The frontmatter has no `license: MIT`, unlike the repo convention (CI does not check it).
- Focus selection with no argument: `focus_index = (day_of_month) % len(FOCUS_AREAS)` — a deterministic daily rotation, not randomisation.

### Testing Requirements

- Run the local CI command from the root `AGENTS.md` and `/skill-compliance-checklist examples/persona-audit-pattern/SKILL.md`.
- After customising a copy: `PROJECT_PATH` exists, the agent file was created from the template, and the dev server answers on `APP_URL`.

### Common Patterns

- Phases run in order (discovery ×3 → verification ×2 → fix ×≤3 → report), agents within a phase in parallel — up to 8 subagents, at most 3 at once. Expect long runs.
- Report goes to `docs/audit-runs/YYYY-MM-DD-audit.md` in the target project.
- Fixes stay local (never push), and compilation/type-checking must pass afterwards.

## Dependencies

### Internal

- `references/agent-template.md` — the skill cannot run until the project agent exists

### External

- Claude Code with the `Agent` tool; a browser/preview MCP for app navigation (added during customisation)

<!-- MANUAL: -->
