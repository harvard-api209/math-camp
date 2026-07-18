# Math Camp 2026 teaching plan

This plan turns the four lesson decks into facilitated class meetings rather than short presentations. Slides provide the public teaching sequence; speaker notes provide timing, prompts, demonstrations, and transitions. Lab pages provide complete student-facing instructions.

## Recurring lesson rhythm

Each two-hour lesson uses the same rhythm so students know what to expect:

1. **Arrive and notice (5 minutes):** a visible question students can answer before class begins.
2. **Frame (10 minutes):** purpose, learning objectives, and connection to the continuous policy investigation.
3. **Explain (15 minutes):** one compact conceptual block.
4. **Predict (5 minutes):** students make a commitment before code or an agent runs.
5. **Demonstrate (15 minutes):** instructor live-codes or supervises an agent in real time.
6. **Practice (10 minutes):** pairs modify, diagnose, or explain a bounded example.
7. **Debrief (5 minutes):** compare strategies and make uncertainty visible.
8. **Break and reset (5 minutes):** approximately halfway through longer meetings.
9. **Repeat the explain-predict-demonstrate-practice cycle.**
10. **Exit ticket (5 minutes):** one concept, one check, and one unresolved question.

The two three-hour meetings reserve their last hour for the corresponding lab.

## The teaching model: engine, workshop, investigator

Use the same analogy in every meeting so students do not have to relearn the
technology vocabulary.

- **The LLM is a language engine.** It is exceptionally good at producing a
  plausible next piece of language or code. It is not a database, a source, or
  an independent observer of the policy setting.
- **The harness is the workshop.** It decides which project context reaches the
  model, which tools are available, which actions require permission, what tool
  results return to the conversation, and when the loop stops.
- **The coding agent is the engine operating in the workshop.** Codex and Claude
  Code are products that combine models with harnesses and interfaces.
- **The student is the investigator.** The student frames the policy question,
  writes the work order, watches the action, and decides whether the evidence
  supports the result.

Connect each familiar course tool to a physical object:

| Course tool | Analogy | Teaching point |
|---|---|---|
| R | Laboratory instrument | It performs specified operations; it does not choose the question. |
| RStudio | Lab bench | It keeps code, objects, files, and output visible together. |
| Quarto | Lab notebook | It records the path from question to code to result. |
| Coding agent | Junior research assistant | It can act quickly across the project but needs a clear assignment and supervision. |
| Tests and checks | Measuring instruments | They turn “looks right” into observable evidence. |
| Git diff or change summary | Receipt | It records what changed before the analyst accepts it. |

## The recurring five-pass loop

Every demonstration and lab should visibly pass through the same five stages:

1. **Predict:** What do we expect, and why?
2. **Delegate:** What bounded task will the agent perform?
3. **Observe:** Which files, commands, and outputs did the harness expose?
4. **Verify:** Which R check, source, or clean run can test the result?
5. **Narrate:** What did we accept, revise, reject, or leave unresolved?

Do not collapse “observe” and “verify.” Seeing that an agent ran a command is not
the same as deciding that the command tested the relevant analytical claim.

## Scaffold and fade

The course begins with a fully specified prompt and verification checklist, then
removes support:

- **Lesson 1:** students receive the work order and the checks.
- **Lesson 2:** students complete missing constraints and choose checks.
- **Lesson 3:** students write the review contract and reject irrelevant advice.
- **Lesson 4:** students design the audit contract, rank findings, and defend the
  repair they chose.

This keeps the floor low for students new to code while creating a real ceiling
for experienced programmers. High-ceiling extensions should deepen
verification, provenance, or statistical judgment rather than reward faster
prompting.

## Interaction vocabulary

- **Fist to five:** confidence or agreement from 0 to 5 fingers.
- **Think-pair-share:** one minute alone, two minutes with a partner, then selected room responses.
- **Predict before run:** students write the expected output before code executes.
- **Spot the risk:** students identify the first consequential problem in code, a prompt, a plot, or a claim.
- **Choose a corner:** students move or signal among four policy tracks or answer choices.
- **Human versus agent:** compare a human-first attempt with a generated attempt and name what changed.
- **One-minute paper:** write the strongest supported claim and one limitation.

## Lesson 1: Meet the evidence

