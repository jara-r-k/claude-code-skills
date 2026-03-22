---
name: skill-compliance-checklist
description: Audit and validate Claude Code skills against Anthropic's official guide. Use when creating new skills, reviewing existing skills, running a compliance check, asked to 'audit skills', 'check skill quality', or 'validate SKILL.md'. Covers structure, frontmatter, descriptions, progressive disclosure, error handling, and testing. Do NOT use for writing skills from scratch, deploying applications, or general code reviews.
license: MIT
user-invocable: true
metadata:
  author: jara-r-k
  version: 1.1.0
  based-on: Anthropic Complete Guide to Building Skills (Jan 2026)
---

# Skill Compliance Checklist

Validate any Claude Code skill against Anthropic's official guide. Run this before uploading, after major changes, or during periodic audits.

## Instructions

### Step 1: Identify Skills to Audit

Scan these locations for SKILL.md files:
- `~/.claude/skills/*/SKILL.md` — global skills
- `~/.claude/scheduled-tasks/*/SKILL.md` — scheduled task skills
- `.claude/agents/*.md` — project-level agent skills
- Any path the user specifies

### Step 2: Structural Check

For each skill, verify:

1. **File naming**: Must be exactly `SKILL.md` (case-sensitive) inside a kebab-case folder
2. **YAML frontmatter**: Must have `---` delimiters, `name` (kebab-case), `description` (WHAT + WHEN)
3. **Description quality**:
   - Includes what the skill does
   - Includes when to use it (trigger phrases users would say)
   - Under 1024 characters
   - No XML angle brackets (`<` or `>`)
   - No "claude" or "anthropic" in the name
4. **Body structure**: Clear headings, actionable instructions, not vague
5. **Progressive disclosure**: Large reference content in `references/`, not inline
6. **Error handling**: Documents what to do when things fail
7. **Examples**: Concrete usage examples provided
8. **Word count**: SKILL.md body under 5,000 words

### Step 3: Content Quality Check

- Instructions are specific and actionable (not "validate things properly")
- Critical instructions use `## Important` or `## Critical` headers
- Hard-coded IDs/paths are externalised to CLAUDE.md or references
- Bundled resources are clearly referenced with file paths

### Step 4: Generate Report

For each skill, produce a compliance table:

```
| Criterion               | Status | Notes |
|-------------------------|--------|-------|
| Kebab-case folder name  |        |       |
| SKILL.md exact name     |        |       |
| YAML --- delimiters     |        |       |
| Name field kebab-case   |        |       |
| Description WHAT+WHEN   |        |       |
| Description < 1024 char |        |       |
| No XML in description   |        |       |
| Progressive disclosure  |        |       |
| Error handling section  |        |       |
| Examples section        |        |       |
| Body < 5,000 words      |        |       |
| No hard-coded IDs       |        |       |
```

### Step 5: Recommend Fixes

For any FAIL items, provide specific guidance referencing `references/compliance-template.md` and `references/guide-patterns.md`.

## Troubleshooting

### Skill won't upload
- **Error**: "Could not find SKILL.md" — rename file to exactly `SKILL.md`
- **Error**: "Invalid frontmatter" — check YAML `---` delimiters and formatting
- **Error**: "Invalid skill name" — use kebab-case only, no spaces or capitals

### Skill doesn't trigger
- Description too generic (e.g., "Helps with projects")
- Missing trigger phrases users would actually say
- Debug: Ask Claude "When would you use the [skill name] skill?"

### Skill triggers too often
- Add negative triggers: "Do NOT use for [unrelated topic]"
- Be more specific in description scope
- Clarify scope boundaries

### Instructions not followed
- Instructions too verbose — move detail to `references/`
- Critical steps buried — use `## Critical` headers
- Ambiguous language — replace "validate properly" with specific checks

## Examples

**Auditing a single skill:**
```
/skill-compliance-checklist ~/.claude/skills/persona-audit/SKILL.md
```

**Auditing all skills:**
```
/skill-compliance-checklist --all
```

**Quick check after creating a new skill:**
```
/skill-compliance-checklist ./my-new-skill/SKILL.md
```
