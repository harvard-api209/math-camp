# Math Camp 2026 teaching plan

This plan uses the four lesson decks as the spine of facilitated class meetings. Slides provide the public teaching sequence; speaker notes provide timing, prompts, demonstrations, and transitions. Lab pages provide complete student-facing instructions.

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

Use the same analogy in every meeting to keep the technology vocabulary stable.

- **The LLM is a language engine.** It is exceptionally good at producing a
  plausible next piece of language or code. Evidence still comes from project
  files, primary sources, code behavior, and the policy setting.
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
| R | Laboratory instrument | It performs specified operations; the analyst chooses the question. |
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

Teach “observe” and “verify” as separate steps. A tool log shows that an agent
ran a command. Verification asks whether that command tested the relevant claim.

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
verification, provenance, and statistical judgment. The high ceiling requires
more than prompting speed.

## Interaction vocabulary

- **Fist to five:** confidence or agreement from 0 to 5 fingers.
- **Think-pair-share:** one minute alone, two minutes with a partner, then selected room responses.
- **Predict before run:** students write the expected output before code executes.
- **Spot the risk:** students identify the first consequential problem in code, a prompt, a plot, or a claim.
- **Choose a corner:** students move or signal among four policy tracks or answer choices.
- **Human versus agent:** compare a human-first attempt with a generated attempt and name what changed.
- **One-minute paper:** write the strongest supported claim and one limitation.

## Lesson 1: AI, coding, and judgment

**Lesson time:** 120 minutes. **Lab time:** 60 minutes.

Begin by welcoming the room and recognizing that students have different
starting points. Some have not written code before; some already use R; many
know a chat interface but not a coding agent inside a project. Use the light
archetypes exercise to make this variation visible without asking students to
identify themselves publicly. Then introduce the driving question: **what
should we delegate, to which system, and with what evidence?**

The lesson then builds the engine/workshop/investigator mental model. It
distinguishes an LLM, chat interface, agent, and harness; treats R, RStudio, and
Quarto as tools with distinct jobs; and introduces Codex and Claude Code as
products that package models, tools, and harnesses. Use the risk-by-verifiability matrix and require
four items before execution: goal, context, permission, and proof.

The opening asks explicitly, **“Is it still worth learning to code?”** Students
vote before hearing an answer and distinguish syntax recall from reading,
modifying, decomposing, testing, and designing. Use Andrew Ng's argument that
coding plus prompting expands what a person can accomplish, while code retains
an important advantage for inspectable and repeatable actions. Then restore the
2024 Math Camp destination in updated form: students should leave ready for the
semester, able to move in R, able to craft questions and locate help, and
confident enough to make and repair mistakes in public. The final line is:
**students should use help while retaining responsibility for judgment.**

The final hour is an **installation clinic**. The evidence inventory and R
analysis begin after the readiness gate. Every student opens the project, starts R, verifies the required
packages, finds Quarto, locates the frozen WDI file, signs in to Codex, and runs
`Rscript code/check_setup.R --codex-confirmed`. Green students help gather
diagnostic evidence. Yellow and red students work through macOS, Windows,
package, path, or account lanes. A student leaves either green or with the exact
failure, next repair, and a named instructor or ICA responsible for follow-up.

Planned interactions: light archetype discussion, “is coding still worth
learning?” reflection, engine/workshop classification, human tool-call
simulation, risk-and-verifiability placement, weak-to-bounded request repair,
and installation triage.

## Lesson 2: Build the dataset

**Lesson time:** 120 minutes. **Lab time:** 60 minutes on the following day.

The lesson turns a table contract into one analysis-ready object. Students learn
`select()`, `filter()`, `mutate()`, `group_by()`, `summarise()`, and joins while
tracking the population, unit, key, time period, variables, missingness, and
provenance. The agent is a bounded cleaning assistant that may add checks or
diagnose one step only after students can evaluate the human-readable pipeline.

Keep a **build record**: each transformation has a reason and a visible check,
and the frozen source is never rewritten. Planned interactions: write the table
contract, identify the key, predict what each verb changes, diagnose a
many-to-many join, inspect a proposed diff, and write the build record. Lab 2
is a sixty-minute build-table sprint. A public-data update remains an optional
high-ceiling extension. The common path ends with a checked table from the
frozen file.

## Lesson 3: Discover patterns

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

The lesson explains reproducibility, clean sessions, Quarto as a field notebook, README and provenance requirements, AI-use disclosure, and the four-part handoff audit. The course website uses a separate framework. Students prepare for an exchange in which another person runs the project cold.

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
- Treat speed and mastery as separate dimensions; invite multiple solution paths.
- Working groups are temporary. Every student keeps an individual script or notebook.
- The personal artifact is optional and ungraded.
