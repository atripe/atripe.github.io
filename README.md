# Atripe

Tools for reading, typing and finding Coptic — a small portfolio site.
Built with [Zola](https://www.getzola.org).
Live at <https://atripe.github.io>.

## Develop

```sh
nix develop      # zola on PATH
zola serve       # http://127.0.0.1:1111, live reload
```

## Build

```sh
nix build        # -> ./result, the finished site
zola build       # -> ./public, if you prefer
zola check       # validate links (some external hosts false-positive)
```

## Layout

```
config.toml               site settings; author, email, footer links under [extra]
content/_index.md         front page, and the section the projects belong to
content/<project>.md      one project, served at /<project>/
content/about/_index.md   colophon
content/links/_index.md   the links page
templates/                Tera templates; base.html holds the page furniture
templates/shortcodes/     copt.html, the Coptic wrapper
static/style.css          the whole design
static/fonts/             New Athena Unicode (WOFF) + its licence
flake.nix                 dev shell + a derivation that builds the site
```

Projects live at the root — `/coptic-keyboard/`, not `/projects/coptic-keyboard/`.
That works because `about` and `links` are *sections* (directories with an
`_index.md`), so the root section's page list contains only the projects.
Adding a top-level `.md` file adds a project; adding a directory with an
`_index.md` adds a page that stays out of the list.

## Adding a project

Create `content/<slug>.md`:

```toml
+++
title = "Project name"
description = "One line; it appears under the title in the list."
date = 2026-08-09          # last worked on; also sorts the list

[taxonomies]
tags = ["tools"]

[extra]
status = "Working. Linux and Windows; macOS is untested."
repo = "https://github.com/atripe/some-repo"   # optional
+++
```

`status` is optional and shows on both the list and the project page. Be
honest in it — it is the most useful line on the page. `repo` is optional
too and renders as a link on the project page only.

For Coptic, use the shortcode rather than typing the letters bare:

```
The sonorants {{/* copt(t="ⲃ ⲗ ⲙ ⲛ ⲣ") */}} carry their own syllable.
```

## Design

Solarized (Ethan Schoonover), light or dark according to
`prefers-color-scheme` — the browser decides, there is no toggle. The
masthead uses base01/base1 rather than an accent, so it flips with the
scheme instead of sitting at one fixed hue in both. The
stylesheet sets colour, a reading measure and the type; everything else is
the browser's default rendering of ordinary HTML. No JavaScript, no
external requests, nothing measured.

The face is **New Athena Unicode** 5.008, from the Society for Classical
Studies, under the SIL Open Font License 1.1 (`static/fonts/OFL.txt`). It
covers Latin, polytonic Greek and both Coptic ranges in one file, so Coptic
sits in the same face as the text around it. Three weights ship as WOFF and
total about 1.3 MB — by far the heaviest thing on the site. They are served
from this origin, never a font CDN, `font-display: swap` means text paints
before they arrive, and `local()` comes first in each `@font-face` so
readers who already have the font download nothing.

To drop the weight entirely, delete the `@font-face` blocks and
`static/fonts/`: the `--serif` stack still names New Athena Unicode first,
so anyone with it installed keeps it and everyone else falls back to Times.

Syntax highlighting is off in `config.toml`. Zola implements it with inline
styles, which would ignore the dark mode. Feed generation is off too — this
is a portfolio, not a blog.

## Deploy

Pushing to `main` runs `.github/workflows/pages.yml`, which builds with Nix
and publishes to GitHub Pages. Enable it once under **Settings → Pages →
Build and deployment → Source: GitHub Actions**.

Set `author` and `email` in `config.toml` before publishing — `email` ships
as a placeholder, written longhand (`name (at) host (dot) org`) so address
harvesters have to work for it.
