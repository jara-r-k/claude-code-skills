---
name: github-pr-review
description: Review GitHub pull requests with a consistent methodology — code quality, security, performance, and test coverage analysis. Use when asked to 'review a PR', 'check this pull request', 'review PR #123', or 'give feedback on this PR'. Do NOT use for creating PRs, managing issues, or repository administration.
license: MIT
metadata:
  author: jara-r-k
  version: 1.0.0
---

# GitHub PR Review Skill

Companion skill for GitHub via the `gh` CLI. Provides a structured, consistent methodology for reviewing pull requests covering security, code quality, performance, and test coverage.

## Available Tools

This skill uses the `gh` CLI for all GitHub interactions:

- `gh pr view <number>` — View PR metadata (title, author, description, status)
- `gh pr diff <number>` — Retrieve the full diff for a PR
- `gh pr checks <number>` — View CI/CD check status
- `gh pr review <number>` — Submit a review (approve, request changes, comment)
- `gh api repos/{owner}/{repo}/pulls/{number}/comments` — Read existing review comments
- `gh api repos/{owner}/{repo}/pulls/{number}/files` — List changed files

## Instructions

### Structured Review Methodology

Follow these steps in order for every PR review.

#### Step 1: Read the PR Context

1. Run `gh pr view <number>` to read the title, description, author, base branch, and linked issues.
2. Understand the intent — what problem is the PR solving and why.
3. Check the PR size. If the diff exceeds 1,000 lines, note this and consider reviewing file-by-file.

#### Step 2: Check for Security Issues (OWASP Top 10)

Scan the diff for common vulnerabilities:

- **Injection** — SQL injection, command injection, XSS via unsanitised input
- **Broken authentication** — hardcoded credentials, weak token handling
- **Sensitive data exposure** — secrets in code, unencrypted PII, verbose logging
- **Broken access control** — missing authorisation checks, privilege escalation
- **Security misconfiguration** — debug mode enabled, permissive CORS, default credentials
- **Insecure dependencies** — new dependencies with known CVEs

Flag any findings as **Critical** severity.

#### Step 3: Check Code Quality

Evaluate the diff against these criteria:

- **Naming** — variables, functions, and classes use clear, descriptive names
- **Structure** — code is well-organised, follows existing project patterns
- **DRY** — no unnecessary duplication; shared logic is extracted
- **Readability** — logic is easy to follow; complex sections have comments
- **Error handling** — errors are caught, logged, and handled gracefully
- **Type safety** — types are correct and complete (where applicable)

Flag findings as **Suggestion** or **Nit** severity.

#### Step 4: Check Performance Implications

Look for:

- **N+1 queries** — database calls inside loops
- **Unbounded operations** — missing pagination, no limits on collection processing
- **Memory concerns** — large allocations, retained references, missing cleanup
- **Unnecessary computation** — redundant calculations, missing caching opportunities
- **Blocking operations** — synchronous I/O in async contexts

Flag findings as **Critical** (production impact) or **Suggestion** (optimisation opportunity).

#### Step 5: Check Test Coverage

Assess whether the changes are adequately tested:

- Are there new or updated tests for the changed code?
- Do tests cover both happy path and edge cases?
- Are error scenarios tested?
- Is there integration test coverage for new API endpoints or workflows?
- Are existing tests still valid after the changes?

If test coverage is lacking, note specific scenarios that should be tested.

#### Step 6: Write the Review Summary

Compile findings into a structured review with the following format:

```
## PR Review: #<number> — <title>

### Overview
<1-2 sentence summary of the PR's purpose and approach>

### Positives
- <What the PR does well — always include at least one positive>

### Findings

#### Critical
- <Security or performance issues that must be addressed>

#### Suggestions
- <Improvements that would meaningfully enhance the code>

#### Nits
- <Minor style or preference items>

### Test Coverage
<Assessment of test adequacy>

### Verdict
<APPROVE / REQUEST_CHANGES / COMMENT — with brief justification>
```

## Error Handling

| Error | Response |
|---|---|
| **PR not found** | Verify the PR number and repository. Run `gh pr list` to confirm available PRs. Check that the repository is correct with `gh repo view`. |
| **No permissions** | Inform the user they may not have access to the repository. Suggest checking repository visibility and their GitHub authentication via `gh auth status`. |
| **Large diffs (>1,000 lines)** | Warn the user about the size. Offer to review file-by-file using `gh api` to list changed files, then review each file's diff individually. Prioritise files with security implications. |
| **CI checks failing** | Note failing checks via `gh pr checks`. Include check failures in the review summary as they may indicate issues with the PR. |

## Examples

### "Review PR #42"

1. Run `gh pr view 42` and `gh pr diff 42`.
2. Walk through the six-step methodology.
3. Present the structured review summary.
4. Ask if the user wants to submit the review via `gh pr review 42`.

### "Check the latest PR on main"

1. Run `gh pr list --base main --limit 1` to find the latest PR.
2. Proceed with the full review methodology on the identified PR.

### "Give feedback on this PR" (with a URL provided)

1. Extract the owner, repo, and PR number from the URL.
2. Run the review methodology against the identified PR.
3. Present findings and offer to submit.

## Important

- **Always be constructive.** Note positives alongside issues — every PR has something done well.
- **Use severity ratings consistently:** Critical (must fix), Suggestion (should consider), Nit (take it or leave it).
- **Never submit a review without user confirmation.** Present the review summary first and let the user decide whether to approve, request changes, or comment.
- **Be specific.** Reference file names, line numbers, and code snippets when raising findings.
- **Respect the author.** Frame feedback as questions or suggestions rather than commands (e.g., "Have you considered..." rather than "You must...").
- **Consider context.** A hotfix PR has different standards to a feature PR — adjust expectations accordingly.
