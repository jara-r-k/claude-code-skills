<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# skills/github-pr-review/

## Purpose

Structured pull-request review through the `gh` CLI. Six steps: read PR context → security (OWASP Top 10) → code quality → performance → test coverage → write the review. Findings are graded Critical / Suggestion / Nit, ending in an APPROVE / REQUEST_CHANGES / COMMENT verdict that is submitted only after the user confirms.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | `gh` command catalogue, six-step methodology, review template (Overview, Positives, Findings, Test Coverage, Verdict), error table (PR not found, no permissions, diffs > 1,000 lines, failing CI), three examples, `## Important` rules. v1.0.0, ~1,000 words |

## For AI Agents

### Working In This Directory

- Hard rule: never run `gh pr review` without explicit user confirmation — present the summary first.
- Security findings are always Critical; performance findings are Critical if they have production impact, otherwise Suggestion.
- The template requires at least one Positive.
- `agents/code-reviewer.md` covers similar ground with a different scale (Critical/High/Medium/Low/Nit, empty sections omitted). That omit-empty rule belongs to the agent, not this skill.
- The catalogue lists `gh pr review <number>` bare; actually submitting needs `--approve`, `--request-changes`, or `--comment` (the last two with `--body`).
- Example 2 hard-codes `--base main`; repos on another default branch (this one uses `master`) need the base adjusted.
- Bump `metadata.version` on any change to the methodology or output format.

### Testing Requirements

- Run the local CI command from the root `AGENTS.md` and `/skill-compliance-checklist skills/github-pr-review/SKILL.md`.
- Manual: review a real PR number; check all six steps run, every finding cites a file and line, and nothing is submitted without confirmation.

### Common Patterns

- For PRs over 1,000 lines, list files via `gh api repos/{owner}/{repo}/pulls/{number}/files` and review them one at a time, security-sensitive files first.
- Include `gh pr checks` failures in the review summary.

## Dependencies

### External

- `gh` CLI, installed and authenticated (`gh auth status`)

<!-- MANUAL: -->
