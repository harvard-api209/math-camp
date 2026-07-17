# Math Camp 2026

A native static teaching book for API 209 Math Camp 2026. The main website is HTML, CSS, and JavaScript. Quarto is used only for replaceable RevealJS slide decks and the optional student field notebook.

## Published site

The public teaching book is published with GitHub Pages at:

<https://harvard-api209.github.io/math-camp/>

The repository contains no files from the previous Quarto website. It begins from the approved 2026 static-book design.

## Preview the full site

From this directory:

```sh
python3 -m http.server 8080
```

Open `http://localhost:8080`.

Opening `index.html` directly also works for most pages, but a local server more closely matches deployment and makes iframe behavior easier to verify.

## Book architecture

- `index.html`: public student homepage, schedule, lesson index, policy tracks, and resource guide
- `lessons/lesson-1/` through `lesson-4/`: lesson chapters with embedded decks
- `labs/lab-1/` through `lab-4/`: lab guides and mini hackathon
- `setup/`, `datasets/`, `ai-guide/`, `glossary/`: student field guides
- `instructor/`: unlisted teaching notes; `noindex` is not access control
- `research/evidence-brief.md`: research base and design rationale
- `data/`: frozen teaching data, documentation, and reproducible build script
- `materials/math-camp-field-notebook.qmd`: optional personal notebook
- `examples/book-concept-v1/`: exact archive of the approved visual prototype

## Update a lesson deck

Edit the lesson source, keep `output-file: index.html`, and render from this directory:

```sh
quarto render slides/lesson-1/slides.qmd
```

The lesson chapter embeds `slides/lesson-1/index.html`, so no lesson-page edit is required. Repeat with lesson 2, 3, or 4. Shared deck styling lives in `slides/slide-theme.scss`.

To render every deck:

```sh
for lesson in 1 2 3 4
do
  quarto render "slides/lesson-${lesson}/slides.qmd"
done
```

## Rebuild the default dataset

The checked-in CSVs are frozen through 2022. Rebuild them from the official World Bank API with:

```sh
Rscript data/build_wdi.R
```

The script writes a wide file, a long file, and an indicator dictionary. Students extending the data should write a new dated output rather than overwrite the frozen baseline.

## Instructor access

The `instructor/` page includes `noindex,nofollow`, but a public static site cannot keep a known URL private. Protect that path through the hosting provider or exclude it from a public deployment if the notes must be confidential.

## Design system

- Editorial, book-like structure inspired by technical manuals
- Self-hosted Departure Mono typeface
- Warm paper background, cobalt blue, black rules, square geometry
- Restrained scroll reveals and canvas animation with reduced-motion support
- No dependency on a website framework
