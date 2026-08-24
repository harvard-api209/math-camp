# Lesson 3 Slido and classroom transition plan

## Live event

- **Slido:** API 209 Math Camp 2026 · Lesson 3
- **Participant address:** [sli.do/2209653](https://sli.do/2209653)
- **Event code:** 2209653
- **Event date:** Monday, August 24, 2026
- **QR asset:** slides/lesson-3/figures/slido-lesson-3-qr.png

The deck uses five interactions. The same QR appears on every Slido frame. The
opening and closing rankings repeat the same scenario, labels, and item order.

## Live-event audit

Audit date: August 23, 2026.

| Interaction used in the deck | Live event | Answer guidance |
|---|---|---|
| Opening capability ranking | Exact prompt and labels present | No unique answer; students defend the first two constraints |
| Pooled-plot prediction | Exact prompt and option order present | Option 1 |
| Pooled interpretation | Exact prompt and option order present | Option 1 |
| Fixed-effects prediction | Exact prompt and option order present | Option 1 |
| Closing capability ranking | Opening scenario and labels repeated | Compare the opening and closing distributions |

Two live-event interactions are not used in the deck: the read-only-audit
multiple-choice question and the reusable-workflow open-text question. They
should be deleted so that the live event contains the same five interactions as
the deck.

## 120-minute choreography

| Minutes | Display | Teaching move | Student response |
|---:|---|---|---|
| 00–03 | Slides | Present the labor-market evidence and five capabilities. | Name one capability required to evaluate an empirical briefing. |
| 03–07 | Slides | Define model, reasoning, agent, harness, tool, and skill using Pocock's vocabulary. Trace one agent turn through the diagram. | Identify which component chooses a tool call, which executes it, and where verification enters. |
| 07–11 | Slido 1 | Run the opening capability ranking. | Rank all five, compare the first two with a partner, and hear two explanations. |
| 11–14 | Slides | State the outcomes and route for the lesson. | Name one empirical decision that remains with the analyst. |
| 14–17 | Slides | State the policy question and retrieve the Lesson 2 unit, key, period, and variables. | Write the economy–year unit, iso3c + year key, and two checks required before plotting. |
| 17–20 | RStudio | Inspect panel_record. | Predict the duplicate-key result, then record rows, economies, years, and the key check. |
| 20–23 | Slido 2 | Run the pooled-plot prediction. | Submit one option and give one reason. |
| 23–32 | RStudio | Build the full-panel figure one layer at a time. | Identify the two position mappings, the unit represented by one point, and both scale transformations. |
| 32–40 | Slides | Read direction and dispersion; interpret logarithmic axes. | State one empirical sentence supported by the plot. |
| 40–43 | RStudio and slides | Show selected economy trajectories. | Explain how the longitudinal comparison differs from the pooled point cloud. |
| 43–47 | Checkpoint 1 | Respond to the director's causal sentence. | Two minutes discuss; two minutes share. |
| 47–57 | Break | Display the break slide. | Ten minutes away from the screen. |
| 57–61 | RStudio | Fit pooled OLS and display the coefficient and estimation sample. | State the variation used by the specification before output appears. |
| 61–65 | Slido 3 | Run the pooled-interpretation question. | Choose the correct sentence and diagnose one incorrect option. |
| 65–70 | Slides | Translate the log–log coefficient. | Check the percentage calculation, sample, period, and associational wording. |
| 70–74 | Slides | Define pooled OLS, year fixed effects, and economy and year fixed effects by their sources of variation. | Predict what each specification absorbs. |
| 74–77 | Slido 4 | Run the fixed-effects prediction. | Select the identifying variation and predict attenuation. |
| 77–83 | RStudio | Fit the year and two-way fixed-effects specifications. | Compare the prediction with model_comparison. |
| 83–91 | Checkpoint 2 and slides | Draft and debrief an exact three-sentence briefing. | Two minutes discuss; two minutes share; revise one sentence. |
| 91–97 | Slides and RStudio | Examine Equatorial Guinea directly as a policy case. Compare its observed mortality path with the pooled prediction and inspect the 2008 source values. | Distinguish the documented discrepancy from the hypotheses that would require additional evidence. |
| 97–101 | RStudio | Exclude Equatorial Guinea–2008 and refit pooled OLS. | Compare the two pooled estimates and state exactly what the sensitivity check addresses. |
| 101–104 | Slides | Specify the claim, files, permissions, and verification standard. Relate the project skill to the introductory vocabulary. | Distinguish the model from the skill and the harness that loads it. |
| 104–109 | Codex | Run the prepared read-only claim-audit prompt. | Record the agent's numerical and interpretive statements. |
| 109–113 | RStudio | Recompute the fixed-effects comparison from model_comparison. | Match each statement to a named object. |
| 113–117 | Checkpoint 3 and slides | Evaluate the agent's mixed claim and reveal the model response. | Accept, revise, or reject each clause. |
| 117–119 | Slido 5 | Repeat the opening ranking. | Re-rank and identify the analytical move that changed the ordering. |
| 119–120 | Slides | Open Lab 3. | Carry the all-countries figure into a comparison with one selected region. |

## The five Slido interactions

| Number | Minute | Format | Prompt | Debrief |
|---:|---:|---|---|---|
| 1 | 07 | Ranking | A coding agent produced a figure and paragraph for a ministerial briefing due in 30 minutes. Rank the five capabilities by how strongly they constrain whether you can use the work. | Ask two students why their first two capabilities work together. Save the distribution. |
| 2 | 20 | Multiple choice | If all 4,296 economy–years are plotted with logarithmic income and mortality scales, what pattern do you expect? | The observed figure has a downward band with substantial dispersion. |
| 3 | 61 | Multiple choice | Which sentence accurately reports the pooled estimate? | The correct sentence names the sample, period, percentage units, comparison, and inferential boundary. |
| 4 | 74 | Multiple choice | Which variation contributes to the income coefficient after economy and year fixed effects are added? | The coefficient uses changes within economies after common year movements; predict a smaller magnitude. |
| 5 | 116 | Ranking | Use the same ministerial-briefing scenario and rank the same five capabilities again. | Compare the opening and closing distributions. |

## Ranking items

Use these exact labels and this exact order in interactions 1 and 5.

1. Frame a policy question with a decision at stake.
2. Exercise statistical judgment.
3. Steward data and provenance.
4. Read, modify, and explain code.
5. Supervise and verify an agent.

## Multiple-choice options and answers

### Slido 2: pooled-plot prediction

1. A downward band with substantial dispersion.
2. A downward band with nearly identical paths across economies.
3. A flat cloud after the logarithmic transformations.
4. Twenty-three separate bands, one for each year.

**Answer:** option 1.

### Slido 3: pooled interpretation

1. Across observed economy–years in 2000–2022, 10% higher GDP per capita is
   associated with about 7.8% lower under-five mortality on average.
2. Across observed economy–years, 10% higher GDP per capita is associated with
   7.8 fewer deaths per 1,000 live births.
3. Within the same economy over time, 10% higher GDP per capita is associated
   with 7.8% lower mortality.
4. A 10% increase in GDP per capita reduces under-five mortality by 7.8%.

**Answer:** option 1.

### Slido 4: fixed-effects prediction

1. Within-economy changes after common year movements; smaller magnitude than
   pooled OLS.
2. Cross-economy comparisons within a calendar year; approximately the same
   magnitude as pooled OLS.
3. Changes in the global annual mean; larger magnitude than pooled OLS.
4. Economies observed in 2022; a coefficient of zero.

**Answer:** option 1.

## Checkpoint conclusions

- **Checkpoint 1:** Across observed economy–years, higher income is associated
  with lower under-five mortality. The plot does not isolate an income
  intervention. The next model uses within-economy changes after common year
  movements.
- **Checkpoint 2:** The pooled estimate is about −7.8%, the year fixed-effects
  estimate is about −7.7%, and the economy and year fixed-effects estimate is
  about −3.4%. The last coefficient uses within-economy changes after common
  year movements. Other changing determinants remain.
- **Checkpoint 3:** model_comparison supports the descriptive 3.4% association.
  The model does not identify the effect of income growth.

## Transition language

- **Slides to Slido:** “Record your prediction before we see the output.”
- **Slido to RStudio:** “We will now compute the quantity you predicted.”
- **RStudio to slides:** “The result is visible; we will now interpret the
  comparison it represents.”
- **RStudio to Codex:** “The R objects are fixed; Codex will check one claim
  against them.”
- **Codex to slides:** “We will decide which clauses follow from the named
  evidence.”

Definitions for model, agent, harness, tool, reasoning effort, and skill are
adapted from [Matt Pocock's AI Coding Dictionary](https://www.aihero.dev/ai-coding-dictionary).
