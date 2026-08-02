# Handoff clinic instructor key

The fixture in `examples/handoff-clinic/` contains four intended failures:

1. **Absolute path:** the `~/Downloads/` input exists only on the author’s
   computer. Repair it with a project-relative path to the frozen dataset.
2. **Hidden object:** `health_analysis` and `log_income` are never created in the
   script. Repair by defining the analysis sample before fitting or plotting.
3. **Stale output:** the receipt reports 2025 even though the frozen file ends in
   2022 and says it predates the current source. Regenerate output from the
   repaired source.
4. **Unsupported claim:** the title uses causal language. The observational
   pooled regression supports an associational description only.

The unlabeled axes are also a communication problem. Treat that as an additional
repair after students identify the four failures that most directly break the
handoff.

The completed audit should include observable evidence for each finding and a
clean rerun after each repair.
