source("code/00-setup.R")

analysis_file <- file.path(outputs_dir, "02-health-analysis.csv")

if (!file.exists(analysis_file)) {
  stop(
    "outputs/02-health-analysis.csv is missing. ",
    "Run the commissioned pipeline, then audit the saved table."
  )
}

wdi <- read_csv(data_file, show_col_types = FALSE)
health_analysis <- read_csv(analysis_file, show_col_types = FALSE)

required_columns <- c(
  "iso3c", "country", "region", "income_level_current", "year",
  "gdp_per_capita_ppp", "under5_mortality", "log_income"
)

missing_columns <- setdiff(required_columns, names(health_analysis))
if (length(missing_columns) > 0) {
  stop(
    "The saved table is missing required columns: ",
    paste(missing_columns, collapse = ", ")
  )
}

reference <- wdi |>
  filter(
    between(year, 2000L, 2022L),
    !is.na(gdp_per_capita_ppp),
    gdp_per_capita_ppp > 0,
    !is.na(under5_mortality)
  ) |>
  select(
    iso3c, country, region, income_level_current, year,
    gdp_per_capita_ppp, under5_mortality
  ) |>
  mutate(log_income = log(gdp_per_capita_ppp)) |>
  arrange(iso3c, year)

expected_rows <- nrow(reference)

same_character <- function(x, y) {
  (is.na(x) & is.na(y)) | (!is.na(x) & !is.na(y) & x == y)
}

same_number <- function(x, y, tolerance = 1e-8) {
  (is.na(x) & is.na(y)) |
    (!is.na(x) & !is.na(y) & abs(x - y) <= tolerance)
}

structure_checks <- c(
  required_columns = identical(names(health_analysis), required_columns),
  expected_rows = nrow(health_analysis) == expected_rows,
  unique_country_year_key = !anyDuplicated(
    health_analysis[c("iso3c", "year")]
  ),
  period_2000_2022 = isTRUE(all(
    between(health_analysis$year, 2000L, 2022L)
  )),
  positive_income = isTRUE(all(health_analysis$gdp_per_capita_ppp > 0)),
  observed_mortality = !anyNA(health_analysis$under5_mortality),
  nonnegative_mortality = isTRUE(all(health_analysis$under5_mortality >= 0)),
  log_recomputes = isTRUE(all.equal(
    health_analysis$log_income,
    log(health_analysis$gdp_per_capita_ppp),
    tolerance = 1e-12
  ))
)

structure_audit <- tibble(
  check = names(structure_checks),
  passed = unname(structure_checks)
)

candidate_keys <- health_analysis |>
  distinct(iso3c, year)
reference_keys <- reference |>
  distinct(iso3c, year)

missing_keys <- reference_keys |>
  anti_join(candidate_keys, by = c("iso3c", "year"))
unexpected_keys <- candidate_keys |>
  anti_join(reference_keys, by = c("iso3c", "year"))

value_conflicts <- health_analysis |>
  select(all_of(required_columns)) |>
  inner_join(
    reference,
    by = c("iso3c", "year"),
    suffix = c("_candidate", "_source")
  ) |>
  filter(
    !same_character(country_candidate, country_source) |
      !same_character(region_candidate, region_source) |
      !same_character(
        income_level_current_candidate,
        income_level_current_source
      ) |
      !same_number(gdp_per_capita_ppp_candidate, gdp_per_capita_ppp_source) |
      !same_number(under5_mortality_candidate, under5_mortality_source) |
      !same_number(log_income_candidate, log_income_source)
  )

concordance_checks <- c(
  no_documented_keys_missing = nrow(missing_keys) == 0,
  no_unexpected_keys = nrow(unexpected_keys) == 0,
  values_match_documented_source = nrow(value_conflicts) == 0
)

concordance_audit <- tibble(
  check = names(concordance_checks),
  passed = unname(concordance_checks)
)

cat("\nSTRUCTURAL AUDIT\n")
print(structure_audit, n = Inf)
cat("\nSOURCE-CONCORDANCE AUDIT\n")
print(concordance_audit, n = Inf)

if (nrow(missing_keys) > 0) {
  cat("\nDOCUMENTED KEYS MISSING FROM THE CANDIDATE\n")
  print(missing_keys, n = Inf)
}
if (nrow(unexpected_keys) > 0) {
  cat("\nUNEXPECTED KEYS IN THE CANDIDATE\n")
  print(unexpected_keys, n = Inf)
}
if (nrow(value_conflicts) > 0) {
  cat("\nVALUES THAT CONFLICT WITH THE DOCUMENTED SOURCE\n")
  print(value_conflicts, n = Inf, width = Inf)
}

cat(
  "\nIndependent evidence:\n",
  "  expected rows from the frozen source: ", expected_rows, "\n",
  "  observed rows in the saved table: ", nrow(health_analysis), "\n",
  "  observed economies: ", n_distinct(health_analysis$iso3c), "\n",
  sep = ""
)

failed_checks <- c(
  names(structure_checks)[!structure_checks],
  names(concordance_checks)[!concordance_checks]
)
if (length(failed_checks) > 0) {
  stop(
    "Verification failed: ",
    paste(failed_checks, collapse = ", ")
  )
}

cat(
  "RESULT: PASS. The saved table passes the structural and source-concordance ",
  "audits. The analyst must still judge whether the pipeline's method and the ",
  "policy interpretation are defensible.\n",
  sep = ""
)
