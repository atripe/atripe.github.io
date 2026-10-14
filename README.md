# atripe.github.io

Zola site. <https://atripe.github.io>

## Develop

```sh
nix develop      # zola on PATH
zola serve       # http://127.0.0.1:1111
```

Do not pass `--base-url` to `zola serve`. It already rewrites URLs to its
own address, and it *appends its listen port to whatever you give it* —
`zola serve --base-url http://localhost:8000` emits
`http://localhost:8000:1111/style.css`, which no browser can fetch, so the
page loads unstyled.

`--base-url` belongs to `zola build`, which otherwise bakes the production
`base_url` into every URL and only works on the live domain:

```sh
zola build --base-url http://localhost:8000
python3 -m http.server 8000 --directory public
```

## Build

```sh
nix build   # -> ./result, the whole site
zola check  # validate links
```

There is nothing to build but the site itself: `nix build` runs Zola over the
tree and that is the whole derivation, so `zola serve` and the published page
see the same files.

## Layout

```
config.toml               site settings; author, email, github under [extra]
content/_index.md         front page; the section the projects belong to
content/<project>.md      one project, served at /<project>/
content/<project>/        same, with assets: index.md plus its images
content/about/_index.md   about page
content/links/_index.md   links page
templates/                Tera templates; base.html holds the page furniture
templates/shortcodes/     copt.html, cite.html, margin.html
static/style.css          all of the CSS
static/fonts/             Gentium (WOFF2), the Coptic face (TTF)
                          + the OFL for Gentium
flake.nix                 dev shell + the site derivation
```

Projects sit at the root — `/word-division/`, not `/projects/word-division/`.
The underscore decides what lands in the project list:

| Path | Zola calls it | In the list? |
|---|---|---|
| `content/thing.md` | page | yes |
| `content/thing/index.md` | page bundle — assets go beside it | yes |
| `content/thing/_index.md` | section | no |

## Adding a project

```toml
+++
title = "Project name"
description = "Optional. Shows under the title in the list."
weight = 20                                    # lower sorts first

[extra]
status = "Optional. Shows on the list and the project page."
repo = "https://github.com/atripe/some-repo"   # optional
+++
```

Projects have no dates and no tags; `weight` sets the order.

## Shortcodes

```
{{/* copt(t="ⲃ ⲗ ⲙ ⲛ ⲣ") */}}                     Coptic, with the fallbacks
{{/* cite(t="Crum, <em>A Coptic Dictionary</em> (Oxford, 1939), 168a.") */}}
{{/* margin(t="An aside, unnumbered.") */}}
```

`copt` is now optional: the Coptic face is applied by codepoint, so Coptic
pasted straight into a paragraph is already set in it. The shortcode adds the
list of installed Coptic fonts to fall back to when the webfont does not load.

`cite` puts a superscript marker in the text and the reference in the right
margin. Numbering is a CSS counter, so inserting one mid-draft renumbers the
rest for free. `margin` is the same thing without a number. Both take HTML
in `t`, which is how you get italics into a title.

A figure goes in the margin by carrying the class directly:

```html
<figure class="marginnote">
  <img src="thing.png" width="801" height="1068" alt="Thing">
</figure>
```

Notes are floats with `clear: right`, so each one waits for the previous to
finish. A tall margin figure therefore pushes the notes after it down the
page, away from the paragraph that cited them. That is the cost of doing
this without JavaScript; keep margin figures short if it bothers you.

Below 66em there is no room for the margin, and notes fall back to indented
blocks in the text.

## Design

Solarized, light or dark by `prefers-color-scheme`. No JavaScript, no
external requests. Feeds and syntax highlighting are off — highlighting
emits inline styles that ignore the dark mode.

Two faces, one job each, both served from this origin.

**Gentium 7.000** (SIL OFL 1.1, `fonts/OFL-Gentium.txt`) sets the page. SIL
made it for linguists, so it covers Latin through Ext-B, IPA, Cyrillic, and
the polytonic Greek a page about Coptic reaches for on its first citation.
Three weights as WOFF2, converted from the release TTFs but not subset: the
OFL reserves the name "Gentium" for unmodified fonts.

**CS Avva Shenouda Unicode 2.0** (Coptic Font Standard Project,
`CopticChurch.net/coptic_fonts`) sets the Coptic. It is 73 glyphs — the two
Coptic ranges, the combining marks and a space — so it cannot set a page on
its own, and it does not have to: its `@font-face` carries a `unicode-range`,
which means **any Coptic character anywhere on the site is set in it**, marked
up or not, and every other character falls through to Gentium. Its letters
are 527 units against Gentium's 615-unit capitals, so `size-adjust: 117%`
puts the two at one height on the font rather than on a class.
Its own metadata carries no licence beyond a 2002 copyright line; the file
permits embedding (`fsType` 0) and the CS fonts are distributed as freeware
for Coptic use, but that is not the explicit grant the OFL gives.

`local()` is first in each `@font-face` and `font-display: swap` is set, so
installed copies cost nothing and text paints before the download finishes.
The two faces the first paint needs are preloaded in `base.html`.

Typography follows the usual rules rather than the browser defaults: an 18px
body, a 34rem measure that comes to about 72 characters, oldstyle figures in
prose and lining tabular ones in tables, code and note numbers, automatic
hyphenation in the text column, `text-wrap: pretty` on paragraphs and
`balance` on headings.

To drop the weight, delete the `@font-face` blocks and `static/fonts/` —
`--serif` still names both faces first, so anyone who has them installed
keeps them.

## Deploy

Pushing to `main` runs `.github/workflows/pages.yml`: builds with Nix,
publishes to GitHub Pages. Requires **Settings → Pages → Source: GitHub
Actions**, and a public repo unless the account has a paid plan.
