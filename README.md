# Claude Code Skills & Agents

A collection of reusable [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills and agent templates for common development workflows.

## What's Included

### Skills

Skills are structured instructions that Claude Code loads automatically based on what you're doing.

| Skill | Description | Requires |
|-------|-------------|----------|
| **[skill-compliance-checklist](skills/skill-compliance-checklist/)** | Audit and validate Claude Code skills against Anthropic's official guide | — |
| **[gmail-workflow](skills/gmail-workflow/)** | Draft, triage, and search emails via Gmail MCP | Gmail MCP server |
| **[github-pr-review](skills/github-pr-review/)** | Structured PR reviews covering security, quality, performance, and tests | `gh` CLI |
| **[figma-handoff](skills/figma-handoff/)** | Design-to-code handoff workflow using Figma MCP | Figma MCP server |

### Agents

Agents are specialised subprocesses that Claude Code spawns for focused tasks.

| Agent | Description | Model |
|-------|-------------|-------|
| **[code-reviewer](agents/code-reviewer.md)** | Analyses code changes for quality, security, performance, and maintainability | Sonnet |
| **[project-setup](agents/project-setup.md)** | Scaffolds CLAUDE.md and .claude/ configuration for new projects | Sonnet |

### Examples

Templates you can adapt for your own projects.

| Example | Description |
|---------|-------------|
| **[persona-audit-pattern](examples/persona-audit-pattern/)** | Persona-driven UX audit template using agent teams — discovery, verification, and fix phases |

## Installation

### Skills

Copy any skill folder into your Claude Code skills directory:

```bash
# Install a single skill
cp -r skills/skill-compliance-checklist ~/.claude/skills/

# Install all skills
cp -r skills/* ~/.claude/skills/
```

### Agents

Copy agent files into your global or project-level agents directory:

```bash
# Global agents (available in all projects)
cp agents/code-reviewer.md ~/.claude/agents/
cp agents/project-setup.md ~/.claude/agents/

# Project-level agents (available in one project)
cp agents/code-reviewer.md your-project/.claude/agents/
```

### Examples

Copy the example into your project and customise:

```bash
# Copy the persona audit template
cp -r examples/persona-audit-pattern ~/.claude/skills/persona-audit

# Then edit SKILL.md and references/agent-template.md
# to match your project's paths, URLs, and focus areas
```

### Claude.ai Upload

Skills can also be uploaded to Claude.ai:

1. Go to **Settings > Capabilities > Skills**
2. Upload the `SKILL.md` file (and any `references/` files)
3. The skill will be available in your Claude.ai conversations

## MCP Server Requirements

Some skills coordinate with MCP servers. You'll need to configure these separately:

- **Gmail MCP** — Required for `gmail-workflow`. See [Gmail MCP setup](https://github.com/anthropics/anthropic-quickstarts/tree/main/mcp-servers/gmail).
- **Figma MCP** — Required for `figma-handoff`. Available as a first-party Claude.ai integration.

Skills that don't require MCP servers (like `skill-compliance-checklist` and `github-pr-review`) work out of the box.

## Customisation

All skills and agents are designed to be forked and customised:

- **Skills**: Edit the `SKILL.md` to adjust instructions, add project-specific rules, or change trigger phrases
- **Agents**: Modify the tool list, model, or methodology to suit your workflow
- **Examples**: Follow the customisation guide in each example's `references/` directory

## Skill Compliance

Every skill in this repo passes the [skill-compliance-checklist](skills/skill-compliance-checklist/) audit, which validates against Anthropic's official guide. Run it on your own skills:

```
/skill-compliance-checklist --all
```

## CI/CD Validation

This repo includes a [GitHub Actions workflow](.github/workflows/validate-skills.yml) that automatically validates all skills and agents on push and PR. It checks:

- YAML frontmatter presence and structure
- Kebab-case naming
- Description length (< 1024 chars) and format
- No XML angle brackets in descriptions
- Word count (< 5,000 words)
- Error handling and examples sections

Fork this repo and the validation runs automatically on your changes.

## Licence

[MIT](LICENSE)
