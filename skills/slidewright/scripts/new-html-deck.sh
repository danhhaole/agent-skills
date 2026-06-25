#!/usr/bin/env bash
# new-html-deck.sh — scaffold a plain-HTML interactive presentation (no build step).
#
# Usage:  bash new-html-deck.sh <deck-name> [target-dir] [--title "Deck title"]
#
# Creates:
#   <target-dir>/<deck-name>/index.html        single self-contained deck (Tailwind via CDN)
#   <target-dir>/<deck-name>/assets/           images, icons, video
#   <target-dir>/<deck-name>/<deck-name>-notes.md   speaker notes (not projected)
#
# The deck runs by opening index.html directly in a browser — no server, no install.
# The template renders on a fixed 1920x1080 stage that scales to fit any screen,
# so font sizes stay correct for projection. Edit the <section class="slide"> blocks.

set -euo pipefail

NAME="${1:-}"
if [[ -z "$NAME" ]]; then
  echo "Usage: bash new-html-deck.sh <deck-name> [target-dir] [--title \"...\"]" >&2
  exit 1
fi

TARGET_DIR="."
TITLE="$NAME"
shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --title) TITLE="${2:-$NAME}"; shift 2;;
    *) TARGET_DIR="$1"; shift;;
  esac
done

DECK_DIR="$TARGET_DIR/$NAME"
if [[ -e "$DECK_DIR" ]]; then
  echo "Refusing to overwrite existing path: $DECK_DIR" >&2
  exit 1
fi

mkdir -p "$DECK_DIR/assets"

