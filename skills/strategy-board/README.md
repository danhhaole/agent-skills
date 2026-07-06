# Strategy Board Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill turns your AI agent into a virtual **C-level strategy advisory board** — a team of specialists named after the great minds of strategy — that takes you from a raw strategic question to a defended, board-ready recommendation.

## What is Strategy Board?

Instead of asking a generic chatbot to "think about strategy," you convene a board. **Drucker** leads as managing partner — framing the real question, casting the right specialist, and holding the engagement together — while **seven specialists** each own one lens: markets, innovation, finance, execution, scenarios, risk, and synthesis. Each role narrows attention so a single evaluation gets done well: an analyst who is also selling the recommendation softens the numbers; an optimist who is also the risk officer never finds the fatal flaw. Distinct lenses, forced to collide, are what make a board better than a single adviser.

**You stay in the chair.** The board researches, analyzes, argues, and recommends. It never decides — every engagement ends by handing a clear choice back to the person who owns the outcome.

## Why Use It?

- **No invented numbers.** Every figure in an output either carries a source or is explicitly labelled `(assumption)`. A confident fabricated number is the worst failure mode of an AI strategy adviser — this skill is built to refuse that shortcut.
- **Facts before frameworks.** The board builds a sourced fact base before running any analysis, so the frameworks aren't applied to guesses.
- **Three genuine options, always.** Never one recommendation dressed up as a choice — three directions a reasonable board member could defend, including "do nothing" where honest.
- **Red-teamed before it ships.** Every recommendation goes through Taleb or a pre-mortem before it reaches you.
- **Strategy is choice.** Every recommendation states what the organization will *stop doing* — a strategy with no sacrifices is a wish list.
- **The Boardroom ("party mode").** For decisions under real disagreement, convene 3–4 members to debate one sharp question, independent takes first, then cross-talk — with minutes kept.

## The Board

**Drucker** — *Peter Drucker.* Managing Partner: frames the real question, casts specialists, guards the decision log. Never does specialist analysis himself.

| Member | Honours | Lens |
|--------|---------|------|
| **Porter** | Michael Porter | Markets & competition — industry structure, positioning |
| **Christensen** | Clayton Christensen | Innovation & disruption — jobs-to-be-done, three horizons |
| **Graham** | Benjamin Graham | Finance & value — sizing, unit economics, sensitivity |
| **Grove** | Andy Grove | Execution & organization — capabilities, operating model |
| **Wack** | Pierre Wack | Scenarios & uncertainty — futures, "what must be true" |
| **Taleb** | Nassim Taleb | Red team & risk — pre-mortem, fragile assumptions |
| **Minto** | Barbara Minto | Synthesis & communication — pyramid, board deck |

## The Engagement Pipeline

For a live decision, the board runs a gated pipeline. Artifacts are kept as files in an engagement folder so the work compounds across sessions, with three gates requiring your explicit go-ahead:

```
0 Brief        → Drucker              → brief.md          ⛔ gate: you confirm the question
1 Fact base    → cast by question     → fact-base.md
2 Analysis     → specialists by lane  → analysis/*.md
3 Options      → Drucker + board      → options.md        ⛔ gate: you pick a direction
4 Stress-test  → Taleb (+ Wack)       → boardroom/pre-mortem.md
5 Recommend    → Minto                → recommendation.md ⛔ gate: you approve
6 Roadmap      → Grove                → roadmap.md
```

Not every engagement needs every phase at full depth — Drucker proposes a right-sized plan and you trim it. What never gets trimmed: sourcing discipline, three options, the pre-mortem, and the gates.

For a single analysis ("size this market", "run a pre-mortem on this plan"), the board skips the full pipeline and casts the matching specialist directly — the sourcing and rigor rules still apply.

## The Boardroom (party mode)

