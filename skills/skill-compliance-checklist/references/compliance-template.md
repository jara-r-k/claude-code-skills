# Skill Compliance Template

Use this template when creating or upgrading a skill to guide compliance.

## YAML Frontmatter Template

```yaml
---
name: your-skill-name
description: [What it does — 1 sentence]. Use when [trigger phrases — specific tasks users say]. [Key capabilities — what it handles].
license: MIT
metadata:
  author: your-name
  version: 1.0.0
  mcp-server: server-name  # if applicable
---
```

### Description Format

`[WHAT] + [WHEN] + [CAPABILITIES]`

**Good example:**
```
description: Analyses Figma design files and generates developer handoff documentation. Use when user uploads .fig files, asks for 'design specs', 'component documentation', or 'design-to-code handoff'. Supports multi-page designs and component libraries.
```

**Bad examples:**
- "Helps with projects." (too vague, no triggers)
- "Creates sophisticated multi-page documentation systems." (no triggers)
- "Implements the Project entity model with hierarchical relationships." (too technical, no user triggers)

## Body Structure Template

```markdown
# Your Skill Name

Brief overview of what this skill does and its value.

## Instructions

### Step 1: [First Major Step]
Clear explanation of what happens.
[Specific commands or tool calls if applicable]

### Step 2: [Second Major Step]
[Continue pattern...]

## Error Handling

### [Common Error 1]
- **Cause**: Why it happens
- **Solution**: How to fix it

### [Common Error 2]
- **Cause**: Why it happens
- **Solution**: How to fix it

## Examples

### Example 1: [Common Scenario]
**User says**: "..."
**Actions**:
1. ...
2. ...
**Result**: ...

### Example 2: [Edge Case]
**User says**: "..."
**Actions**:
1. ...
**Result**: ...

## Important

- [Critical rules or constraints]
- [Safety guardrails]
```

## Progressive Disclosure Checklist

- [ ] **Level 1 (YAML frontmatter)**: Just enough for Claude to know WHEN to load
- [ ] **Level 2 (SKILL.md body)**: Full instructions, kept under 5,000 words
- [ ] **Level 3 (references/)**: Detailed docs, API guides, templates — loaded only when needed

## Testing Checklist

### Trigger Tests
- [ ] Triggers on obvious tasks (direct request)
- [ ] Triggers on paraphrased requests (indirect wording)
- [ ] Does NOT trigger on unrelated topics

### Functional Tests
- [ ] Valid outputs generated
- [ ] Tool/API calls succeed
- [ ] Error handling works as documented
- [ ] Edge cases produce reasonable results

### Performance
- [ ] Workflow completes in reasonable number of tool calls
- [ ] No unnecessary back-and-forth with user
- [ ] Consistent results across sessions
