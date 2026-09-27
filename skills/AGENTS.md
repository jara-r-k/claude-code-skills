<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# skills/

## Purpose

The published Claude Code skills. Each skill is a kebab-case directory containing a `SKILL.md` entry point (YAML frontmatter + instructions) and, optionally, `references/` for long material loaded on demand. Users install by copying a skill directory to `~/.claude/skills/` or uploading it to Claude.ai.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `skill-compliance-checklist/` | Meta-skill auditing skills against Anthropic's Jan 2026 guide — the repo's pre-publish gate (see `skill-compliance-checklist/AGENTS.md`) |
| `figma-handoff/` | Figma-to-code handoff via the Figma MCP server (see `figma-handoff/AGENTS.md`) |
| `github-pr-review/` | Six-step PR review via the `gh` CLI (see `github-pr-review/AGENTS.md`) |
| `gmail-workflow/` | Draft, triage, search, and draft management via the Gmail MCP server (see `gmail-workflow/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- Directory names are kebab-case and each must contain a file named exactly `SKILL.md` (`scripts/attention-check.sh` scores a skill directory without one at 75).
- Frontmatter: CI requires `name` (kebab-case) and a single-line `description` (≤ 1024 chars, no `<`/`>`). Repo convention adds `license: MIT` and `metadata` (`author`, `version`, optional `mcp-server`/`based-on`). `user-invocable` is set explicitly only on the checklist (`true`).
- Descriptions follow WHAT + WHEN + negative triggers ("Do NOT use for…").
- Bump `metadata.version` on every functional change (all at 1.0.0 except the checklist at 1.1.0).
- If a SKILL.md nears 5,000 words (largest today: `figma-handoff`, ~1,100), move detail into `references/`.
- Audit with explicit paths: `/skill-compliance-checklist skills/{name}/SKILL.md` — `--all` does not scan this repo.
- New or renamed skills also need the README Skills table updated.

### Testing Requirements

- Run the local CI command from the root `AGENTS.md`; it must end with "All skills and agents passed validation."
- Include `## Error Handling` (or `## Troubleshooting`) and `## Examples` — CI only warns when missing, but the compliance checklist fails them.
- No skill has `eval/`, `test/`, or `tests/`; adding one clears that skill's attention-check "no evals" signal.

### Common Patterns

- The three companion skills share one layout: overview → `## Available (MCP) Tools` → `## Instructions` (numbered steps) → `## Error Handling` table → `## Examples` (three each) → `## Important`. The checklist uses Instructions → Troubleshooting → Examples.
- MCP-backed skills declare `metadata.mcp-server` (`figma`, `gmail`) and list the exact tool names they call.
- `gmail-workflow` and `github-pr-review` require explicit user confirmation before anything is sent or submitted — keep that guard.

## Dependencies

### Internal

- `skill-compliance-checklist/` — validates the other skills and `examples/*/SKILL.md`
- `github-pr-review/` overlaps `agents/code-reviewer.md` (different severity scale)

### External

- Figma MCP server (`figma-handoff`), Gmail MCP server (`gmail-workflow`), `gh` CLI (`github-pr-review`)

<!-- MANUAL: -->
