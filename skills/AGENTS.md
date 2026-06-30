<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# skills/

## Purpose

Contains all published Claude Code skills. Each skill lives in its own kebab-case subdirectory with a mandatory `SKILL.md` entry point and an optional `references/` directory for large supporting content. Skills are Markdown-only, no build step required.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `skill-compliance-checklist/` | Audit and validate skills against Anthropic's official guide (see `skill-compliance-checklist/AGENTS.md`) |
| `figma-handoff/` | Design-to-code handoff workflow via Figma MCP (see `figma-handoff/AGENTS.md`) |
| `github-pr-review/` | Structured PR review methodology using `gh` CLI (see `github-pr-review/AGENTS.md`) |
| `gmail-workflow/` | Email drafting, triaging, and searching via Gmail MCP (see `gmail-workflow/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- Never create a skill directory with uppercase letters, spaces, or underscores in its name — kebab-case only.
- Every new skill directory must contain exactly `SKILL.md` (case-sensitive).
- If SKILL.md approaches 5 000 words, extract detail into a `references/` subdirectory.
- Run `/skill-compliance-checklist` before committing any new or modified skill.
- Bump the `metadata.version` field in frontmatter on every functional change.

### Testing Requirements

- No local runner. Validate locally by invoking `skill-compliance-checklist` against the target SKILL.md.
- CI (`.github/workflows/validate-skills.yml`) runs on every push and PR and will fail on frontmatter or word-count violations.

### Common Patterns

- SKILL.md frontmatter requires: `name` (kebab-case), `description` (WHAT + WHEN ≤ 1024 chars, no XML angle brackets), `license: MIT`.
- Descriptions should include negative triggers ("Do NOT use for…") to prevent over-triggering.
- Use `## Error Handling` and `## Examples` sections — CI warns if either is absent.

## Dependencies

### Internal

- `skill-compliance-checklist/` — baseline validator for all other skills in this directory

### External

- Figma MCP server (`figma-handoff`)
- Gmail MCP server (`gmail-workflow`)
- `gh` CLI (`github-pr-review`)

<!-- MANUAL: -->
