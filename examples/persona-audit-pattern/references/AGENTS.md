<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# examples/persona-audit-pattern/references/

## Purpose

Supporting template for the persona-audit-pattern example. Contains the full agent definition (YAML frontmatter + methodology body) that must be copied into a project's `.claude/agents/` directory and customised before the persona-audit skill can run.

## Key Files

| File | Description |
|------|-------------|
| `agent-template.md` | Complete agent definition template — YAML block (`name`, `model: sonnet`, `tools` list including `Agent`), four-phase audit workflow (discovery × 3 agents, verification × 2, fix × 3, report), focus area table, and a six-step customisation guide |

## For AI Agents

### Working In This Directory

- This file is a template, not a live agent — do not treat it as an executable definition.
- When adapting for a project: replace `[Your Project]` throughout, update the tools list to include any project-specific MCP tools (e.g., Preview MCP), customise focus areas to match the app's key user flows, and update the compilation check command to match the project's build system.
- The agent requires the `Agent` tool in its tools list to spawn the discovery/verification/fix subagents — do not remove it.

### Testing Requirements

- After copying and customising, verify the agent file is valid YAML frontmatter and that the project's dev server starts on the configured `APP_URL`.
- Confirm the agent can spawn subagents by running a minimal audit (single persona, single focus area) before a full run.

### Common Patterns

- Model for the spawned agent: `sonnet` (do not downgrade to haiku — standing rule).
- Discovery phase: 3 parallel agents, each with a different persona.
- Verification phase: 2 parallel agents confirming or rejecting each discovery finding.
- Fix phase: up to 3 parallel agents, one per confirmed issue.
- All changes made locally only — never push to remote from within the audit agent.

<!-- MANUAL: -->
