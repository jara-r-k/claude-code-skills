<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# skills/gmail-workflow/

## Purpose

Email management skill for the Gmail MCP server. Covers four workflows: drafting outreach emails (always saved as drafts, never sent directly), triaging the inbox with urgency categorisation, searching messages using Gmail query syntax, and managing existing drafts. Coordinates seven Gmail MCP tools.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Full skill definition — MCP tool catalogue, four workflow procedures, error handling table (MCP disconnected, rate limits, no results, auth failure), three worked examples, and critical rules |

## For AI Agents

### Working In This Directory

- This skill requires the Gmail MCP server to be connected (`mcp-server: gmail` in frontmatter).
- Current version: `1.0.0`. Bump on any change to the workflow procedures or MCP tool list.
- Emails must never be sent directly — always use `gmail_create_draft` and let the user send manually. This is a hard constraint.
- Call `gmail_get_profile` at the start of a session to confirm the correct account is active.

### Testing Requirements

- Validate SKILL.md with `/skill-compliance-checklist` before committing changes.
- Manual test: verify the draft workflow saves to drafts without sending, the triage workflow categorises messages into the four defined groups, and the search workflow constructs valid Gmail query syntax.

### Common Patterns

- Gmail search operators used: `from:`, `to:`, `subject:`, `has:attachment`, `after:`, `before:`, `is:unread`.
- Inbox triage categories: Urgent, Action required, Informational, Low priority.
- When updating a draft, use `gmail_create_draft` with the revised content (no update-in-place tool exists).
- Do not log, store, or summarise email content beyond the current session — privacy constraint.

## Dependencies

### External

- Gmail MCP server (requires OAuth token configuration)

<!-- MANUAL: -->