**Lesson time:** 120 minutes. **Lab time:** 60 minutes.

The lesson welcomes the room, normalizes different starting points, explains why
the camp has moved from an IDE-only workflow to a human-agent-evidence workflow,
and builds the engine/workshop/investigator mental model. It distinguishes AI,
an LLM, a chat interface, an agent, and a harness; introduces Codex and Claude
Code as products rather than as models; establishes privacy, permissions, and
verification norms; and then teaches the first R inspection loop.

The opening asks explicitly, **“Is it still worth learning to code?”** Students
vote before hearing an answer and distinguish syntax recall from reading,
modifying, decomposing, testing, and designing. Use Andrew Ng's argument that
coding plus prompting expands what a person can accomplish, while code retains
an important advantage for inspectable and repeatable actions. Then restore the
2024 Math Camp destination in updated form: students should leave ready for the
semester, able to move in R, able to craft questions and locate help, and
confident enough to make and repair mistakes in public. The final line is:
**independence does not mean working without help; it means retaining
independence of judgment.**

Before any data exercise, run a **non-negotiable setup gate**. Every student must
open the `math-camp/2026` project, start R, load `tidyverse` and `here`, confirm
that `here()` points to the course project, run `quarto check`, sign in to Codex,
and locate the frozen WDI file. Use green/yellow/red status: green students can
help, yellow students repair a package or path problem with the teaching team,
and red students complete the missing installation or sign-in. Do not advance
to the inspection code while a known setup failure remains. Budget 15–20 minutes
and keep the full setup guide open.

Planned interactions: arrival prompt, mandatory setup gate,
AI-comfort × coding-experience archetype discussion, “is coding still worth learning?” room
vote, “engine or workshop?” classification, a human tool-call simulation,
tool-matching check, prompt repair, prediction before code,
missing-versus-zero check, policy-track choice, and exit ticket.

## Lesson 2: Build the dataset

**Lesson time:** 120 minutes. **Lab time:** 60 minutes on the following day.

The lesson follows one indicator from source to analysis table. Students learn file layers, tidy structure, types, keys, missingness, joins, assertions, provenance, and version comparison. The agent is introduced as a supervised data engineer whose work must be reviewed through a diff and explicit checks.

Use the analogy of **chain of custody**: each transformation should leave a
trace, and raw evidence is never rewritten. Planned interactions: reconstruct
the data pipeline, identify the key, predict a many-to-many join, choose the
correct verb, diagnose silent row loss, inspect an update contract, compare a
change receipt, and write a provenance sentence.

## Lesson 3: Compare patterns

**Lesson time:** 120 minutes. **Lab time:** 60 minutes.

The lesson builds a comparison from question to sample, plot, simple regression, residual check, and qualified claim. It restores the visual critique and progressive `ggplot2` construction used in earlier Math Camps while connecting each design choice to a policy interpretation.

Use the analogy of **compression and lenses**: a plot and a model compress many
rows into a smaller object; a specification is a lens that emphasizes some
features and hides others. Planned interactions: critique a bad plot, map
variables to aesthetics, predict a logarithmic transformation, interpret a
coefficient in units, inspect a surprising observation, climb the claim ladder,
and run separate code and statistical agent reviews.

## Lesson 4: Audit the handoff

**Lesson time:** 120 minutes. **Lab time:** 60 minutes on the following day.

The lesson explains reproducibility, clean sessions, Quarto as a field notebook rather than the website framework, README and provenance requirements, AI-use disclosure, and the four-part handoff audit. Students prepare for an exchange in which another person runs the project cold.

Use the analogy of **a recipe tested in someone else's kitchen**: the author
cannot silently provide ingredients, objects, or remembered steps. Planned
interactions: hidden-state demonstration, order-the-workflow task, clean-render
prediction, README critique, AI-use-note rewrite, severity ranking, handoff
rehearsal, and final confidence map.

## Facilitation rules

- Never speak for more than 12 consecutive minutes without a student action.
- Demonstrations must include at least one intentional error or failed assumption.
- Ask students to predict before revealing output.
- Keep the frozen dataset and a no-agent fallback available if internet services fail.
- Do not equate speed with mastery; invite multiple solution paths.
- Working groups are temporary. Every student keeps an individual script or notebook.
- No artifact is graded or submitted.
