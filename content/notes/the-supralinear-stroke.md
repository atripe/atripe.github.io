+++
title = "The supralinear stroke, briefly"
description = "What the line over the letter is doing, and why your font keeps putting it in the wrong place."
date = 2026-07-14

[taxonomies]
tags = ["orthography", "sahidic"]
+++

The stroke over a Coptic letter is not an accent and it is not decoration.
In Sahidic it usually marks a consonant carrying its own syllable — the
sonorants <span class="copt">ⲃ ⲗ ⲙ ⲛ ⲣ</span>, and in practice a good many
others. Written <span class="copt">ⲛ̄ⲧⲟϥ</span>, the stroke tells you the
<span class="copt">ⲛ</span> is a syllable of its own rather than a cluster
you are meant to force together.

## Sahidic and Bohairic disagree

Sahidic scribes tend to draw one long stroke across a whole group. Bohairic
uses the *djinkim*, a short mark over an individual letter, and later
Bohairic manuscripts turn it into a grave accent leaning over the vowel.
Modern printed Bohairic mostly follows that later convention, which is why a
Bohairic liturgical text and a Sahidic literary edition can look like they
are using two unrelated systems. They are.

## Where the encoding goes wrong

Unicode gives you more than one plausible answer, and editions do not agree
on which to use:

| Codepoint | Name | Behaviour |
|---|---|---|
| `U+0304` | combining macron | sits over one base letter |
| `U+0305` | combining overline | joins up across letters in good fonts |
| `U+FE24`–`U+FE26` | macron halves | an explicit left/middle/right span |

The half-macron sequence is the only one that reliably draws a *single*
stroke over three or more letters, and almost nothing renders it correctly.
`U+0305` is the pragmatic choice: it degrades to a series of short strokes
rather than to nothing.

---

Practical upshot when you are typing Coptic into anything: use `U+0305`,
put it after each letter under the stroke, and accept that the join will
be imperfect outside a font built for the job. Which fonts those are is
[its own note](@/notes/fonts-that-render-coptic.md).
