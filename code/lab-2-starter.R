source("code/00-setup.R")

# LAB 2: EVIDENCE FOR THREE DECISION GATES -------------------------------
#
# Run this file by section from the RStudio source editor. It does not repair
# the draft or build the final dataset. It supplies independent evidence for
# decisions that remain yours.

draft <- read_csv(lab2_draft_file, show_col_types = FALSE)
documented <- read_csv(data_file, show_col_types = FALSE)

# GATE 1. WHAT WOULD MAKE THE BRIEFING WRONG? -----------------------------

draft_key_counts <- draft |>
  count(iso3c, year, name = "rows")

draft_summary <- tibble(
  rows = nrow(draft),
  distinct_economy_years = nrow(draft_key_counts),
  repeated_economy_years = sum(draft_key_counts$rows > 1),
  first_year = min(draft$year, na.rm = TRUE),
  last_year = max(draft$year, na.rm = TRUE),
  missing_income = sum(is.na(draft$gdp_per_capita_ppp)),
  missing_mortality = sum(is.na(draft$under5_mortality))
)

records_to_investigate <- draft |>
  semi_join(
    filter(draft_key_counts, rows > 1),
    by = c("iso3c", "year")
  ) |>
  arrange(iso3c, year, record_source)

print(draft_summary, width = Inf)
print(records_to_investigate, n = Inf, width = Inf)

# GATE 2. WHICH AGENT CLAIM SURVIVES REPRODUCTION? ------------------------
#
# After Codex reports its two most consequential claims, use filter(),
# select(), count(), or anti_join() below to reproduce the one that matters
# most. Keep your code: the handout asks you to distinguish observed evidence
# from the agent's explanation.

# Example workspace (replace with your own consequential claim):
# draft |>
#   filter(iso3c == "...", year == ...) |>
#   select(iso3c, country, year, everything())

# GATE 3. WOULD YOU RELEASE THE CONSTRUCTED DATASET? ----------------------

candidate_file <- file.path(outputs_dir, "02-health-analysis.csv")

if (file.exists(candidate_file)) {
  source("code/02-verify-analysis.R")
} else {
  message(
    "No candidate analysis file exists yet. Commission the Codex pipeline, ",
    "then rerun Gate 3."
  )
}

# The verifier can establish whether the saved file has the requested shape
# and matches documented project records. It cannot establish that the agent's
# source choice or conflict-resolution method was defensible. Inspect the
# generated script before deciding to accept, revise, or reject it.
