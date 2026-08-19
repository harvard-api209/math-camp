# Lesson 2 / Lab 2 release audit — v1.0.3

Audit date: August 19, 2026

Candidate: `release-candidates/lab-2-v1.0.3/math-camp-2026-lab-2-v1.0.3.zip`

SHA-256: `91f69cb16de5f68a2a1320f3301864a914a87075b3ebbfb3e1715008b6dce4c4`

Status: ready for instructor approval. The GitHub release has not yet been
published.

## Shared instructional thread

The deck, live walkthrough, student starter, Lab 2 guide, and release
instructions now use the same thread:

1. Begin with the income and under-five-mortality policy question.
2. Define the population, economy-year unit, key, period, and variables.
3. Inspect the 4,991-row frozen source before changing it.
4. Use `select()` and `filter()` and account for the 695 excluded rows.
5. Take a visible 10-minute break after the first sample checkpoint.
6. Introduce `mutate()`, `arrange()`, `group_by()`, and `summarise()` one step
   at a time.
7. Reshape and join only after naming the source and target units.
8. Save a 4,296-row analysis table and a one-row build record.
9. Run the independent verifier; all eight named checks must pass.
10. Ask Codex for a read-only audit of one deliberately overreaching briefing
    claim, using exact file-and-value citations.
11. End with one supported fact and one unanswered question for Lesson 3.

The lesson walkthrough demonstrates the complete sequence. The Lab 2 starter
uses the same sequence as a scaffold rather than providing the finished code.
The completed builder remains a reference after a genuine attempt.

## Student release contents

The ZIP contains only the student project:

- the RStudio project file;
- setup and evidence-inventory scripts;
- the complete Lesson 2 walkthrough;
- the Lab 2 starter;
- the reference builder and independent verifier;
- the frozen WDI teaching file and indicator dictionary;
- `START-HERE.md`, release metadata, and an empty `outputs/` directory.

Slides, website source, instructor materials, later labs, credentials, and
generated outputs are excluded.

`code/check_setup.R` remains available as an optional full readiness check and
uses the traffic-light language established for Lesson 1. Lesson 2 itself does
not require that command. The Lesson 2 verifier uses the distinct and explicit
completion signal `RESULT: PASS`.

## Verification performed

The candidate ZIP was extracted into a clean temporary directory. From that
extracted project, the following completed successfully:

- `Rscript code/check_setup.R --codex-confirmed`;
- `Rscript code/01-inspect.R`;
- `Rscript code/lab-2-starter.R`;
- `Rscript code/lesson-2-walkthrough.R`;
- `Rscript code/02-build-analysis.R`; and
- `Rscript code/02-verify-analysis.R`.

The final verifier reported eight of eight checks as `TRUE`, 4,296 rows, 188
economies, and `RESULT: PASS`. The ZIP checksum validates, its listing matches
the manifest, its `outputs/` directory is empty, and every shared source/data
file matches the corresponding repository file byte for byte.

The rebuilt Lesson 2 PDF contains 78 pages at 16:9. The log contains no LaTeX
errors, undefined citations, or overfull boxes. The new break frame and the Lab
2 route were visually inspected after rendering.
