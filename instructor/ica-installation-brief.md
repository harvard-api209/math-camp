# Lab 1 installation clinic: ICA brief

**Meeting:** Thursday, August 13, 3:00–4:00 p.m.
**Rule:** Lab 1 is installation only. We do not begin the data exercise.

## Definition of ready

A student is ready only when all three conditions are visible:

1. `math-camp-2026.Rproj` is open in RStudio;
2. `Rscript code/check_setup.R --codex-confirmed` ends with
   `RESULT: GREEN`; and
3. Codex can read `START-HERE.md` in the same project.

## Room protocol

1. At 3:00, every student runs `Rscript code/check_setup.R` and displays a
   green, yellow, or red status.
2. Route failures by layer so that support moves in a clear order.
3. Preserve the exact command and complete output. Do not diagnose from a
   cropped screenshot when terminal text is available.
4. After each repair, rerun the checker from the project root.
5. Green students may help another student gather evidence, but every student
   runs the final gate on their own laptop.

## Help lanes

| Lane | Typical evidence | First response |
|---|---|---|
| Windows ZIP/path | `.Rproj` or frozen CSV not found | Confirm the ZIP was fully extracted and the `.Rproj` file—not an isolated script—was opened. |
| macOS installer/PATH | Security prompt or Quarto not found | Confirm the official installer, reopen through System Settings if needed, restart RStudio, and rerun. |
| R/packages | Old R or named packages missing | Install only the reported requirement, then rerun. Do not change the course code. |
| Codex/account | Sign-in failure or project files invisible | Confirm the Harvard-supported account and open the folder containing `START-HERE.md`. |

## Exit rule

No unexplained red result leaves the room. If a machine is still not green,
record the operating system, complete checker output, next repair, and the name
of the instructor or ICA who owns follow-up before Lesson 2.
