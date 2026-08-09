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
nix build        # -> ./result
zola check       # validate links
```

## Layout

```
config.toml               site settings; author, email, github under [extra]
content/_index.md         front page; the section the projects belong to
content/<project>.md      one project, served at /<project>/
content/<project>/        same, with assets: index.md plus its images
content/about/_index.md   about page
content/links/_index.md   links page
templates/                Tera templates; base.html holds the page furniture
templates/shortcodes/     copt.html wraps Coptic text for the font stack
static/style.css          all of the CSS
static/fonts/             New Athena Unicode (WOFF) + OFL licence
flake.nix                 dev shell + a derivation that builds the site
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
{{/* copt(t="ⲃ ⲗ ⲙ ⲛ ⲣ") */}}                     Coptic, in the font stack
{{/* cite(t="Crum, <em>A Coptic Dictionary</em> (Oxford, 1939), 168a.") */}}
{{/* margin(t="An aside, unnumbered.") */}}
```

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

New Athena Unicode 5.008 (Society for Classical Studies, SIL OFL 1.1)
covers Latin, polytonic Greek and both Coptic ranges. Three weights, about
1.3 MB, served from this origin. `local()` is first in each `@font-face`
and `font-display: swap` is set, so installed copies cost nothing and text
paints before the download finishes. To drop the weight, delete the
`@font-face` blocks and `static/fonts/` — `--serif` still names the font
first, so anyone who has it installed keeps it.

## Deploy

Pushing to `main` runs `.github/workflows/pages.yml`: builds with Nix,
publishes to GitHub Pages. Requires **Settings → Pages → Source: GitHub
Actions**, and a public repo unless the account has a paid plan.
