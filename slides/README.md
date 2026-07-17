# Slide decks

Each lesson page embeds a stable address:

- `slides/lesson-1/index.html`
- `slides/lesson-2/index.html`
- `slides/lesson-3/index.html`
- `slides/lesson-4/index.html`

The editable source beside each deck is `slides.qmd`. To replace a deck without changing the website, edit that file and render it from the `math-camp/2026` directory:

```sh
quarto render slides/lesson-1/slides.qmd
```

The shared visual system is `slides/slide-theme.scss`. Keep `output-file: index.html` in each deck front matter so lesson-page embeds and full-screen links remain stable.

The main website is native HTML, CSS, and JavaScript. Quarto is used here only as a slide-authoring tool.
