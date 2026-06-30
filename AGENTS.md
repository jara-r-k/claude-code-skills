<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# claude-code-skills

## Purpose

Public repository of reusable Claude Code skills, agents, and example templates. Every artefact here is Markdown-only — no build step, no runtime dependencies. Skills are structured `SKILL.md` files that Claude Code loads automatically based on trigger phrases; agents are YAML-fronted `.md` definitions for spawning specialised subprocesses; examples are adaptation templates with `SKILL.md` + `references/` scaffolding.

## Key Files

| File | Description |
|------|-------------|
| `CLAUDE.md` | Project conventions, skill format rules, CI/CD contract, gotchas, and success criteria |
| `README.md` | Public-facing documentation — skills table, agents table, installation instructions, MCP requirements |
| `LICENSE` | MIT licence |
| `.claudeignore` | Paths excluded from Claude Code context loading |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `skills/` | SKILL.md files in kebab-case subdirectories, one per skill (see `skills/AGENTS.md`) |
| `agents/` | Reusable agent definition files (.md), spawnable subprocesses (see `agents/AGENTS.md`) |
| `examples/` | Adaptation templates — copy and customise for a project (see `examples/AGENTS.md`) |
| `scripts/` | CI helper and attention-check scripts (see `scripts/AGENTS.md`) |
| `.claude/` | Local Claude Code configuration (skills symlinks / local overrides) |
| `.omc/` | oh-my-claudecode orchestration state (do not modify manually) |

## For AI Agents

### Working In This Directory

- All content is Markdown-only. Never add package.json, Makefile, compiled artefacts, or runtime files.
- Use conventional commits: `feat:`, `fix:`, `docs:`, `chore:`.
- Australian English spelling throughout (colour, behaviour, organise, licence as noun).
- Run `/skill-compliance-checklist` on any modified SKILL.md before committing.
- Never write to `~/projects/raw/` — that layer is human-curated and protected by a PreToolUse hook.

### Testing Requirements

- No local test runner. CI validates via `.github/workflows/validate-skills.yml` on push/PR.
- Local check: invoke the `skill-compliance-checklist` skill against the target file.
- Key CI checks: YAML frontmatter presence, kebab-case names, description ≤ 1024 chars, no XML angle brackets, word count ≤ 5 000 words, error handling section present.

### Common Patterns

- Every skill lives at `skills/{kebab-case-name}/SKILL.md`.
- Large reference content goes in `skills/{name}/references/` (progressive disclosure), not inline in SKILL.md.
- Agent files use YAML frontmatter with `name`, `model` (Sonnet default), and `tools` list.
- Example directories mirror the skill structure: `examples/{name}/SKILL.md` + `references/`.

## Dependencies

### Internal

- `skills/skill-compliance-checklist/` — used to validate all other skills before publishing

### External

- `gh` CLI — required by `github-pr-review` skill and CI workflows
- Gmail MCP server — required by `gmail-workflow` skill
- Figma MCP server — required by `figma-handoff` skill

<!-- MANUAL: -->
