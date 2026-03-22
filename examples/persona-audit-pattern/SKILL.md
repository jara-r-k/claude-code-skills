---
name: persona-audit
description: Run a randomised persona-based UX audit of your application. Use when asked to 'audit', 'test personas', 'run a UX check', 'QA the app', 'persona audit', or 'test the app with fake users'. Generates unique user personas, discovers bugs and UX issues via agent teams, verifies them, implements fixes, and verifies fixes work. Do NOT use for non-web projects, general manual testing, deployment tasks, or code reviews.
user-invocable: true
metadata:
  author: your-name
  version: 1.0.0
---

# Persona Audit

Run persona-driven QA cycles using agent teams. This is a **template** — adapt it to your project by replacing the placeholders below.

## Configuration (customise these)

Before using this skill, update the following in your copy:

- **`PROJECT_PATH`**: Path to your project directory
- **`AGENT_PATH`**: Path to the agent definition file (see `references/agent-template.md`)
- **`APP_URL`**: Your local dev server URL (e.g., `http://localhost:3000`)
- **`FOCUS_AREAS`**: List of focus areas relevant to your app (e.g., `mobile`, `accessibility`, `checkout`, `onboarding`)

## Instructions

### Step 1: Locate the Agent Skill

The agent definition should be at:
`PROJECT_PATH/.claude/agents/your-persona-audit-agent.md`

Create this file using the template in `references/agent-template.md`.

### Step 2: Pass Arguments

If the user provides a focus area (e.g., `/persona-audit mobile`), pass it through to the agent. If no focus area is specified, use date-based randomisation to select from your configured focus areas:

```
focus_index = (day_of_month) % len(FOCUS_AREAS)
```

### Step 3: Expected Outputs

- Audit report written to `docs/audit-runs/YYYY-MM-DD-audit.md` in your project
- Bug fixes applied directly to source code
- Compilation/type-checking verified
- Screenshot evidence captured via preview tools (if available)

## Error Handling

### Agent file not found
- **Cause**: Project not at expected path or agent file not created
- **Solution**: Verify `PROJECT_PATH` exists and contains the agent definition

### Dev server fails to start
- **Cause**: Port in use or configuration issue
- **Solution**: Check for port conflicts. Verify dev server configuration.

### No project directory
- **Cause**: Skill invoked outside the project context
- **Solution**: Ensure the working directory is set to your project or specify the path explicitly.

## Examples

### Run with default focus
```
/persona-audit
```
Uses date-based rotation to select today's focus area.

### Focus on mobile testing
```
/persona-audit mobile
```
All personas tested at mobile viewport. Checks touch targets, overflow, and responsive layout.

### Focus on accessibility
```
/persona-audit accessibility
```
Tests screen reader compatibility, keyboard navigation, colour contrast, and motor impairment scenarios.

## Important

- The agent spawns multiple discovery, verification, and fix agents. Expect significant runtime.
- Changes are made locally only — do NOT push to remote.
- Always verify compilation passes after fixes.
- Adapt the persona generation to your application's user demographics.
