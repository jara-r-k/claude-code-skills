<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# examples/

## Purpose

Adaptation templates for common patterns. Each example provides a working SKILL.md plus a `references/` directory with customisation guides. Examples are designed to be copied into a project and edited — they contain placeholders (e.g., `PROJECT_PATH`, `APP_URL`) that must be replaced before use.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `persona-audit-pattern/` | Persona-driven UX audit template — discovery, verification, and fix phases via agent teams (see `persona-audit-pattern/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- Examples are templates, not production skills. They intentionally contain placeholders.
- When adding a new example, follow the same structure: `{name}/SKILL.md` + `{name}/references/` with at minimum a customisation guide.
- The SKILL.md in an example should pass compliance checks, but placeholder values are acceptable.
- Never fill in project-specific paths, URLs, or IDs in the template files — they must remain generic.

### Testing Requirements

- Verify that SKILL.md frontmatter is valid YAML and passes the structural checks in `skill-compliance-checklist`.
- Verify the `references/` directory contains at minimum one customisation guide file.

### Common Patterns

- Customisation guides in `references/` use numbered steps to walk through which placeholders to replace.
- Example SKILL.md files use `user-invocable: true` since they are intended for direct invocation after customisation.
- Agent templates in `references/` provide a full YAML + body block that can be dropped into a project's `.claude/agents/` directory.

<!-- MANUAL: -->
