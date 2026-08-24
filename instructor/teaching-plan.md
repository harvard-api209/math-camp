# Math Camp 2026 teaching plan

This plan uses the four lesson decks as the spine of facilitated class meetings. Slides provide the public teaching sequence; speaker notes provide timing, prompts, demonstrations, and transitions. Lab pages provide complete student-facing instructions.

## Voice for quantitative lessons

- State the population, unit, comparison, estimate, and limitation directly.
- Avoid slogans, anthropomorphism, and manufactured contrasts such as “not X,
  but Y.”
- Use technical negation when it marks a genuine inferential boundary: the
  specification does not identify a causal effect, a residual does not justify
  deletion, or a saved result does not reproduce a different model.
- Prefer the language an economist would use while presenting the analysis:
  sample, variation, specification, estimate, evidence, and interpretation.

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
- **Lesson 3:** students write the review plan and reject irrelevant advice.
- **Lesson 4:** students choose a policy track, build a rendered brief, and
  verify one consequential agent statement.

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

Use the lesson clock below. The first block ends after the system map and
“Choose the tool after the task.” Take the full ten-minute break even if a
discussion is still open. The second block ends with a live, online policy-
briefing demonstration and the recurring protocol; the final ten minutes move the room
into Lab 1.

| Clock | Focus | Deck boundary |
|---|---|---|
| 00–08 | Welcome, archetypes, destination | “What I want you to do by the end” |
| 08–16 | Is coding still worth learning? | “Why the workflow changed” |
| 16–20 | **Block 1 checkpoint 1** | Two minutes discuss; two minutes share |
| 20–30 | Pin factory, full cost of delegation, and divided knowledge | “Knowledge is divided too” |
| 30–34 | **Block 1 checkpoint 2** | Two minutes discuss; two minutes share |
| 34–46 | Models, agents, harnesses, tools, and tool choice | “Choose the tool after the task” |
| 46–50 | **Block 1 checkpoint 3** | Two minutes discuss; two minutes share |
| 50–60 | **Break** | Use the break slide; resume at minute 60 |
| 60–70 | Attention scarcity, understanding, and cognitive debt | “Cognitive debt” |
| 70–74 | **Block 2 checkpoint 1** | Two minutes discuss; two minutes share |
| 74–84 | Two-period learning, tacit knowledge, evidence, and the learning routine | “Use the agent to help you understand” |
| 84–88 | **Block 2 checkpoint 2** | Two minutes discuss; two minutes share |
| 88–96 | Capability/adoption/impact, risk, and the irregular frontier | “Match autonomy to risk and verifiability” |
| 96–110 | Work order, permissions, proof, and live demo | Ask Codex to retrieve current official WDI data and prepare the East Africa meeting brief without previewing the answer |
| 110–120 | Lab handoff | Readiness gate and Lab 1 route |
| 120–180 | **Lab 1** | Installation clinic |

Each checkpoint is a four-minute hard stop. Put the question on screen, ask
students to discuss with one or two neighbors for exactly two minutes, and then
use the remaining two minutes for two or three short contributions. Do not turn
the sharing period into a new lecture. Summarize the disagreement or decision
in one sentence and continue. The five checkpoints serve different purposes:

1. **Block 1.1 — retrieve and take a position:** name what learning code still
   contributes when an agent can generate code.
2. **Block 1.2 — apply divided knowledge:** distinguish what data sources, an
   agent, and the analyst may know in a policy-data discrepancy.
3. **Block 1.3 — choose and justify:** select the smallest useful system and
   state acceptance evidence.
4. **Block 2.1 — diagnose:** identify cognitive debt in an apparently successful
   analytical product.
5. **Block 2.2 — construct:** design one before/during/after learning loop for an
   agent-assisted task.

The last fourteen minutes of Block 2 are not another checkpoint. Run one live,
time-pressured policy assignment: “I meet the director of an East Africa
energy-access program in 20 minutes.” Codex must retrieve current official WDI
data online, compare Kenya, Rwanda, Tanzania, and Uganda, draft a concise meeting
brief, provide reproducible R code, cite its sources, and disclose uncertainty.
Narrate the retrieval, permissions, source selection, calculations, and claim
language as they happen. Do not preview a prepared answer; the point is to model
how an analyst supervises an agent under a realistic deadline.

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

Use Adam Smith's pin factory as the historical bridge into this system. The
division of labor can increase output, while coordination determines whether
the specialized contributions form a useful product. Apply the same question
to the student, agent, R, and harness: who frames, who acts, what travels across
the handoff, and who verifies the result? Show the Diderot and d'Alembert
pinmaker plate, following the pedagogical example shared by Luis Garicano.
Then move from divided labor to divided knowledge: Hayek emphasizes that
relevant knowledge is dispersed, while Garicano explains how organizations
route routine and exceptional problems to different problem solvers. The
classroom implication is that students provide local context, recognize
exceptions, and retain the final evidentiary judgment.