cat > "$DECK_DIR/index.html" <<HTMLEOF
<!doctype html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>__TITLE__</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@500;600;700;800;900&display=swap" rel="stylesheet" />
  <style>
    :root { --accent:#9d6248; --ink:#1f2430; --bg:#f8f3e7; --soft:#6d6a66; }
    * { box-sizing:border-box; margin:0; padding:0; }
    html, body { width:100%; height:100%; overflow:hidden; background:#0d0d0f; }
    body { font-family:'Plus Jakarta Sans', system-ui, sans-serif; color:var(--ink); }
    h1,h2,h3 { font-family:'Outfit', system-ui, sans-serif; }

    /* Fixed design canvas. Everything is authored at 1920x1080, then scaled
       to fit the viewport, so text never shrinks below projection-legible sizes. */
    #viewport { position:fixed; inset:0; display:flex; align-items:center; justify-content:center; }
    #stage {
      position:relative; width:1920px; height:1080px; flex:none;
      transform-origin:center center; background:var(--bg);
      overflow:hidden;
    }
    .slide {
      position:absolute; inset:0; padding:96px 120px;
      display:none; flex-direction:column;
      opacity:0; transition:opacity .35s ease;
    }
    .slide.active { display:flex; opacity:1; }

    /* Typography — authored on the 1920x1080 canvas (1pt ≈ 2px). These sit at the
       lower-middle of the legible range: comfortable, not oversized. Body stays
       above the 40px floor so it still reads from the back of a room. Bump a
       specific hero/title up per slide if it needs more presence — don't raise
       these globals. */
    .slide          { font-size:42px; line-height:1.45; }
    .slide h1       { font-size:88px;  line-height:1.04; letter-spacing:-.03em; font-weight:900; }
    .slide h2       { font-size:54px;  line-height:1.12; font-weight:800; }
    .slide .lead    { font-size:44px;  color:var(--soft); }
    .slide .caption { font-size:34px;  color:var(--soft); }
    .slide ul       { list-style:none; display:flex; flex-direction:column; gap:26px; }
    .slide li       { display:flex; gap:22px; align-items:flex-start; }
    .slide li::before { content:''; flex:none; width:18px; height:18px; margin-top:20px; border-radius:5px; background:var(--accent); }

    /* Bottom navigation bar — required on every deck. */
    #nav {
      position:fixed; left:0; right:0; bottom:0; height:64px; z-index:50;
      display:flex; align-items:center; justify-content:center; gap:20px;
      background:rgba(255,255,255,.82); backdrop-filter:blur(10px);
      border-top:1px solid rgba(0,0,0,.06);
    }
    #nav button { cursor:pointer; border:none; background:none; color:var(--ink); padding:8px 12px; font-size:18px; border-radius:10px; }
    #nav button:disabled { opacity:.25; cursor:default; }
    #dots { display:flex; gap:8px; align-items:center; max-width:60vw; overflow-x:auto; }
    .dot { width:10px; height:10px; border-radius:999px; background:#d5c8b4; border:none; cursor:pointer; transition:all .2s; flex:none; }
    .dot.active { width:26px; background:var(--accent); }
    #counter { font-size:18px; color:var(--soft); font-variant-numeric:tabular-nums; min-width:64px; text-align:center; }
  </style>
</head>
<body>
  <div id="viewport">
    <div id="stage">

      <!-- ============ SLIDES ============ -->
      <!-- Each <section class="slide"> is one slide. The first one needs class "active". -->

      <section class="slide active" style="justify-content:space-between;">
        <div style="display:flex; justify-content:space-between; align-items:flex-start;">
          <span style="display:inline-flex; align-items:center; background:rgba(157,98,72,.1); color:var(--accent); font-weight:700; padding:14px 28px; border-radius:999px; font-size:32px;">__NAME__</span>
        </div>
        <div style="display:flex; flex-direction:column; gap:36px;">
          <h1>__TITLE__</h1>
          <p class="lead" style="max-width:1300px;">Thay câu này bằng một dòng dẫn nói rõ bài này nói về điều gì — ngắn, thẳng, như đang nói trên sân khấu.</p>
        </div>
        <p class="caption">Tên người trình bày · Vai trò</p>
      </section>

      <section class="slide" style="gap:48px; justify-content:center;">
        <h2>Tiêu đề slide nội dung</h2>
        <ul>
          <li>Ý chính thứ nhất — ngắn gọn, mỗi dòng một ý.</li>
          <li>Ý chính thứ hai — dùng visual thật khi cần minh họa.</li>
          <li>Ý chính thứ ba — tránh nhồi quá nhiều chữ vào một slide.</li>
        </ul>
      </section>

      <section class="slide" style="align-items:center; justify-content:center; text-align:center;">
        <h1 style="max-width:1500px;">Một câu trích dẫn lớn để nhấn mạnh.</h1>
        <p class="caption" style="margin-top:40px;">— Nguồn trích dẫn</p>
      </section>

      <!-- Copy a <section class="slide"> block above to add more slides. -->
      <!-- ============ /SLIDES ============ -->

    </div>
  </div>

  <nav id="nav">
    <button id="prev" aria-label="Slide trước">&larr; Trước</button>
    <div id="dots"></div>
    <span id="counter"></span>
    <button id="next" aria-label="Slide sau">Sau &rarr;</button>
  </nav>

  <script>
    const stage = document.getElementById('stage');
    const slides = Array.from(document.querySelectorAll('.slide'));
    const dotsBox = document.getElementById('dots');
    const counter = document.getElementById('counter');
    const prevBtn = document.getElementById('prev');
    const nextBtn = document.getElementById('next');
    let current = slides.findIndex(s => s.classList.contains('active'));
    if (current < 0) current = 0;

    slides.forEach((_, i) => {
      const d = document.createElement('button');
      d.className = 'dot';
      d.setAttribute('aria-label', 'Slide ' + (i + 1));
      d.addEventListener('click', () => go(i));
      dotsBox.appendChild(d);
    });
    const dots = Array.from(dotsBox.children);

    function render() {
      slides.forEach((s, i) => s.classList.toggle('active', i === current));
      dots.forEach((d, i) => d.classList.toggle('active', i === current));
      counter.textContent = (current + 1) + ' / ' + slides.length;
      prevBtn.disabled = current === 0;
      nextBtn.disabled = current === slides.length - 1;
    }
    function go(i) { current = Math.max(0, Math.min(slides.length - 1, i)); render(); }

    prevBtn.addEventListener('click', () => go(current - 1));
    nextBtn.addEventListener('click', () => go(current + 1));
    window.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'PageDown') { e.preventDefault(); go(current + 1); }
      else if (e.key === 'ArrowLeft' || e.key === 'PageUp') { e.preventDefault(); go(current - 1); }
      else if (e.key === 'Home') go(0);
      else if (e.key === 'End') go(slides.length - 1);
    });

    // Scale the 1920x1080 stage to fit the viewport (leaving room for the nav bar).
    function fit() {
      const navH = 64;
      const scale = Math.min(window.innerWidth / 1920, (window.innerHeight - navH) / 1080);
      stage.style.transform = 'scale(' + scale + ')';
    }
    window.addEventListener('resize', fit);
    fit();
    render();
  </script>
</body>
</html>
HTMLEOF

# Substitute placeholders without tripping shell expansion inside the heredoc.
python3 - "$DECK_DIR/index.html" "$TITLE" "$NAME" <<'PYEOF'
import sys
path, title, name = sys.argv[1], sys.argv[2], sys.argv[3]
s = open(path, encoding="utf-8").read()
s = s.replace("__TITLE__", title).replace("__NAME__", name)
open(path, "w", encoding="utf-8").write(s)
PYEOF

cat > "$DECK_DIR/$NAME-notes.md" <<NOTESEOF
# $TITLE — speaker notes

> Không chiếu. Dùng để chuẩn bị narrative, dàn bài, ghi chú nói.

## Dàn bài
1.

## Speaker notes theo slide
- Slide 1 (Title):
- Slide 2:
- Slide 3:
NOTESEOF

echo "✅ Created plain-HTML deck: $DECK_DIR"
echo "   Open in browser:   open \"$DECK_DIR/index.html\""
echo "   Slides live inside the <!-- SLIDES --> block in index.html."
echo "   Speaker notes:     $DECK_DIR/$NAME-notes.md"
