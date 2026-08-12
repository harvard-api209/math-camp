# Math Camp implementation check — August 11, 2026

This note records the current implementation after the teaching-design review.
The current student release contains Lesson 1, Lab 1, Lesson 2, and Lab 2.

## Decisions that govern the current build

- [x] **Use four named parts, not chapters.** The public navigation and prose
  refer only to Lesson 1, Lab 1, Lesson 2, and Lab 2.
- [x] **Use the earlier workshop as a teaching structure, not as course
  content.** Lesson 1 keeps the task-first tool map, risk and verifiability,
  understanding, cognitive debt, and bounded-work-order ideas. It does not use
  the workshop audience or country example.
- [x] **Make Lab 1 installation-only.** Do not begin the R exercise while a
  known setup failure remains.
- [x] **Treat installation as the first operational risk.** Plan explicitly for
  Windows ZIP and path problems, R and RStudio mismatches, missing packages,
  Quarto on `PATH`, and Codex project access.
- [x] **Use LaTeX Beamer PDFs.** The two public lesson decks use the shared
  crimson Beamer template in 16:9. The public pages do not use web slides.
- [x] **Publish only the current materials.** Later draft files are absent from
  student navigation and require review before any release.

## Actions and evidence

| Action | Status | Evidence |
|---|---:|---|
| Rebuild Lesson 1 around AI, coding, understanding, and judgment | Complete | Student page, Spanish planning draft, modular LaTeX source, and PDF |
| Keep Lab 1 as a complete installation clinic | Complete | Lab page, readiness gate, and ICA help lanes |
| Build Lesson 2 around a checked country-year table | Complete | Student page, Spanish planning draft, modular LaTeX source, and PDF |
| Keep Lab 2 as a bounded table-building sprint | Complete | Lab page and runnable R path |
| Remove chapter terminology from the current release | Complete | Public text and navigation audit |
| Replace public web slide decks with Beamer PDFs | Complete | Stable PDF URLs and embedded PDF viewers |

## Installation lab operating rule

The room does not move to analysis until every student reaches one of two
states:

1. **Green:** the automated check passes and Codex opens the course project; or
2. **Owned repair:** a named ICA has the exact error, operating system, command,
   and next repair step.

Students who become green early join a help lane or read `START-HERE.md`; they
do not begin a separate coding assignment that fragments the room.
