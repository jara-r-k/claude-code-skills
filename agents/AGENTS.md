<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# agents/

## Purpose

Reusable Claude Code subagent definitions. Each `.md` file has YAML frontmatter (`name`, `description`, `license`, `model`, `tools`) and a methodology body. Agents execute focused work when spawned; skills (`../skills/`) guide behaviour when triggered. Users install by copying into `~/.claude/agents/` or `{project}/.claude/agents/`.

## Key Files

| File | Description |
|------|-------------|
| `code-reviewer.md` | Reviews diffs for security (OWASP Top 10), quality, performance, maintainability; findings graded Critical/High/Medium/Low/Nit plus Positives and Suggestions. Tools: Read, Glob, Grep, Bash |
| `project-setup.md` | Explores a new repo, detects the stack from marker files, writes a concise `CLAUDE.md` (< 80 lines) and a `.claude/agents/` + `.claude/commands/` skeleton. Tools: Read, Write, Edit, Bash, Glob, Grep |
| `python-test-runner.md` | Activates a venv, runs pytest at the requested scope, reports counts, failure root causes, environment issues, flaky tests, coverage. Tools: Read, Glob, Grep, Bash |

## For AI Agents

### Working In This Directory

- CI requires only `---` on line 1 and a non-empty `name:`. Match the existing files anyway: `description` (with "Do NOT use for…"), `license: MIT`, `model: sonnet`, minimal `tools` list.
- CI skips `AGENTS.md` by exact basename (it has no frontmatter). Do not rename it or add any other non-agent `.md` here — CI would fail it.
- No word limit is enforced for agents; self-enforce concision (current files are 640–710 words).
- "Read-only" in `code-reviewer` and `python-test-runner` is an instruction, not a tool restriction — both have `Bash`. Keep the prohibitions in the body.
- Never add deployment or destructive commands to an agent body.
- New agents go in the README Agents table (the README install snippet currently copies only `code-reviewer` and `project-setup`).

### Testing Requirements

- Run the local CI command from the root `AGENTS.md`.
- No behavioural tests: spawn the agent in a real context and check it follows its steps and output format.

### Common Patterns

- Numbered steps, then `## Rules`; `code-reviewer` and `python-test-runner` also define an `## Output Format` block.
- `code-reviewer.md` overlaps `skills/github-pr-review/` but uses a different severity scale (Critical/High/Medium/Low/Nit vs Critical/Suggestion/Nit) and omits empty severity sections. Align both deliberately if changing either.
- `project-setup.md` must read an existing `CLAUDE.md` before touching it and stay idempotent.

## Dependencies

### Internal

- `skills/github-pr-review/` — sibling review methodology (see overlap note)

### External

- Git — `code-reviewer` (`git diff`, `git log`)
- Python + pytest; optional pytest-cov, pytest-xdist, pytest-timeout — `python-test-runner`

<!-- MANUAL: -->
