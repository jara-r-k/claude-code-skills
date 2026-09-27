<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# examples/persona-audit-pattern/references/

## Purpose

Template for the project-specific agent the persona-audit skill hands off to. It must be copied into a project's `.claude/agents/` directory and customised before the skill can run.

## Key Files

| File | Description |
|------|-------------|
| `agent-template.md` | Agent frontmatter template (`name: your-project-persona-audit`, `model: sonnet`, tools Read/Write/Edit/Bash/Glob/Grep/Agent/WebSearch), agent body template (personas, four phases, focus-area table, rules), and a six-step customisation guide |

## For AI Agents

### Working In This Directory

- Template, not a live agent. Frontmatter and body sit in separate fenced blocks (the body uses a four-backtick fence); join them without the fences to make the real `.claude/agents/*.md` file.
- The shipped tools list has no browser or preview tool, so discovery agents cannot actually "navigate the app" until one is added (customisation step 2).
- Keep `Agent` in the tools list — it spawns the phase subagents.
- Keep `model: sonnet`; do not downgrade to haiku.
- Replace `[Your Project]` throughout and set the step-5 compilation check to the project's build (e.g. `npx tsc --noEmit`, `cargo check`, `go build ./...`).

### Testing Requirements

- After customising: valid frontmatter, and the dev server starts on `APP_URL`.
- Do a minimal run (one persona, one focus area) before a full audit.

### Common Patterns

- Personas: the template generates 3–5 (name, demographics, context, constraints, goal) but spawns only 3 discovery agents, one persona each — personas 4–5 go unused unless agents are added.
- Phase 1: 3 parallel discovery agents grading issues Critical/High/Medium/Low. Phase 2: 2 verification agents marking each CONFIRMED or FALSE POSITIVE. Phase 3: up to 3 fix agents working through confirmed issues. Phase 4: report.
- Default focus areas: `mobile` (375px), `accessibility`, `onboarding`, `edge-case`, `performance`.
- Changes stay local — never push from inside the audit.

<!-- MANUAL: -->
