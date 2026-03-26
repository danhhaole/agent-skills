# Agent Skills

A collection of skills for AI coding agents. Compatible with [Claude Code](https://code.claude.com), [Cursor](https://cursor.com), [GitHub Copilot](https://github.com/features/copilot), and [20+ other AI tools](https://agentskills.io) that support the open [Agent Skills standard](https://agentskills.io).

## Available Skills

### system-prompt-creator

Create high-quality, model-aware system prompts for any LLM (Claude, GPT, Gemini, open-source).

**What it does:**
- Walks you through a structured 5-step workflow: Interview, Analyze, Structure, Draft, Review
- Applies 12 universal principles derived from the official prompting guides of Anthropic, OpenAI, and Google
- Produces model-specific optimizations (Claude XML tags, GPT-5 verbosity params, Gemini temperature settings)
- Includes domain patterns: operational playbooks, raw data preservation, confidence scoring
- Provides 7 ready-to-adapt templates for common use cases

**Trigger phrases:** "create a system prompt", "write system instructions", "prompt engineering", "build a chatbot prompt", "design an agent prompt"

## Installation

```bash
# Using the skills CLI (recommended)
npx skills add tronghieu/agent-skills

# Or manually for Claude Code
cp -r skills/system-prompt-creator ~/.claude/skills/
```

## Skill Structure

```
skills/
  system-prompt-creator/
    SKILL.md                    # Core skill (workflow + 12 principles)
    references/
      principles.md             # Detailed principles with examples
      model-specific.md         # Claude / GPT-5 / Gemini tips
      templates.md              # 7 templates (chatbot, agent, extractor, etc.)
```

## Creating New Skills

See [AGENTS.md](./AGENTS.md) for the skill creation guide, including directory structure, naming conventions, SKILL.md format, and packaging instructions.

## References

| Resource | URL |
|----------|-----|
| Agent Skills Standard | https://agentskills.io |
| Claude Code Skills Docs | https://code.claude.com/docs/en/skills |
| Anthropic Skills (official) | https://github.com/anthropics/skills |
| Skills CLI (Vercel) | https://github.com/vercel-labs/skills |
| Skills Marketplace | https://skills.sh |

## License

MIT
