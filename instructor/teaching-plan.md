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

The lesson welcomes the room, normalizes different starting points, explains why the camp has moved from an IDE-only workflow to a human-agent-evidence workflow, distinguishes AI from chat interfaces and coding agents, introduces Codex and Claude Code, establishes privacy and verification norms, and then teaches the first R inspection loop.

Planned interactions: arrival prompt, experience-excitement archetype map, pair introductions, tool-matching check, AI-or-not classification, prompt repair, prediction before code, missing-versus-zero check, policy-track choice, and exit ticket.

## Lesson 2: Build the dataset

**Lesson time:** 120 minutes. **Lab time:** 60 minutes on the following day.

The lesson follows one indicator from source to analysis table. Students learn file layers, tidy structure, types, keys, missingness, joins, assertions, provenance, and version comparison. The agent is introduced as a supervised data engineer whose work must be reviewed through a diff and explicit checks.

Planned interactions: reconstruct the data pipeline, identify the key, predict a many-to-many join, choose the correct verb, diagnose silent row loss, inspect an update contract, and write a provenance sentence.

## Lesson 3: Compare patterns

**Lesson time:** 120 minutes. **Lab time:** 60 minutes.

The lesson builds a comparison from question to sample, plot, simple regression, residual check, and qualified claim. It restores the visual critique and progressive `ggplot2` construction used in earlier Math Camps while connecting each design choice to a policy interpretation.

Planned interactions: critique a bad plot, map variables to aesthetics, predict a logarithmic transformation, interpret a coefficient in units, inspect a surprising observation, climb the claim ladder, and run separate code and statistical agent reviews.

## Lesson 4: Audit the handoff

**Lesson time:** 120 minutes. **Lab time:** 60 minutes on the following day.

The lesson explains reproducibility, clean sessions, Quarto as a field notebook rather than the website framework, README and provenance requirements, AI-use disclosure, and the four-part handoff audit. Students prepare for an exchange in which another person runs the project cold.

Planned interactions: hidden-state demonstration, order-the-workflow task, clean-render prediction, README critique, AI-use-note rewrite, severity ranking, handoff rehearsal, and final confidence map.

## Facilitation rules

- Never speak for more than 12 consecutive minutes without a student action.
- Demonstrations must include at least one intentional error or failed assumption.
- Ask students to predict before revealing output.
- Keep the frozen dataset and a no-agent fallback available if internet services fail.
- Do not equate speed with mastery; invite multiple solution paths.
- Working groups are temporary. Every student keeps an individual script or notebook.
- No artifact is graded or submitted.
