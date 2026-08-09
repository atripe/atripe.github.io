+++
title = "About this page"
description = "What this page is, who keeps it, and where the name and the tagline come from."
+++

## The name

{{ copt(t="Ⲁⲧⲣⲓⲡⲉ") }}, Atripe, is the Upper Egyptian town that gave Shenoute
his epithet. The White Monastery stood just outside it. I named the page
after a place mainly because the alternative was naming it after a person,
and that seemed presumptuous.

## The tagline

*Coptic in the cloud* is not only a joke about where this is hosted.

The *Vita Sinuthii*, the Life of Shenoute traditionally attributed to his
disciple and successor Besa, has Shenoute travel by cloud. In the best
known episode a shining cloud carries him from the White Monastery to
Ephesus so that he can stand with Cyril of Alexandria at the council, and
returns him the same day. He does it more than once; the Life is not shy
about it.

Historians treat the episode as hagiography rather than itinerary, and the
attribution to Besa is itself disputed — the Life as we have it looks
considerably later than Shenoute's lifetime. But it does mean that the
patron saint of this page was, by his biographer's account, the first
person from Atripe to do serious work at a distance without leaving home.

## What it is

Tools, mostly. Things I built because I needed them to read, type or find
Coptic, cleaned up to the point where somebody else can use them. I read
Coptic slowly and I am not a papyrologist. Where something here is
confidently wrong, it is at least wrong in a way somebody can correct.

## How it is put together

The pages are generated from plain text files by
[Zola](https://www.getzola.org) and served as static HTML. The development
environment is a Nix flake; GitHub Actions rebuilds the site whenever I
change a file. Source and code are at
[github.com/atripe](https://github.com/atripe).

One stylesheet, a bit over a hundred lines. It sets the colours —
[Solarized](https://ethanschoonover.com/solarized/), light or dark
according to what your browser asks for — a reading measure, and the type.
Everything else is the browser's own rendering of ordinary HTML.

The face is [New Athena Unicode](https://apagreekkeys.org/NAUdownload.html),
made by the Society for Classical Studies and released under the SIL Open
Font License. It covers Latin, polytonic Greek and both Coptic ranges in
one file, which is why the Coptic on this page sits in the same face as
everything around it instead of jumping into a fallback. It is served from
this site, never from a font CDN, and if you already have it installed your
browser downloads nothing.

There is no JavaScript, nothing is fetched from anyone else's server, and
nothing is measured.

## Terms

Text is CC BY-SA 4.0. Quotations and images keep whatever licence they
arrived with. If you want to reproduce something at length, ask; I will
almost certainly say yes.
