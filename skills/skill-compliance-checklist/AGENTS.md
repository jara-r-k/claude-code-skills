<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# skills/skill-compliance-checklist/

## Purpose

Meta-skill that audits `SKILL.md` files against Anthropic's "Complete Guide to Building Skills for Claude" (Jan 2026): structure, frontmatter, description quality, progressive disclosure, error handling, examples, word count, and hard-coded IDs. Produces a 12-row PASS/FAIL table per skill and fix recommendations drawn from `references/`. The repo's manual pre-publish gate; `user-invocable: true` (`/skill-compliance-checklist`).

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Five-step audit (identify → structural check → content check → report table → recommend fixes), troubleshooting for upload/trigger/instruction problems, three invocation examples. v1.1.0, ~580 words |
| `references/compliance-template.md` | Frontmatter and body templates, progressive-disclosure levels, trigger/functional/performance test checklists |
| `references/guide-patterns.md` | The guide's five skill patterns and three use-case categories |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `references/` | Material loaded on demand when recommending fixes (see `references/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- Step 1 scans only `~/.claude/skills/*/SKILL.md`, `~/.claude/scheduled-tasks/*/SKILL.md`, `.claude/agents/*.md`, and user-given paths. `--all` therefore never reaches this repo's `skills/` or `examples/` — pass explicit paths, e.g. `/skill-compliance-checklist skills/gmail-workflow/SKILL.md`.
- The 12-row table in Step 4 is the canonical criteria list. Changing a criterion is a functional change: bump `metadata.version` (currently 1.1.0) and keep `references/compliance-template.md` consistent.
- Its error-handling section is `## Troubleshooting`, which satisfies the CI heading check.
- Several criteria go beyond CI (no "claude"/"anthropic" in the name, no hard-coded IDs, `## Important`/`## Critical` headers); CI enforces only the frontmatter, description, and word-count rows.

### Testing Requirements

- Self-audit: `/skill-compliance-checklist skills/skill-compliance-checklist/SKILL.md` should pass every row.
- Negative check: a description > 1024 chars, `<`/`>` in the description, no error-handling section, or > 5,000 words must each FAIL.
- Run the local CI command from the root `AGENTS.md`.

### Common Patterns

- Output: one compliance table per skill, then fixes citing `references/compliance-template.md` and `references/guide-patterns.md` by filename.

## Dependencies

### Internal

- Audits `figma-handoff`, `github-pr-review`, `gmail-workflow`, and `examples/persona-audit-pattern`

<!-- MANUAL: -->
