source("code/00-setup.R")

# LAB 2: EVIDENCE AND PIPELINE AUDIT -----------------------------------------
#
# This script does not build the final dataset. It gives you independent
# evidence for judging Codex first as a verifier and then as pipeline operator.

draft <- read_csv(lab2_draft_file, show_col_types = FALSE)
documented <- read_csv(data_file, show_col_types = FALSE)

# ROUND I. EVIDENCE FOR THE VERIFICATION REPORT ------------------------------

key_counts <- draft |>
  count(iso3c, year, name = "records")

draft_audit <- tibble(
  rows = nrow(draft),
  economy_years = nrow(key_counts),
  repeated_keys = sum(key_counts$records > 1),
  first_year = min(draft$year, na.rm = TRUE),
  last_year = max(draft$year, na.rm = TRUE),
  missing_income = sum(is.na(draft$gdp_per_capita_ppp)),
  missing_mortality = sum(is.na(draft$under5_mortality))
)

records_for_review <- draft |>
  semi_join(filter(key_counts, records > 1), by = c("iso3c", "year")) |>
  arrange(iso3c, year, record_source)

documented_comparison <- documented |>
  semi_join(records_for_review, by = c("iso3c", "year")) |>
  select(
    iso3c,
    country,
    income_level_current,
    year,
    gdp_per_capita_ppp,
    under5_mortality
  ) |>
  arrange(iso3c, year)

print(draft_audit, width = Inf)
print(records_for_review, n = Inf, width = Inf)
print(documented_comparison, n = Inf, width = Inf)

# ROUND II. AUDIT THE CODEX-BUILT PIPELINE ----------------------------------

candidate_file <- file.path(outputs_dir, "02-health-analysis.csv")

if (file.exists(candidate_file)) {
  source("code/02-verify-analysis.R")
} else {
  message(
    "No candidate output yet. Commission the Codex pipeline, then rerun this ",
    "script to audit its result."
  )
}
