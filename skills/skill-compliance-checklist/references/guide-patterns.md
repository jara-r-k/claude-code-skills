# Official Skill Patterns

From Anthropic's "Complete Guide to Building Skills for Claude" (Jan 2026).

## Pattern 1: Sequential Workflow Orchestration

**Use when**: Users need multi-step processes in a specific order.

**Key techniques**:
- Explicit step ordering with dependencies between steps
- Validation at each stage before proceeding
- Rollback instructions for failures
- Data passing between steps (e.g., customer_id from Step 1 used in Step 3)

**Example structure**:
```
Step 1: Create Account → Step 2: Setup Payment (wait for verification) → Step 3: Create Subscription (uses Step 1 output) → Step 4: Send Welcome Email
```

## Pattern 2: Multi-MCP Coordination

**Use when**: Workflows span multiple services (e.g., Figma + Drive + Linear + Slack).

**Key techniques**:
- Clear phase separation (one MCP per phase)
- Data passing between MCPs (e.g., asset links from Drive used in Linear tasks)
- Validation before moving to next phase
- Centralised error handling

## Pattern 3: Iterative Refinement

**Use when**: Output quality improves with iteration (e.g., report generation).

**Key techniques**:
- Initial draft generation
- Quality check via validation script or criteria
- Refinement loop: address issues → regenerate → re-validate
- Know when to stop iterating (explicit quality threshold)
- Finalisation step with formatting and summary

## Pattern 4: Context-Aware Tool Selection

**Use when**: Same outcome, different tools depending on context.

**Key techniques**:
- Decision tree based on input characteristics (e.g., file type, size)
- Clear criteria for each path
- Fallback options when preferred tool unavailable
- Transparency about choices made (explain to user why that tool was chosen)

## Pattern 5: Domain-Specific Intelligence

**Use when**: Skill adds specialised knowledge beyond tool access.

**Key techniques**:
- Domain expertise embedded in decision logic (e.g., compliance rules, best practices)
- Pre-action validation (compliance check before processing)
- Comprehensive audit trail and documentation
- Clear governance and escalation paths

## Use Case Categories

### Category 1: Document & Asset Creation
Creating consistent, high-quality output (documents, presentations, designs, code).
- Embedded style guides and brand standards
- Template structures for consistent output
- Quality checklists before finalising
- Often uses Claude's built-in capabilities (no external tools)

### Category 2: Workflow Automation
Multi-step processes with consistent methodology, possibly across multiple MCPs.
- Step-by-step workflow with validation gates
- Templates for common structures
- Built-in review and improvement suggestions
- Iterative refinement loops

### Category 3: MCP Enhancement
Workflow guidance to enhance tool access from an MCP server.
- Coordinates multiple MCP calls in sequence
- Embeds domain expertise
- Provides context users would otherwise need to specify
- Error handling for common MCP issues
