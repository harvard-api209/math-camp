# Math Camp 2026

A native static teaching book for API 209 Math Camp 2026. The main website is HTML, CSS, and JavaScript. The student-facing lesson decks are LaTeX Beamer PDFs. Quarto is used only for the optional student field notebook.

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

## Run the student project

Students should download the complete repository, open
`math-camp-2026.Rproj`, and begin with [START-HERE.md](START-HERE.md). The first
automated gate is:

```sh
Rscript code/check_setup.R --codex-confirmed
```

The project includes a complete common path (`code/01-inspect.R` through
`code/03-compare.R`), an instructor-led Lesson 2 script at
`code/lesson-2-walkthrough.R`, a safe public-data update script, four optional
policy-track recipes, and a deliberately broken handoff clinic. Every analysis
script starts from a saved file; none requires an object left in an R console.

## Book architecture

- `index.html`: public student homepage, schedule, lesson index, policy tracks, and resource guide
- `lessons/lesson-1/` and `lessons/lesson-2/`: the two student lessons in the current release, with explained code, bounded agent tasks, and embedded Beamer PDFs
- `labs/lab-1/` and `labs/lab-2/`: the installation clinic and the 60-minute build-table lab in the current release; Lab 1 includes a printable LaTeX handout under `handout/`
- `setup/`, `datasets/`, `ai-guide/`, `glossary/`: student field guides
- `instructor/`: unlisted teaching notes and a detailed facilitation plan; `noindex` is not access control
- `research/evidence-brief.md`: research base and design rationale
- `data/`: frozen teaching data, documentation, and reproducible build script
- `materials/math-camp-field-notebook.qmd`: optional personal notebook
- `examples/book-concept-v1/`: exact archive of the approved visual prototype

## Update a lesson deck

The current public decks use the shared files `slides/beamer_preamble.tex`, `slides/beamer_style.sty`, and `slides/references.bib`. Each lesson keeps its metadata in `metadata.tex`, its entry point in `main.tex`, and one LaTeX file per major section under `sections/`.

To edit and compile Lesson 1:

```sh
cd slides/lesson-1
latexmk -pdf main.tex
cp main.pdf lesson-1.pdf
```

Lesson 2 follows the same pattern:

```sh
cd slides/lesson-2
latexmk -pdf main.tex
cp main.pdf lesson-2.pdf
```

The website embeds `lesson-1.pdf` and `lesson-2.pdf`. Edit their English LaTeX sections directly. After each change, compile the deck, scan the log, and inspect every rendered slide before replacing the public PDF.

The current PDFs contain 63 pages for Lesson 1 and 73 pages for Lesson 2, including Lesson 2's progressive answer reveal and step-by-step source checks. Lesson 2 moves from a policy-briefing question to a clear plan for the table students need, introduces R grammar and data verbs in that context, demonstrates reshaping and join diagnostics, and ends with an independently verified build and the Lab 2 handoff. Later lesson materials remain internal drafts and are not part of the public release.

The Lab 1 handout is a standalone, single-file LaTeX article. Rebuild it with:

```sh
cd labs/lab-1/handout
latexmk -pdf main.tex
cp main.pdf lab-1-handout.pdf
```

## Rebuild the default dataset (maintainers only)

The checked-in CSVs are frozen through 2022. The build refuses to overwrite
them unless a maintainer explicitly opts in:

```sh
MATH_CAMP_WRITE_FROZEN=YES Rscript data/build_wdi.R
```

The script writes a wide file, a long file, and a full indicator dictionary
after validating keys, years, schema, and metadata. Students extend one public
indicator with `code/04-update-indicator.R`; it writes a dated file under
`data/updates/` and cannot overwrite the frozen baseline.

## Instructor access

The `instructor/` page includes `noindex,nofollow`, but a public static site cannot keep a known URL private. Protect that path through the hosting provider or exclude it from a public deployment if the notes must be confidential.

## Design system

- Editorial, book-like structure inspired by technical manuals
- Self-hosted Departure Mono typeface
- Warm paper background, justified black serif prose, Harvard crimson chapter headings, and minimal rules
- Far-edge chapter contents on desktop and a larger right-side reading rail with section progress
- Restrained scroll reveals and canvas animation with reduced-motion support
- No dependency on a website framework
