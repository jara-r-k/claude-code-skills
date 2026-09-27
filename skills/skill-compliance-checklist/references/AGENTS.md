<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# skills/skill-compliance-checklist/references/

## Purpose

Reference material for the skill-compliance-checklist skill, kept out of `SKILL.md` (progressive disclosure) and loaded only when recommending fixes. Holds the frontmatter/body template and a summary of the five official skill patterns and three use-case categories from Anthropic's Jan 2026 guide.

## Key Files

| File | Description |
|------|-------------|
| `compliance-template.md` | Frontmatter template, description formula `[WHAT] + [WHEN] + [CAPABILITIES]` with good/bad examples, body template (Instructions / Error Handling / Examples / Important), progressive-disclosure checklist (Levels 1–3), trigger/functional/performance test checklists |
| `guide-patterns.md` | Five patterns (sequential workflow orchestration, multi-MCP coordination, iterative refinement, context-aware tool selection, domain-specific intelligence) and three use-case categories (Document & Asset Creation, Workflow Automation, MCP Enhancement) — listed separately, not mapped to each other |

## For AI Agents

### Working In This Directory

- `SKILL.md` Step 5 cites both files by name — keep filenames stable or update `SKILL.md` in the same change.
- The frontmatter template here omits `user-invocable` and `metadata.based-on`, which the root `CLAUDE.md` Skill Format includes; update both together if the convention changes.
- When Anthropic revises the guide, update `guide-patterns.md` and bump the parent skill's `metadata.version`.
- CI does not validate these files.

### Testing Requirements

- No automated tests. After editing, check that `compliance-template.md` still yields a `SKILL.md` that passes the parent skill's 12 criteria and the local CI command in the root `AGENTS.md`.

### Common Patterns

- Progressive disclosure: Level 1 = frontmatter (when to load), Level 2 = `SKILL.md` body (how to execute, < 5,000 words), Level 3 = `references/` (loaded on demand).

<!-- MANUAL: -->
