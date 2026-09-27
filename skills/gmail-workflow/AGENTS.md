<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# skills/gmail-workflow/

## Purpose

Companion skill for the Gmail MCP server with four workflows: drafting (always saved as drafts, never sent), inbox triage into four urgency groups, search with Gmail operators, and draft listing/revision. Read, search, and draft only — it never sends, modifies, or deletes mail.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Seven-tool Gmail MCP catalogue, four workflows, error table (MCP disconnected, rate limits, no results, auth failure), three examples, `## Important` rules. v1.0.0, `mcp-server: gmail`, ~760 words |

## For AI Agents

### Working In This Directory

- Hard rule: never send email. Every compose or reply goes through `gmail_create_draft`, and the full draft (To, Subject, Body) is shown to the user.
- Call `gmail_get_profile` at session start to confirm the active account.
- Description/body mismatch: the description promises "manage newsletter lists" and triggers on 'manage newsletter', but no newsletter workflow exists. Add one or drop it from the description (and bump the version).
- "Managing Drafts" offers to update or discard drafts, but no update or delete tool is catalogued: updating via `gmail_create_draft` leaves the old draft in place, and discarding is impossible with these tools (and conflicts with "do not modify or delete"). Tell the user rather than implying it happened.
- `gmail_list_labels` is catalogued but unused by any workflow.

### Testing Requirements

- Run the local CI command from the root `AGENTS.md` and `/skill-compliance-checklist skills/gmail-workflow/SKILL.md`.
- Manual, against a live Gmail MCP: drafts are saved and never sent, triage yields the four groups, searches build valid operator queries.

### Common Patterns

- Search operators: `from:`, `to:`, `subject:`, `has:attachment`, `after:`, `before:`, `is:unread`.
- Triage groups: Urgent, Action required, Informational, Low priority.
- Privacy: do not log, store, or summarise email content beyond the current session.

## Dependencies

### External

- Gmail MCP server with valid OAuth credentials (tool names follow the `gmail_*` convention above)

<!-- MANUAL: -->
