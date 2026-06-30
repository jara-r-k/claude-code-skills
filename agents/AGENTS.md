<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# agents/

## Purpose

Reusable agent definition files. Each `.md` file defines a specialised Claude Code subagent with YAML frontmatter (`name`, `model`, `tools`) and a methodology body. Agents are spawned by Claude Code for focused, single-responsibility tasks and are distinct from skills — they execute work rather than guide behaviour.

## Key Files

| File | Description |
|------|-------------|
| `code-reviewer.md` | Analyses code changes for quality, security, performance, and maintainability — produces structured findings by severity |
| `project-setup.md` | Scaffolds `CLAUDE.md` and `.claude/` configuration for new or uninitialised projects |
| `python-test-runner.md` | Runs and analyses pytest suites — pass/fail summaries, failure diagnosis, coverage reports, flaky-test detection |

## For AI Agents

### Working In This Directory

- Agent files use YAML frontmatter with at minimum: `name` (kebab-case), `model` (`sonnet` default), `tools` (list).
- Agent body should contain a clear methodology — step-ordered instructions and an output format section.
- CI checks frontmatter for agents but does not enforce word count — self-enforce conciseness.
- Install globally: `cp agents/<file>.md ~/.claude/agents/` or project-locally: `cp agents/<file>.md {project}/.claude/agents/`.
- Never include deployment commands or destructive operations in an agent body.

### Testing Requirements

- No automated tests for agent definitions.
- Manually verify by spawning the agent in the target context and checking it follows its stated methodology.
- For `python-test-runner.md`: ensure the venv-activation block runs before pytest invocations.

### Common Patterns

- All three agents default to `model: sonnet`.
- Tools lists are minimal — only what the agent genuinely needs (reduces surface area).
- `code-reviewer.md` and `python-test-runner.md` are read-only agents; they must not write or modify files.
- `project-setup.md` writes only configuration files (CLAUDE.md, .claude/ scaffolding) — never source code.

## Dependencies

### External

- Python + pytest — required by `python-test-runner.md`
- Git — required by `code-reviewer.md` (git diff, git log)

<!-- MANUAL: -->
