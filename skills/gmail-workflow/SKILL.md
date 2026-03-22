---
name: gmail-workflow
description: Manage email workflows via Gmail MCP — draft outreach emails, triage inbox, manage newsletter lists, and search messages. Use when asked to 'check email', 'draft an email', 'triage inbox', 'find emails about X', or 'manage newsletter'. Do NOT use for non-Gmail email providers, calendar management, or Google Drive operations.
license: MIT
metadata:
  author: jara-r-k
  version: 1.0.0
  mcp-server: gmail
---

# Gmail Workflow Skill

Companion skill for the Gmail MCP server. Provides structured workflows for common email operations including drafting, triaging, searching, and draft management.

## Available MCP Tools

This skill coordinates the following Gmail MCP tools:

- `gmail_search_messages` — Search messages by query (supports Gmail search syntax)
- `gmail_read_message` — Read full message content by ID
- `gmail_read_thread` — Read an entire email thread by thread ID
- `gmail_create_draft` — Create a new draft email
- `gmail_list_labels` — List all labels in the account
- `gmail_list_drafts` — List existing draft emails
- `gmail_get_profile` — Get the authenticated user's profile

## Instructions

### Drafting Emails

1. Confirm the recipient, subject, and intent with the user before composing.
2. Use `gmail_get_profile` to identify the sender's address for context.
3. Compose the email body in a professional tone unless otherwise instructed.
4. Use `gmail_create_draft` to save the email as a draft.
5. Present the full draft to the user for review — include To, Subject, and Body.
6. **Never send an email directly.** Always save as draft and let the user send manually.

### Triaging Inbox

1. Use `gmail_search_messages` with `is:unread` (or a user-specified query) to fetch recent messages.
2. For each message, use `gmail_read_message` to retrieve the subject, sender, and snippet.
3. Categorise messages into groups:
   - **Urgent** — time-sensitive or from key contacts
   - **Action required** — needs a reply or follow-up
   - **Informational** — newsletters, notifications, FYI
   - **Low priority** — marketing, promotions, automated
4. Present the categorised summary to the user with recommended actions (reply, archive, label).
5. If the user wants to act on a message, use the appropriate tool (e.g., `gmail_create_draft` for a reply).

### Searching Messages

1. Clarify the search intent with the user — sender, subject, date range, keywords.
2. Construct a Gmail search query using standard operators:
   - `from:`, `to:`, `subject:`, `has:attachment`, `after:`, `before:`, `is:unread`
3. Use `gmail_search_messages` with the constructed query.
4. If results are returned, summarise them in a table: Sender, Subject, Date, Snippet.
5. Offer to read full messages via `gmail_read_message` or threads via `gmail_read_thread`.

### Managing Drafts

1. Use `gmail_list_drafts` to retrieve all existing drafts.
2. Present drafts with their subject, recipient, and snippet.
3. Offer to update or discard drafts as needed.
4. When updating, use `gmail_create_draft` with the revised content.

## Error Handling

| Error | Response |
|---|---|
| **MCP disconnected** | Inform the user that the Gmail MCP server is not connected. Suggest reconnecting via the MCP configuration or restarting Claude Code. |
| **Rate limits** | If rate-limited by the Gmail API, wait briefly and retry. Inform the user if repeated attempts fail and suggest trying again in a few minutes. |
| **No results found** | Confirm the search query with the user. Suggest broadening the query (e.g., removing date filters, using partial keywords). Verify the correct account is connected via `gmail_get_profile`. |
| **Authentication failure** | Advise the user to re-authenticate the Gmail MCP server. Check that OAuth tokens are valid. |

## Examples

### "Draft a follow-up email to Sarah about the project proposal"

1. Search for recent messages from Sarah about the proposal using `gmail_search_messages`.
2. Read the relevant thread for context via `gmail_read_thread`.
3. Compose a follow-up draft referencing the prior conversation.
4. Save via `gmail_create_draft` and present for review.

### "Find all unread emails about the quarterly report"

1. Run `gmail_search_messages` with query `is:unread subject:quarterly report`.
2. Summarise results with sender, date, and snippet.
3. Offer to read any specific message in full.

### "Triage my inbox"

1. Fetch unread messages via `gmail_search_messages` with `is:unread`.
2. Read each message's content.
3. Categorise and present a prioritised summary.
4. Ask the user which messages to act on.

## Important

- **Never send emails without explicit user confirmation.** Always save as draft first.
- **Always show the full draft** (recipient, subject, body) before the user decides to send.
- **Respect privacy.** Do not log, store, or summarise email content beyond the current session.
- **Do not modify or delete existing emails** — this skill is for reading, searching, and drafting only.
- **Verify the account** via `gmail_get_profile` at the start of a session to ensure the correct account is active.
