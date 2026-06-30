<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# examples/persona-audit-pattern/

## Purpose

Template for a persona-driven UX audit skill. Generates randomised user personas, runs discovery/verification/fix agent teams in parallel phases, and writes a structured audit report. This directory is a starting point — copy it to a project, replace all placeholders (`PROJECT_PATH`, `AGENT_PATH`, `APP_URL`, `FOCUS_AREAS`), and create the project-specific agent from `references/agent-template.md`.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Skill template — configuration placeholders, four-step invocation workflow, error handling, and usage examples |
| `references/agent-template.md` | Full agent definition template (YAML frontmatter + body) for the project-specific persona audit agent, including four-phase workflow (discovery, verification, fix, report) and focus area table |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `references/` | Supporting templates loaded on demand (see `references/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- This is a template — all placeholder values (`PROJECT_PATH`, `APP_URL`, etc.) must remain generic in this directory. Fill them in only in the project copy.
- The SKILL.md is `user-invocable: true` and triggers on: 'audit', 'test personas', 'run a UX check', 'QA the app', 'persona audit', 'test the app with fake users'.
- The agent template spawns up to 3 + 2 + 3 = 8 parallel subagents; expect significant runtime.
- Focus area selection uses date-based rotation: `focus_index = (day_of_month) % len(FOCUS_AREAS)`.

### Testing Requirements

- Validate SKILL.md with `/skill-compliance-checklist`.
- After customising for a project, verify: `PROJECT_PATH` exists, the agent file is created from `agent-template.md`, and the dev server starts on `APP_URL`.

### Common Patterns

- Audit reports are written to `docs/audit-runs/YYYY-MM-DD-audit.md` in the target project.
- Agent phases run in sequence (discovery → verification → fix → report); within each phase, agents run in parallel.
- The fix phase applies changes locally only — never push to remote.
- Always verify compilation/type-checking passes after the fix phase.

## Dependencies

### Internal

- `references/agent-template.md` — required to create the project-specific agent before the skill can run

<!-- MANUAL: -->