Immediately after the pin factory, count the full cost of delegation. Present
net value as time saved plus quality gain minus specification, verification,
and expected error costs. Connect this to Coase's transaction-cost logic: the
relevant comparison is between complete organizational arrangements, not
between the speed of a person and the speed of an agent on one isolated step.
Use the WDI example in the slide. If production saves twenty minutes but the
handoff and review add thirty, the agent has not reduced total analytical work.

The opening asks explicitly, **“Is it still worth learning to code?”** Students
vote before hearing an answer and distinguish syntax recall from reading,
modifying, decomposing, testing, and designing. Use Andrew Ng's argument that
coding plus prompting expands what a person can accomplish, while code retains
an important advantage for inspectable and repeatable actions. Then restore the
2024 Math Camp destination in updated form: students should leave ready for the
semester, able to move in R, able to craft questions and locate help, and
confident enough to make and repair mistakes in public. The final line is:
**students should use help while retaining responsibility for judgment.**

Use Linus Torvalds's 2026 mailing-list intervention to move the discussion from
whether AI is useful to whether it helps the people responsible for maintaining
the work. Ask students to translate his “maintainer test” into policy analysis:
does the agent reduce total work or merely transfer work to reviewers, does it
surface correctable errors, and can the accountable analyst inspect and reject
the result? Present the excerpt as a direct quotation with a link to the
linux-media archive; it is not a general endorsement of unreviewed output.

In Block 2, place cognitive debt in a longer philosophical conversation. Plato's
\*Phaedrus\* distinguishes an external reminder from understanding, while
Aristotle's \*Nicomachean Ethics\*, Book VI, distinguishes technical making from
practical judgment about situations that could be otherwise. Keep the teaching
application concrete: students should be able to question and reconstruct an
agent-produced artifact. They should also identify the policy choices that
require practical judgment.

Open Block 2 with Herbert Simon's attention argument. More generated output
does not abolish scarcity; it consumes the scarce attention needed to select,
verify, explain, and integrate results. Then use the two-period learning model
to separate today's artifact quality from tomorrow's capability. AI assistance
can improve the first while either increasing capability through scaffolding or
reducing it by displacing practice.

Use Polanyi to explain why expertise is not a complete list of explicit rules:
experienced people carry patterns, exceptions, and situational judgment. Pair
that idea with Brynjolfsson, Li, and Raymond's customer-support evidence. AI may
distribute useful patterns to novices, but students must still learn to notice
when a pattern does not apply. State the empirical scope and avoid treating the
workplace result as direct evidence about Math Camp learning.

Before the jagged frontier, distinguish capability, adoption, and impact. A
benchmark establishes capability under benchmark conditions. It does not show
that people will integrate the system into a real workflow or that use will
improve productivity, learning, or decisions. Use the 90-second prompt on the
slide as a retrieval check inside the existing 88--96 minute block; do not add
another checkpoint to the clock.

When introducing the predict–delegate–observe–verify–explain protocol, briefly
connect it to Norbert Wiener's cybernetic account of control through messages
and feedback. The point is not to turn the lesson into intellectual history. It
is to explain why observability is a condition for meaningful supervision: a
person cannot correct a system whose actions and results remain hidden.

The final hour is an **installation clinic**. The evidence inventory and R
analysis begin after the readiness gate. Every student opens the project, starts R, verifies the required
packages, finds Quarto, locates the frozen WDI file, signs in to Codex, and runs
`Rscript code/check_setup.R --codex-confirmed`. Green students help gather
diagnostic evidence. Yellow and red students work through macOS, Windows,
package, path, or account lanes. A student leaves either green or with the exact
failure, next repair, and a named instructor or ICA responsible for follow-up.

Students who reach green while repairs continue complete the first read-only
agent proof for 8--10 minutes. Codex locates the start instructions, frozen WDI data, and indicator
dictionary, returns exact paths and short descriptions, and separates file facts
from inference. The student manually verifies every path in RStudio and opens at
least one file. This runs in parallel with repairs and does not become a required
submission or a reason to stop helping students who are not yet green.

Planned interactions: light archetype discussion, “is coding still worth
learning?” reflection, engine/workshop classification, human tool-call
simulation, risk-and-verifiability placement, weak-to-bounded request repair,
and installation triage.

## Lesson 2: Build the dataset

**Lesson time:** 120 minutes. **Lab time:** 60 minutes on the following day.

