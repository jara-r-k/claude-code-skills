# Claude Code Skills

> **Root principles**: See ~/projects/CLAUDE.md §1–4 (Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution). They apply here — especially §2 (skills should be minimal, not speculative) and §4 (validate against compliance checklist before publishing).

Public repository of reusable Claude Code skills, agents, and examples.

## Structure

```
skills/             # SKILL.md files in kebab-case dirs
  {name}/SKILL.md   # Primary skill definition
  {name}/references/ # Supporting docs (optional)
agents/             # Reusable agent definitions (.md)
examples/           # Adaptation templates with SKILL.md + references/
.github/workflows/  # CI: validate-skills.yml
```

## Skill Format

Every SKILL.md requires YAML frontmatter:

```yaml
---
name: kebab-case-name        # required, kebab-case only
description: "< 1024 chars"  # required, no XML angle brackets
license: MIT
user-invocable: true|false
metadata:
  author: jara-r-k
  version: X.Y.Z
  based-on: "source reference"
---
```

Body must be < 5,000 words. Include `## Error Handling` and `## Examples` sections. Include negative triggers (what the skill should NOT do).

## Agent Format

Agents use YAML frontmatter with `name`, `model` (Sonnet default), and `tools` list. Body describes methodology and output format.

## Conventions

- All skills must pass `/skill-compliance-checklist` before publishing
- Kebab-case naming for all directories and skill names
- Australian English spelling throughout
- MIT licence for all public content
- Version bump in frontmatter on every functional change
- Git: conventional commits (feat:, fix:, docs:)

## Development Workflow

```bash
# No build step — Markdown only
# Validation is CI-only via GitHub Actions
# Local check: run skill-compliance-checklist skill against target
```

## Success Criteria Patterns

| Task | Done when |
|------|-----------|
| New skill | SKILL.md has valid frontmatter, < 5K words, includes error handling + examples + negative triggers, CI passes |
| Edit skill | Existing frontmatter preserved, version bumped, CI passes, compliance re-validated |
| New agent | Frontmatter has name/model/tools, methodology section present, CI passes |
| New example | SKILL.md + references/ dir, customisation guide in references, CI passes |

## Gotchas & Failure Modes

1. **Description > 1024 chars** — CI fails silently-ish. Check length before pushing.
2. **XML angle brackets in description** — `<tool>` in description field breaks parsing. Use backticks in body, never in frontmatter description.
3. **Non-kebab-case names** — CI rejects uppercase, underscores, spaces in `name:` field.
4. **Word count creep** — Skills over 5,000 words fail CI. Split into skill + references/ if approaching limit.
5. **Missing error handling section** — CI warns but doesn't fail. Include it anyway for compliance.
6. **Frontmatter delimiter** — Must be exactly `---` on line 1. No leading whitespace.
7. **Agent files skip word count** — CI only checks frontmatter for agents, not body length. Self-enforce.
8. **Wiki raw/ safety** — This project is part of the ~/projects/ LLM Wiki. Never write to ~/projects/raw/ — that layer is human-curated and immutable. See ~/projects/CLAUDE.md for the full wiki schema.

## Compact Instructions

When compacting, preserve: list of modified skills with compliance status, active gotchas, and version numbers.

## Wiki

Project entity: [[entities/claude-code-skills]] in ~/projects/wiki/
