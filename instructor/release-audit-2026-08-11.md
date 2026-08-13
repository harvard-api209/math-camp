# Math Camp current-release audit

**Audited:** August 11, 2026
**Release boundary:** Lesson 1, Lab 1, Lesson 2, and Lab 2

## Requirement evidence

| Requirement | Current evidence | Result |
|---|---|---|
| Use the four official part names throughout | Homepage, lesson and lab headers, page-turn links, slide library, curriculum map | Pass |
| Remove the result-first and visible-chain framing | Homepage schedule and Lesson 1 opening use task, tools, learning, and judgment; old phrases are absent from public text | Pass |
| Use the earlier workshop only as a teaching structure | Lesson 1 keeps the task-first tool map, risk and verifiability, understanding, cognitive debt, and bounded work order; the workshop audience example is absent | Pass |
| Keep only the final English slide source | The modular English LaTeX sections are the only prose source kept beside each deck | Pass |
| Use the crimson LaTeX Beamer template | Shared `beamer_preamble.tex` and `beamer_style.sty`; modular lesson sources; 16:9 PDFs | Pass |
| Remove the public web-deck implementation | Lesson pages and slide pages embed `lesson-1.pdf` and `lesson-2.pdf`; public HTML has no web-slide dependencies | Pass |
| Keep labs as web guides, without slide PDFs | Lab 1 and Lab 2 link to their lesson and reference guides only | Pass |
| Keep later drafts outside the student release | Student navigation exposes only Lessons/Labs 1–2; curriculum map labels later files as unreleased drafts | Pass |

## PDF evidence

- Lesson 1 compiles from `slides/lesson-1/main.tex` with `latexmk -pdf`.
- Lesson 2 compiles from `slides/lesson-2/main.tex` with `latexmk -pdf`.
- The final log scan found no LaTeX errors, undefined control sequences,
  overfull boxes, fatal errors, or missing source files.
- Lesson 1 has 53 PDF pages; Lesson 2 has 45 PDF pages. Both are 16:9.
- Every page of both PDFs was rendered to an image and reviewed in four contact
  sheets per lesson. No title, table, code block, or source note is clipped.

## Website evidence

- Eight public pages were loaded locally: the homepage, both lessons, both
  labs, the slide library, and both PDF pages.
- Desktop browser checks found no document-level horizontal overflow and no old
  student-facing terms on those pages.
- A 390 × 844 mobile check found no horizontal overflow on the homepage,
  lessons, labs, or Lesson 1 PDF page. The mobile contents button appears on
  the student book pages.
- Both embedded PDF objects load and preserve a 16:9 area.
- The local-link audit checked 154 links, assets, PDF objects, and fragments;
  every target exists.
- Both stable PDF URLs return HTTP 200 with `application/pdf`.
- `Rscript code/check_setup.R --codex-confirmed` returns `RESULT: GREEN`.
- `Rscript code/02-build-analysis.R` rebuilds the 4,296-row health analysis
  table from the frozen input.
- `git diff --check` passes.

## Operational note

The setup clinic remains the first gate. Students either leave with
`RESULT: GREEN` or with the exact error and an owned repair plan. Nothing is
submitted or graded.
