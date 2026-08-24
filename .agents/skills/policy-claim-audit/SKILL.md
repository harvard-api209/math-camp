---
name: policy-claim-audit
description: Review a quantitative policy claim against its question, sample, R code, figure, model output, and source notes. Use after an analyst has written an initial interpretation; do not use to invent a topic or upgrade an associational design into a causal one.
---

# Policy Claim Audit

Determine whether a proposed policy-data claim is supported by the analysis that produced it. Work read-only unless the user separately asks for edits.

## Audit sequence

1. State the policy question and the strongest claim type the design can support: descriptive, associational, predictive, or causal.
2. Trace the analysis sample: population, unit of observation, key, period, exclusions, and missingness. Report mismatches between the stated sample and the rows actually used. If units repeat over time, distinguish between-unit comparisons, within-unit changes, and common period changes.
3. Trace the figure: data object, mappings, transformation, scale, labels, and fitted summaries. Identify any visual choice that materially changes the comparison.
4. Trace the model: formula, number of observations, coefficient units, reference categories, and at least one diagnostic or residual case. When several specifications use the same panel, state which comparisons contribute to each coefficient; do not describe added unit or period indicators as a causal design.
5. Compare each sentence of the proposed claim with observable evidence from the files and output. Classify it as supported, overstated, underspecified, or unresolved.
6. For every consequential concern, give one minimal R or source check that could confirm or reject it.

## Output

Return a compact review with four parts:

- **Supported:** the strongest sentence the evidence can carry.
- **Concern:** the most consequential mismatch, with its exact file or output evidence.
- **Check:** one independent check and what result would resolve the concern.
- **Boundary:** one claim the current design cannot support and why.

Separate observations from the project files from your own hypotheses. Do not recommend deleting an unusual observation merely because it departs from the fitted pattern. Check its source, unit, and trajectory; then distinguish aggregate sensitivity from the case's substantive importance. Stop and name the missing evidence when the sample, output, or source documentation needed for the audit is unavailable.
