---
name: figma-handoff
description: Design-to-code handoff workflow using Figma MCP — extract design context, map to project components, and generate production code. Use when asked to 'implement this Figma design', 'convert design to code', 'build from Figma', or given a figma.com URL to implement. Do NOT use for creating Figma designs, managing Figma files, or non-implementation design feedback.
license: MIT
metadata:
  author: jara-r-k
  version: 1.0.0
  mcp-server: figma
---

# Figma Handoff Skill

Companion skill for the Figma MCP server. Provides a structured design-to-code handoff workflow that extracts design context, maps it to existing project conventions, and generates production-ready code adapted to the project stack.

## Available MCP Tools

This skill coordinates the following Figma MCP tools:

- `get_design_context` — Extract design tokens, layout, and component information from a Figma node
- `get_screenshot` — Capture a visual screenshot of a Figma frame or component
- `get_metadata` — Retrieve file and node metadata
- `get_code_connect_map` — Get existing Code Connect mappings between Figma components and code
- `get_code_connect_suggestions` — Get suggested Code Connect mappings
- `add_code_connect_map` — Register a new Code Connect mapping
- `send_code_connect_mappings` — Send finalised mappings
- `get_variable_defs` — Extract design token variable definitions
- `get_figjam` — Extract content from FigJam boards

## Instructions

### Multi-MCP Coordination Pattern

Follow these steps in order for every Figma-to-code handoff.

#### Step 1: Extract Design Context via Figma MCP

1. Parse the Figma URL to extract the file key and node ID.
2. Use `get_screenshot` to capture a visual reference of the target frame or component.
3. Use `get_design_context` to extract:
   - Layout structure (auto-layout direction, spacing, padding, alignment)
   - Typography (font family, size, weight, line height, letter spacing)
   - Colours (fills, strokes, effects — with hex/RGBA values)
   - Dimensions (width, height, constraints, responsiveness hints)
   - Component variants and states
4. Use `get_variable_defs` to extract design token definitions (colours, spacing, typography scales).
5. Use `get_code_connect_map` to check for existing component-to-code mappings.

#### Step 2: Analyse Project Stack and Existing Components

1. Identify the project's frontend framework (React, Vue, Svelte, Next.js, etc.).
2. Locate the project's component library and design token files.
3. Catalogue existing components that may be reusable for the design.
4. Identify the styling approach (CSS Modules, Tailwind, styled-components, SCSS, etc.).
5. Note naming conventions, file structure patterns, and export styles.

#### Step 3: Map Design Tokens to Project Tokens

1. Compare Figma design tokens against the project's existing token system.
2. Map Figma colour variables to project colour tokens (e.g., Figma `primary-500` to project `--colour-primary`).
3. Map Figma spacing values to project spacing scale (e.g., Figma `16px` to project `space-4`).
4. Map Figma typography styles to project typography tokens.
5. Flag any design tokens that do not have a project equivalent — these may need to be added.

#### Step 4: Generate Code Adapted to Project Conventions

1. **Reuse existing components** wherever possible. Do not recreate components that already exist in the project.
2. Generate code using the project's established patterns:
   - Correct framework syntax (JSX, SFC, Svelte markup, etc.)
   - Project's styling approach (not defaulting to Tailwind unless the project uses it)
   - Project's state management patterns
   - Project's file and folder conventions
3. Use mapped project tokens rather than raw Figma values.
4. Include responsive behaviour based on Figma's auto-layout and constraint settings.
5. Add appropriate accessibility attributes (ARIA labels, semantic HTML, keyboard navigation).
6. Include component props/types matching the project's type system.

#### Step 5: Visual Verification

1. Compare the generated code output against the Figma screenshot from Step 1.
2. Check for:
   - Layout accuracy (spacing, alignment, stacking)
   - Colour fidelity (correct tokens mapped)
   - Typography accuracy (correct font, size, weight)
   - Responsive behaviour (breakpoint handling)
3. Note any discrepancies between the design and implementation.
4. If a Preview MCP is available, use it for live visual comparison.

## Error Handling

| Error | Response |
|---|---|
| **Invalid Figma URL** | Verify the URL format. A valid Figma design URL follows the pattern `figma.com/design/<file_key>/<file_name>?node-id=<node_id>`. Ask the user to confirm the URL and ensure it points to a specific frame or component. |
| **MCP disconnected** | Inform the user that the Figma MCP server is not connected. Suggest reconnecting via the MCP configuration or restarting Claude Code. Check that the Figma authentication token is valid. |
| **No Code Connect mappings** | Proceed without mappings. Use `get_code_connect_suggestions` to identify potential mappings. After generating code, offer to register new mappings via `add_code_connect_map` for future handoffs. |
| **Insufficient design context** | If `get_design_context` returns incomplete data, fall back to `get_screenshot` for visual reference and manually interpret the design. Inform the user about any assumptions made. |
| **Project stack not identified** | Ask the user to specify the framework, styling approach, and component library. Check for `package.json`, framework config files, or existing component files. |

## Examples

### "Build this page from figma.com/design/abc123/MyApp?node-id=42:100"

1. Extract file key `abc123` and node ID `42:100` from the URL.
2. Capture screenshot and extract design context.
3. Analyse the project — identify it as a Next.js project using CSS Modules.
4. Map Figma tokens to the project's `styles/tokens.css` variables.
5. Generate page component reusing existing `Button`, `Card`, and `Header` components.
6. Present code with a side-by-side comparison note against the Figma screenshot.

### "Implement the hero section from Figma"

1. Ask for the Figma URL or node reference.
2. Extract the hero section's design context (background, typography, CTA button, image).
3. Check existing components — reuse `Button` and `Container` if available.
4. Generate a `HeroSection` component following project conventions.
5. Include responsive styles based on Figma's auto-layout settings.

### "Convert this Figma component to match our design system"

1. Extract the Figma component's design context and variants.
2. Analyse the project's existing design system components.
3. Map the Figma component to the closest existing component or create a new one.
4. Generate code with all variants, states, and prop types.
5. Register the Code Connect mapping via `add_code_connect_map`.

## Important

- **Adapt to the project stack.** Never default to React + Tailwind. Always detect and match the project's actual framework and styling approach.
- **Reuse existing components.** Check the project's component library before creating new components. Duplication degrades maintainability.
- **Verify visually.** Always compare generated output against the Figma screenshot. Note any deviations.
- **Respect design tokens.** Use the project's token system rather than hardcoding raw values from Figma.
- **Coordinate with other skills.** This skill works alongside frontend-design skills for complex implementations. Use the project's existing patterns as the source of truth.
- **Register Code Connect mappings** after successful handoffs to improve future workflows.
- **Include accessibility.** Every generated component should have appropriate semantic HTML, ARIA attributes, and keyboard interaction support.
