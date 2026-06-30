<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-06-30 -->

# skills/figma-handoff/

## Purpose

Design-to-code handoff skill powered by the Figma MCP server. Implements a five-step workflow: extract design context via Figma MCP tools, analyse the project stack and existing components, map Figma design tokens to project tokens, generate production code adapted to the project's conventions, and verify output visually against the Figma screenshot.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Full skill definition — MCP tool catalogue, five-step handoff workflow, error handling table, three worked examples, and critical rules |

## For AI Agents

### Working In This Directory

- This skill requires the Figma MCP server to be connected (`mcp-server: figma` in frontmatter).
- Current version: `1.0.0`. Bump on any change to the handoff workflow or MCP tool list.
- The skill must never default to React + Tailwind — it detects and adapts to the project's actual stack.
- Code Connect mappings (`add_code_connect_map`) should be registered after every successful handoff to improve future runs.

### Testing Requirements

- Validate SKILL.md with `/skill-compliance-checklist` before any change is committed.
- Manual test: provide a Figma URL and verify the skill correctly parses the file key and node ID, extracts design context, and generates code that matches the project's styling approach.

### Common Patterns

- Figma URL format: `figma.com/design/<file_key>/<name>?node-id=<node_id>` — parse both parts before calling any MCP tool.
- Always call `get_screenshot` first to capture a visual reference before extracting structured data.
- Prefer `get_code_connect_map` early to discover existing mappings and avoid recreating components.
- Accessibility attributes (ARIA, semantic HTML, keyboard nav) are required in every generated component.

## Dependencies

### External

- Figma MCP server (first-party Claude.ai integration)

<!-- MANUAL: -->
