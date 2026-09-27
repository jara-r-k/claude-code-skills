<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# examples/

## Purpose

Adaptation templates, not ready-to-use skills. Each example is a `SKILL.md` with placeholders (e.g. `PROJECT_PATH`, `APP_URL`) plus a `references/` directory holding the supporting template and customisation guide. Users copy an example into their own skills directory and fill in the placeholders there.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `persona-audit-pattern/` | Persona-driven UX audit template — discovery, verification, and fix phases via agent teams (see `persona-audit-pattern/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- Keep placeholders generic — never fill in project-specific paths, URLs, or IDs here.
- A new example needs `{name}/SKILL.md` plus `{name}/references/` with at least a customisation guide.
- CI validates `examples/*/SKILL.md` with the same hard checks as skills (frontmatter, kebab-case `name`, description length/angle brackets, word count). `references/` files are not checked.
- An example's frontmatter `name` may differ from its folder (`persona-audit` lives in `persona-audit-pattern/`); the install target directory should match `name`.
- Add new examples to the README Examples table.

### Testing Requirements

- Run the local CI command from the root `AGENTS.md`, then `/skill-compliance-checklist examples/{name}/SKILL.md` (placeholder values are acceptable).
- Confirm `references/` contains the customisation guide the SKILL.md points to.

### Common Patterns

- Customisation guides are numbered steps listing what to replace.
- Example SKILL.md files set `user-invocable: true` — they are invoked directly once customised.
- Agent templates in `references/` give the YAML frontmatter and the body as separate fenced blocks; join them (without the fences) to produce the `.claude/agents/*.md` file.

## Dependencies

### Internal

- `skills/skill-compliance-checklist/` — compliance audit for example SKILL.md files

<!-- MANUAL: -->