The lesson turns a plain-language table plan into one analysis-ready object. Students learn
`select()`, `filter()`, `mutate()`, `group_by()`, `summarise()`, and joins while
tracking the population, unit, key, time period, variables, missingness, and
provenance. The table plan is simply the class's written description of the
finished table: who appears, what one row means, what identifies it, which
period is covered, and which variables answer the policy question. The agent
is a bounded cleaning assistant that may add checks or
diagnose one step only after students can evaluate the human-readable pipeline.

Keep a **build record**: each transformation has a reason and a visible check,
and the frozen source is never rewritten. Planned interactions: define the
table needed, identify the key, predict what each verb changes, diagnose a
many-to-many join, inspect a proposed diff, and write the build record. Lab 2
is a sixty-minute build-table sprint. Its common path uses `select()`,
`filter()`, `mutate()`, a key test, and a short build record. Grouped summaries,
metadata joins, another policy track, and a public-data update are optional
extensions. This scope gives every student time to finish one checked table
from the frozen file.

### Lesson 2 run of show

| Minutes | Teaching move | Visible evidence |
|---|---|---|
| 00–10 | Reopen the shared project and run the setup gate plus evidence inventory. | `RESULT: GREEN`; frozen-file inventory opens; Codex sees the same project root. |
| 10–25 | Define and inspect the health table plan. | Population, unit, key, period, outcome, and comparison are stated before code. |
| 25–50 | Live-code `select()` and `filter()` one step at a time. | Students predict the change; counts explain the move from 4,991 source rows to 4,296 complete health rows. |
| 50–60 | Break. | Ten minutes away from the screen. |
| 60–82 | Live-code `mutate()`, `group_by()`, and `summarise()`. | The logged measure is hand-checked; the class distinguishes country-year from region-year. |
| 82–98 | Diagnose and repair a deliberately broken metadata join. | Right-side key, row count, output key, and unmatched keys are checked. |
| 98–112 | Run the builder, ask Codex for one bounded missing check, inspect the proposal, and run the independent verifier. | Saved analysis table, build record, reviewed diff, and green verifier output. |
| 112–120 | Rehearse the next-day Lab 2 launch. | Students can locate the starter, name the first command, and explain the completion signal. |

Use four four-minute checkpoints, each with two minutes of pair discussion and
two minutes of whole-room sharing: identify the unit and key; explain who leaves
the complete-case sample; diagnose a row-multiplying join; and decide whether a
proposed range check follows from the indicator's documented unit.

The live demonstration should show the entire agent loop. Keep the file tree,
requested permissions, command, proposed diff, and
verification output visible. Use the bounded prompt printed in the deck. Do not
accept a change until students connect it to one requirement in the table plan and a
documented definition.

### Overnight handoff to Lab 2

Students do not need to submit homework. They should leave Lesson 2 knowing how
to reopen the project, reach a green setup result, and find
`code/lab-2-starter.R`. In the next-day lab they build from that scaffold, may
consult `code/02-build-analysis.R` after a genuine attempt, and finish by running
`Rscript code/02-verify-analysis.R`. A green verifier is evidence about the
saved table; students must still explain one sample or transformation decision
and one limitation of the resulting policy comparison.

## Lesson 3: From rows to claims

**Lesson time:** 120 minutes. **Lab time:** 60 minutes.

The lesson uses the full 2000--2022 economy--year panel to answer one briefing
question: how did national income and under-five mortality move together across
economies and within economies? The labor-market opening names five capabilities
used in the analysis. The same capabilities then appear in the empirical work:
define the comparison, verify the panel, inspect the code, interpret the
estimates, and check one agent-produced claim.

Five Slido interactions record an opening ranking, a pooled-plot prediction, a
pooled-interpretation choice, a fixed-effects prediction, and a closing ranking
using the same opening scenario. The instructor moves from slides to Slido to
RStudio only when the next tool answers a stated question. In the lesson, Codex
enters once near the end to check one mixed claim against `model_comparison` and
`sensitivity_record`. Before that claim check, Equatorial Guinea is introduced
directly as a substantive country case; students compare its documented
mortality path with the pooled prediction and then run a one-observation
sensitivity check. Lab 3 then compares the all-countries evidence with one
student-selected region. Students describe the regional sample, construct two
parallel briefing tables, recreate the full-panel figure and its regional
counterpart, and write their interpretations independently. Only after saving
that work do they ask Codex to read the same file, fit one pooled model for each
sample, and draft claims for verification. Residual ranking is not part of the
lesson or lab.

