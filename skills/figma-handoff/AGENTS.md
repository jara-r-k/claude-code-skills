<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-06-30 | Updated: 2026-09-27 -->

# skills/figma-handoff/

## Purpose

Companion skill for the Figma MCP server that turns a Figma frame or component into production code in the project's own stack. Five steps: extract design context (screenshot, design context, variables, Code Connect map) → analyse the project stack and components → map Figma tokens to project tokens → generate code reusing existing components → compare visually against the screenshot.

## Key Files

| File | Description |
|------|-------------|
| `SKILL.md` | Nine-tool Figma MCP catalogue, five-step workflow, error table (invalid URL, MCP disconnected, no Code Connect mappings, thin design context, unknown stack), three examples, `## Important` rules. v1.0.0, `mcp-server: figma`, ~1,100 words (largest skill in the repo) |

## For AI Agents

### Working In This Directory

- Tool names (`get_design_context`, `get_screenshot`, `get_metadata`, `get_variable_defs`, `get_code_connect_map`, `get_code_connect_suggestions`, `add_code_connect_map`, `send_code_connect_mappings`, `get_figjam`) follow Figma's official MCP server. Other Figma MCPs (e.g. Framelink: `get_figma_data`, `download_figma_images`) expose different tools and are not covered.
- Never default to React + Tailwind — detect and match the project's framework, styling approach, and token system.
- After a successful handoff, offer to register Code Connect mappings via `add_code_connect_map` (Example 3 registers one directly).
- Bump `metadata.version` on any change to the workflow or tool list.

### Testing Requirements

- Run the local CI command from the root `AGENTS.md` and `/skill-compliance-checklist skills/figma-handoff/SKILL.md`.
- Manual: give a real Figma URL; check the file key and node ID are parsed, the screenshot is taken first, and generated code uses the project's styling and tokens rather than raw hex/px values.

### Common Patterns

- URL form: `figma.com/design/<file_key>/<name>?node-id=<node_id>`. Browser URLs usually encode the node as `42-100`, while the skill's example and the API use `42:100` — normalise when parsing.
- Order: `get_screenshot` first for a visual reference, then structured extraction, then `get_code_connect_map` to find reusable mappings.
- Every generated component needs semantic HTML, ARIA attributes, and keyboard support.

## Dependencies

### External

- Figma MCP server (official Figma integration) with a valid auth token
- Optional Preview MCP for live visual comparison (Step 5)

<!-- MANUAL: -->
