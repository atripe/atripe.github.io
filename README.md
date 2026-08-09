# atripe

A small portal for Coptic — notes, orthography, manuscripts, and links.
Built with [Zola](https://www.getzola.org), dressed as a 1998 homepage.
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
zola check       # validate internal links (external ones may false-positive)
```

## Layout

```
config.toml        site settings; sidebar links, hit counter, guestbook under [extra]
content/           markdown; content/notes/ is the blog section
templates/         Tera templates; base.html holds all the chrome
static/style.css   the entire design, one file, no images, no build step
flake.nix          dev shell + a derivation that builds the site
```

## Deploy

Pushing to `main` runs `.github/workflows/pages.yml`, which builds with Nix
and publishes to GitHub Pages. Enable it once under **Settings → Pages →
Build and deployment → Source: GitHub Actions**.

## Writing a note

Add a file under `content/notes/`:

```toml
+++
title = "Title"
description = "One line; it shows up as a gloss in the index."
date = 2026-08-09

[taxonomies]
tags = ["orthography"]
+++
```

The newest note automatically gets the blinking `NEW!` tag.

Wrap Coptic in `<span class="copt">…</span>` so it picks up the font stack
(Antinoou → New Athena Unicode → Noto Sans Coptic → Segoe UI Historic).
Nothing is loaded from a font CDN; readers with none of those installed
fall back to a generic serif.

## About the design

Deliberately period: tiled ankh background, beveled Win95 boxes, Times body
copy, a marquee, a hit counter, a webring, and a permanent construction
sign. Every graphic is CSS — the site ships no image files.

Three things are not period, and stay: visible keyboard focus, a layout
that collapses to one column on phones, and `prefers-reduced-motion`, which
stops the marquee and the blinking.

Tunable in `config.toml` under `[extra]`: `subtitle`, `counter` (the
odometer digits), `guestbook` (where "sign the guestbook" points), and
`elsewhere` (the sidebar link list).
