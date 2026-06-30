<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# skills/github-pr-review/

## Purpose

Structured PR review skill using the `gh` CLI. Follows a six-step methodology: read PR context, check for OWASP Top 10 security issues, evaluate code quality, assess performance implications, check test coverage, and write a structured review summary. Produces findings categorised as Critical, Suggestions, or Nits with a final APPROVE / REQUEST_CHANGES / COMMENT verdict.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Full skill definition — `gh` CLI tool catalogue, six-step review methodology, error handling table (PR not found, no permissions, large diffs, failing CI), three worked examples, and critical rules |

## For AI Agents

### Working In This Directory

- This skill requires the `gh` CLI to be installed and authenticated (`gh auth status`).
- Current version: `1.0.0`. Bump on any change to the review methodology or output format.
- Reviews must never be submitted (`gh pr review`) without explicit user confirmation — always present the summary first.
- Security findings matching OWASP Top 10 must always be flagged as Critical severity.

### Testing Requirements

- Validate SKILL.md with `/skill-compliance-checklist` before committing changes.
- Manual test: run against a real PR number and verify the six-step methodology is followed and all output format sections are present.

### Common Patterns

- For PRs over 1 000 lines, use `gh api repos/{owner}/{repo}/pulls/{number}/files` to review file-by-file rather than the full diff at once.
- The output format requires at minimum a `### Positives` section — never omit it.
- Omit severity sections that have no findings (e.g., if there are no Critical findings, skip that heading).
- Reference file names and line numbers for every finding — generic feedback is not acceptable.

## Dependencies

### External

- `gh` CLI (GitHub CLI) — must be installed and authenticated

<!-- MANUAL: -->