The central econometric result concerns the source of variation behind each
coefficient. Pooled OLS combines cross-economy and within-economy variation. Year
fixed effects absorb common year movements and leave the estimate nearly
unchanged. Adding economy fixed effects removes persistent cross-economy
differences and reduces the estimated 10% comparison from about -7.8% to about
-3.4%. Other time-varying determinants remain, so the specifications estimate
descriptive associations. Students must state the comparison used by a
coefficient before interpreting it.

### Lesson 3 run of show

| Minutes | Teaching move | Visible evidence |
|---|---|---|
| 00–20 | Present the labor-market evidence, run the opening ranking, state the policy question, retrieve the Lesson 2 unit and key, and verify the panel in RStudio. | Opening ranking; 4,296 economy--years; 188 economies; 23 years; unique `iso3c + year` key; pooled and within-economy comparisons stated. |
| 20–47 | Record the pooled-plot prediction, build the full-panel log--log figure, inspect selected trajectories, and complete Checkpoint 1. | Direction, dispersion, proportional scales, repeated observations, and a response to the director's causal sentence. |
| 47–57 | Break. | Ten minutes away from the screen; walkthrough open at Section 4. |
| 57–87 | Fit and translate pooled OLS, choose the correct pooled interpretation, predict the fixed-effects comparison, fit all three specifications, and complete Checkpoint 2. | Estimates of about -7.8%, -7.7%, and -3.4%; each coefficient linked to its source of variation; exact three-sentence briefing. |
| 87–101 | Introduce Equatorial Guinea directly as a country case, compare observed and pooled-model mortality, inspect the 2008 source values, and refit pooled OLS without that observation. | Equatorial Guinea--2008: 118 observed versus about 7.4 predicted; negligible pooled-estimate change after deletion; named R evidence. |
| 101–117 | Ask Codex to check one mixed claim and complete Checkpoint 3. | Supported 3.4% association, pooled-versus-fixed-effects specification mismatch, unsupported causal inference, and revised sentence. |
| 116–120 | Repeat the same-scenario ranking and carry the five required briefing components into Lab 3. | Opening and closing distributions; question, sample, figure, specification, and sentence linked to the same comparison. |

### Lesson 3 checkpoints and closing statements

Each checkpoint lasts four minutes: two minutes of pair discussion and two
minutes of whole-room sharing. End the sharing period with the stated conclusion
and continue.

1. **Checkpoint 1, minutes 40--44:** respond to the director's claim that the
   pooled plot shows that economic growth reduces mortality. Require a supported
   association, the identification problem, and the next comparison. Close with:
   **State the comparison before interpreting the graph.**
2. **Checkpoint 2, minutes 81--85:** draft three sentences covering pooled OLS,
   the economy and year fixed-effects comparison, and the research-design
   limitation. Close with: **A coefficient has meaning after its identifying
   variation is stated.**
3. **Checkpoint 3, minutes 109--113:** evaluate an agent statement that joins the
   3.4% fixed-effects estimate, a pooled-OLS deletion check, and a causal
   conclusion. Close with: **The deletion check refits pooled OLS; it does not
   test the 3.4% fixed-effects estimate or identify a causal effect.**

At minute 119, close the lesson with: **The question, sample, figure,
specification, and sentence must refer to the same comparison.**

The exact Slido prompts and answers live in `instructor/lesson-3-slido-plan.md`.
The instructor R sequence is `code/lesson-3-walkthrough.R`. The Lab 3 starter
uses the checked Lesson 2 table to compare all countries with one region in
`code/lab-3-starter.R`. Students complete and save four descriptive exercises
before Codex reads that same file and produces the bounded model comparison.

## Lesson 4: From policy question to reproducible brief

**Lesson time:** 120 minutes. **Lab time:** 60 minutes on the following day.

The lesson synthesizes the first three lessons, reviews the core R vocabulary,
and introduces Quarto as the place where the question, sample, code, table,
figure, finding, and limitation remain connected. The live demonstration uses
the health track and renders from a clean session. Three short checkpoints ask
students to choose a function sequence, repair a broken evidence chain, and
plan one of four policy tracks.

Lab 4 uses four prepared economy-level datasets and four separate Quarto
starters. Students produce one table, one figure, one supported finding, one
limitation, and one AI-verification note. Codex enters only after the student
has saved an independent interpretation. No model, project exchange, Slido,
or terminal workflow is required.

## Facilitation rules

- Never speak for more than 12 consecutive minutes without a student action.
- Demonstrations must include at least one intentional error or failed assumption.
- Ask students to predict before revealing output.
- Keep the frozen dataset and a no-agent fallback available if internet services fail.
- Treat speed and mastery as separate dimensions; invite multiple solution paths.
- Working groups are temporary. Every student keeps an individual script or notebook.
- The personal artifact is optional and ungraded.
