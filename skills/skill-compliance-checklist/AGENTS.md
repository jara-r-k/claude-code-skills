<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# skills/skill-compliance-checklist/

## Purpose

The meta-skill that validates all other skills in this repository. Audits SKILL.md files against Anthropic's official guide (Jan 2026), checking frontmatter structure, description quality, progressive disclosure, error handling, examples, and word count. Run this before publishing any skill.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Skill definition — step-by-step audit instructions, compliance table template, troubleshooting, and examples |
| `references/compliance-template.md` | YAML frontmatter template + body structure template + progressive disclosure and testing checklists |
| `references/guide-patterns.md` | Five official skill patterns from Anthropic's guide (sequential workflow, multi-MCP coordination, iterative refinement, context-aware tool selection, domain-specific intelligence) |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `references/` | Supporting reference documents loaded on demand (see `references/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- This skill is `user-invocable: true` — it can be triggered directly with `/skill-compliance-checklist`.
- To audit a single skill: `/skill-compliance-checklist path/to/SKILL.md`.
- To audit all skills: `/skill-compliance-checklist --all`.
- The compliance table in SKILL.md is the canonical checklist — do not modify criteria without bumping `metadata.version`.
- Current version: `1.1.0`. Bump to `1.2.0` on any functional change to audit criteria.

### Testing Requirements

- Verify the skill correctly identifies known violations: description over 1024 chars, XML angle brackets in description, missing error handling section, word count over 5 000.
- Self-audit: run this skill against its own SKILL.md to confirm it passes all criteria.

### Common Patterns

- Audit output is a per-skill compliance table (PASS/FAIL per criterion) followed by specific fix recommendations.
- Fix recommendations reference `references/compliance-template.md` and `references/guide-patterns.md` by name.
- The five patterns in `guide-patterns.md` map to use case categories: document/asset creation, workflow automation, MCP enhancement.

## Dependencies

### Internal

- Used to validate: `figma-handoff`, `github-pr-review`, `gmail-workflow`, and `examples/persona-audit-pattern`

<!-- MANUAL: -->
