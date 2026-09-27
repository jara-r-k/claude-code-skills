<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# .github/

## Purpose

GitHub configuration. Holds only the Actions CI workflow — no issue/PR templates, CODEOWNERS, or Dependabot config.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `workflows/` | `validate-skills.yml`, the repo's only automated check (see `workflows/AGENTS.md`) |

## For AI Agents

### Working In This Directory

- Any change under `.github/workflows/` triggers the validation workflow on push/PR (path filter).

<!-- MANUAL: -->
