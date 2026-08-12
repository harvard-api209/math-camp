# Student email for Lesson 1 and Lab 1

**Subject:** Before our first Math Camp session: software and project setup
**BCC:** Victoria and Dan

Dear students,

I look forward to welcoming you to API 209 Math Camp. Our first session will
introduce the course workflow with R, RStudio, Quarto, and an AI coding agent.
The final hour will be an installation clinic. We will use that time to confirm
that every laptop is ready for the next lesson.

Please complete these steps before the session:

1. Read the [Math Camp setup
   guide](https://harvard-api209.github.io/math-camp/setup/).
2. Install the current versions of:
   - [R](https://cran.r-project.org/) (version 4.2 or newer);
   - [RStudio Desktop](https://posit.co/download/rstudio-desktop/);
   - [Quarto](https://quarto.org/docs/get-started/); and
   - Codex, using your Harvard-supported account.
3. Download the [Math Camp project from
   GitHub](https://github.com/harvard-api209/math-camp). Select **Code → Download
   ZIP**, extract the complete folder, and open `math-camp-2026.Rproj` in
   RStudio. Windows users should confirm that they are working from the
   extracted folder.
4. Open the **Terminal** tab in RStudio and run:

   ```sh
   Rscript code/check_setup.R --codex-confirmed
   ```

The final line should say `RESULT: GREEN`. A yellow or red result is also useful
because it tells us what needs attention. Please save the complete terminal
output and bring it to the installation clinic.

Please bring:

- your laptop and charger;
- access to your Harvard account;
- the extracted Math Camp project folder; and
- the complete terminal output from the readiness check.

Claude Code is an optional alternative during the course. Codex will be our
common coding agent, so please make sure that Codex can open the Math Camp
folder and read `START-HERE.md`.

Previous coding experience is welcome but not required. Lab 1 has no submission
and no grade. Its purpose is to leave every student with a green readiness check
or a specific repair plan with a named person who can help.

See you at Math Camp!

Best,
Rony
