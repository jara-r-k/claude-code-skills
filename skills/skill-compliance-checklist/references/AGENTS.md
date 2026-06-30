<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# skills/skill-compliance-checklist/references/

## Purpose

Supporting reference documents for the skill-compliance-checklist skill. Loaded on demand (progressive disclosure) — not embedded inline in SKILL.md to keep the main skill under 5 000 words. Contains the canonical YAML frontmatter template and three official skill patterns from Anthropic's guide.

## Key Files

| File | Description |
|------|-------------|
| `compliance-template.md` | YAML frontmatter template, body structure template, progressive disclosure checklist (Level 1/2/3), and trigger/functional/performance testing checklists |
| `guide-patterns.md` | Five official Anthropic skill patterns: sequential workflow orchestration, multi-MCP coordination, iterative refinement, context-aware tool selection, domain-specific intelligence — with use case categories |

## For AI Agents

### Working In This Directory

- Files here are reference-only — do not restructure or rename them without updating the SKILL.md references.
- `compliance-template.md` is cited by name in the skill's "Recommend Fixes" step — keep the filename stable.
- `guide-patterns.md` is cited by name in the same step — keep the filename stable.
- When Anthropic publishes a new guide version, update `guide-patterns.md` and bump `skill-compliance-checklist` version to reflect the new baseline.

### Testing Requirements

- No automated tests. Verify manually that the templates in `compliance-template.md` match the criteria checked in `SKILL.md`.

### Common Patterns

- Description format rule from `compliance-template.md`: `[WHAT] + [WHEN] + [CAPABILITIES]`.
- Progressive disclosure levels: Level 1 = frontmatter (when to load), Level 2 = SKILL.md body (how to execute), Level 3 = references/ (detailed supporting docs).
- The three use case categories in `guide-patterns.md`: Document & Asset Creation, Workflow Automation, MCP Enhancement.

<!-- MANUAL: -->