The pipeline runs one specialist at a time — right for production work. The **Boardroom** is for decisions under disagreement: Drucker seats 3–4 relevant members around one sharp question, gathers each member's independent take first (to kill groupthink), then runs cross-talk while you direct the room. Every session closes with minutes and a decision recorded to `boardroom/`. It's offered naturally at the options debate (Phase 3) and always runs, in its adversarial pre-mortem variant, before a recommendation ships (Phase 4).

## The Five Non-Negotiables

1. **No invented numbers** — every figure is sourced or labelled `(assumption)`.
2. **Facts before analysis** — the fact base comes before any framework.
3. **Three genuine options before a recommendation** — not one option and two strawmen.
4. **Every recommendation gets red-teamed** before it ships.
5. **Strategy is choice** — every recommendation states what the organization will stop doing.

And the standing test for every piece of analysis: *"So what?"* — if a section doesn't change the decision, it gets cut.

## How to Trigger

Ask your AI agent tasks like:

```text
Should we build our own warehouse management system or buy one? Convene the strategy board.
```

```text
Bring in Porter — I need a Five Forces read on the ride-hailing market in Vietnam.
```

```text
We have three options on the table for entering Cambodia and the team is split. Open a Boardroom session.
```

## File Structure

```
strategy-board/
  SKILL.md                          # Entry point: roster, pipeline, non-negotiables
  references/
    agents/<name>.md                # Voice, principles, focus per board member
    frameworks/<lens>.md            # Tools and required output formats per lens
    workflow.md                     # Full phase-by-phase pipeline guidance
    boardroom.md                    # Party-mode protocol, casting, transcript format
  templates/                        # engagement-brief, fact-base, options-analysis,
                                     # boardroom-minutes, recommendation, roadmap
  checklists/                       # fact-base-quality, pre-mortem, recommendation-quality
  scripts/board_check.py            # Deterministic hygiene checker for an engagement folder
```

Engagements themselves are written to a separate folder (default `./<engagement-slug>/`) with `brief.md`, `fact-base.md`, `analysis/*.md`, `options.md`, `boardroom/*.md`, `recommendation.md`, `roadmap.md`, and a running `decision-log.md`.

## Installation

### 1. Using CLI (Recommended)

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

### 2. Manual Installation (For Non-Technical Users)

1. **Download:** Go to the `skills/` folder in this repository and download `strategy-board.zip`.
2. **Extract & Copy:** Extract `strategy-board.zip` and copy the `strategy-board` folder into one of the following directories:

**For a Specific Project:**
Copy the `strategy-board` folder to `.agents/skills/` or `.claude/skills/` in your project's root directory.

**Globally (Available for all projects):**
* **Mac / Linux:** `~/.agents/skills/` or `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` (usually `C:\Users\<YourUsername>`)

## Example Usage

> **You:** We're debating whether to expand our SaaS product into the EU market next year. Can the board look at this?
>
> **Drucker:** Before I cast anyone — is the real question "should we expand to the EU," or is it "our domestic growth is slowing and EU looks like the fastest lever"? Worth confirming, because it changes what we research. [asks a short numbered list of scoping questions, then drafts `brief.md`]
>
> *(Gate 1 — you confirm the framing.)*
>
> **Drucker:** Casting Porter for market structure and Graham for a baseline sizing — these can run in parallel. [specialists work from `fact-base.md`, each producing a sourced `analysis/*.md`]
>
> **Drucker:** Three options are on the table: direct entry, a distribution partnership, and waiting 12 months to build a UK beachhead first. Given the split between Porter's read and Graham's numbers, want to open a Boardroom session before you choose?
>
> *(Boardroom convenes Porter, Graham, Grove, and Taleb; independent takes, then cross-talk; you direct; minutes saved to `boardroom/`.)*
>
> *(Gate 2 — you pick a direction.)* → Taleb runs the pre-mortem → Minto drafts `recommendation.md` → *(Gate 3 — you approve)* → Grove turns it into `roadmap.md`.
