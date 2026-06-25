# Design system — projection-grade slides

This is the shared design language for every deck, regardless of track (plain HTML or
React). The rules here exist because the output is **projected to a room**, not read on
a personal screen. Internalise the mental model first; the specifics follow from it.

## The one mental model: this is projection, not a web app

There is exactly **one operator** — the presenter — on **one machine**. Slides are
thrown onto a big screen (projector, or screen-share in Meet/Zoom). The audience only
**looks**. They never click, type, or touch anything.

Two mistakes follow from forgetting this, and both are common:

1. **Text too small.** Web-sized type (`text-sm`, `16px`, `1rem`) is illegible from the
   back of a room. On a 1080p canvas, `16px ≈ 8pt` — half the minimum.
2. **Treating it like an app.** Building input fields, "Submit" buttons, login, score
   collection, anything that stores data. There is no backend and nowhere for data to
   go. If a component raises the question *"where does this data go / who reads it?"*,
   it is wrong — remove it.

## Typography floor (non-negotiable)

Author on a fixed **1920×1080** canvas (1pt ≈ 2px). The "default" column is where to
land for ordinary slides — comfortable and legible without shouting. The min is the hard
floor; the ceiling is for the occasional hero/title only.

| Role                | Floor (min) | Default | Ceiling (hero only) | default px on 1080 |
| ------------------- | ----------- | ------- | ------------------- | ------------------ |
| Body / bullet       | 20pt        | 21pt    | 26pt                | **42px**           |
| Subtitle            | 24pt        | 27pt    | 32pt                | 54px               |
| Main title          | 36pt        | 44pt    | 52pt                | 88px               |
| Caption / slide no. | 18pt        | 17pt*   | 22pt                | 34px               |

\* slide-number/caption is the one role allowed just under the body floor (never < 18pt
= 36px), since it isn't primary reading.

- **Nothing smaller than 20pt** (≈40px) for body/bullets. Don't default to the ceiling —
  oversized type looks shouty and crowds the slide. Reach for the ceiling only on a single
  hero line (a cover title, one big stat). Bump *that one element* up, not the globals.
- **Don't use fixed `px`/`rem` for slide text** unless you author on a fixed canvas
  that is then scaled (the plain-HTML template does exactly this). For fluid layouts
  use frame-relative units: `vh`/`vw`, `clamp()`.
- **Acceptance test:** zoom the screen to ~33% (or stand 3–4 m back). If you can still
  read the bullets, it passes.

Two ways to satisfy the floor, both used in the templates:

- **Fixed canvas + scale** (plain HTML): everything sized in px on a 1920×1080 stage,
  then `transform: scale()` to fit. Sizes are exact and predictable. Best default.
- **Fluid `clamp()`** (React title slide): e.g. headline `clamp(56px, 7.5vw, 100px)`,
  lead `clamp(26px, 2.8vw, 40px)`, body `clamp(40px, 4.6vh, 48px)`. Good when you want
  the layout to breathe across screen sizes without a fixed stage.

## Content discipline

- One idea per slide. Few words. Let the presenter's voice carry the detail.
- Prefer a real visual (image, diagram, screenshot) over a paragraph.
- Vietnamese copy should sound like someone talking on stage — plain, honest, direct.
  No marketing tone, no hype. Say what the tech does and what it doesn't.

## Allowed interaction (presenter-controlled only)

Interaction exists to make the slide change visually while the presenter clicks:

- ✅ Reveal content step by step (progressive bullets, expand a card, flip).
- ✅ Move between slides; jump via the dot strip / table of contents.
- ✅ Toggle a before/after compare, tabs, or an accordion **whose content already exists**.
- ✅ Timers, countdowns, animation, highlight, hover.

Never: text inputs, "Submit/Save", answer collection, scoring, login, or anything that
assumes storage (DB, an API call, localStorage for someone's answers).

## Required chrome on every deck

- A visible **navigation slider** (the dot strip) and **slide number** at the bottom,
  so the presenter can jump around live. Both scaffolds include this — keep it.
- Keyboard navigation: → / Space / PageDown advance; ← / PageUp go back; Home/End jump.

## Slide layout recipes

Reach for these instead of inventing structure each time. (Tailwind classes shown for
the React track; the plain-HTML template uses equivalent inline styles.)

**Title** — badge top, big headline + one-line lead centre, presenter line bottom.
`flex flex-col justify-between`, headline `clamp(64px,9vw,120px) font-black`.

**Bulleted point** — `h2` heading + 3–5 short bullets, generous `gap`. Keep bullets to
one line each; if a bullet wraps twice, split the slide.

**Two-column compare** — `grid grid-cols-2 gap-12`, each column a card
(`rounded-3xl p-12`). Use for before/after, problem/solution, myth/reality.

**Big stat** — one huge number (`clamp(120px,18vw,260px)`) + a short caption. One stat
per slide; the number is the whole point.

**Quote** — centred, large italic/serif line, attribution as caption below.

**Full-bleed image** — `fullBleed` slide, image `object-cover` filling the frame, text
in an overlaid panel with a translucent/blurred background for contrast.

## Motion (React track: Framer Motion)

- Slide transitions are handled by `Deck` (a short cross-fade). Don't fight it.
- Inside a slide, animate entrance with small `initial → animate` offsets
  (`y: 24, opacity: 0` → `y: 0, opacity: 1`, ~0.4s), staggering with `delay`. Subtle
  beats flashy — motion should guide the eye, not perform.
- For step-by-step reveals, drive a local `useState` step counter from the same keyboard
  handler pattern, or split into separate slides (simpler and usually better).

## Optional: ambient background

A drifting gradient backdrop adds polish but is never required and must never reduce
text contrast. If you want it, the pattern (from real decks) is: 2–3 large blurred
radial "blobs" absolutely positioned with slow CSS keyframe drift, plus optional
floating dust motes. Keep it behind a `z-index` floor and `pointer-events: none`.
Reference implementation lives in the repo decks; copy and re-tint per deck palette.

## Palette

The scaffolds ship a warm neutral default (`--bg #f8f3e7`, `--ink #1f2430`,
`--accent #9d6248`, `--soft #6d6a66`). Replace per deck/brand — change the CSS variables
(HTML) or the hex values in `Deck`/`Slide`/`index.css` (React). Keep one accent colour
and use it consistently for emphasis.
