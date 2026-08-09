+++
title = "Fonts that actually render Coptic"
description = "The Unicode blocks involved, and the short list of faces that cover them."
date = 2026-07-28

[taxonomies]
tags = ["typography", "unicode"]
+++

Coptic is split across two Unicode blocks, and this trips up more font
stacks than anything else about the script.

The **Coptic block**, `U+2C80`–`U+2CFF`, holds the letters inherited from
Greek in their Coptic shapes: <span class="copt">ⲁ ⲃ ⲅ ⲇ ⲉ</span> and the
rest. But the seven letters borrowed from Demotic —
<span class="copt">ϣ ϥ ϧ ϩ ϫ ϭ ϯ</span> — live back in **Greek and Coptic**,
`U+03E2`–`U+03EF`, because they were encoded before the dedicated block
existed. A font can cover one range and not the other, and then your text
renders half in the right face and half in a fallback.

## The short list

- **Antinoou** — the reference face for Coptic epigraphy and papyrology.
  Covers both ranges, handles the combining strokes, free.
- **New Athena Unicode** — built for classicists; good Coptic coverage
  alongside polytonic Greek, which is what you want for a bilingual edition.
- **Noto Sans Coptic** / **Noto Serif Coptic** — the safe default if the
  text has to render on someone else's machine.
- **Sophia Nubian** — designed for Old Nubian, so it carries the extra
  Nubian letters at the top of the Coptic block.

## What to put in a stylesheet

Name the specialist faces first and let a generic serif catch the fall:

```css
font-family: "Antinoou", "New Athena Unicode", "Noto Sans Coptic",
             "Segoe UI Historic", "Sophia Nubian", serif;
```

`Segoe UI Historic` is in the list because it ships with Windows and has
the coverage, so a reader who installed nothing still sees letters rather
than boxes. This site uses exactly that stack.

---

None of this helps with the supralinear stroke joining up properly. Nothing
does, yet.
