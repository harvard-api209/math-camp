source("code/00-setup.R")

analysis_file <- file.path(outputs_dir, "02-health-analysis.csv")

if (!file.exists(analysis_file)) {
  stop(
    "outputs/02-health-analysis.csv is missing. ",
    "Run Rscript code/02-build-analysis.R first."
  )
}

wdi <- read_csv(data_file, show_col_types = FALSE)
health_analysis <- read_csv(analysis_file, show_col_types = FALSE)

required_columns <- c(
  "iso3c",
  "country",
  "region",
  "income_level_current",
  "year",
  "gdp_per_capita_ppp",
  "under5_mortality",
  "log_income"
)

expected_rows <- wdi |>
  filter(
    between(year, 2000L, 2022L),
    !is.na(gdp_per_capita_ppp),
    gdp_per_capita_ppp > 0,
    !is.na(under5_mortality)
  ) |>
  nrow()

checks <- c(
  required_columns = identical(names(health_analysis), required_columns),
  expected_rows = nrow(health_analysis) == expected_rows,
  unique_country_year_key = !anyDuplicated(
    health_analysis[c("iso3c", "year")]
  ),
  period_2000_2022 = all(
    between(health_analysis$year, 2000L, 2022L)
  ),
  positive_income = all(health_analysis$gdp_per_capita_ppp > 0),
  observed_mortality = !anyNA(health_analysis$under5_mortality),
  nonnegative_mortality = all(health_analysis$under5_mortality >= 0),
  log_recomputes = isTRUE(all.equal(
    health_analysis$log_income,
    log(health_analysis$gdp_per_capita_ppp),
    tolerance = 1e-12
  ))
)

verification <- tibble(
  check = names(checks),
  passed = unname(checks)
)

print(verification, n = Inf)
cat(
  "\nIndependent evidence:\n",
  "  expected rows from the frozen source: ", expected_rows, "\n",
  "  observed rows in the saved table: ", nrow(health_analysis), "\n",
  "  observed economies: ", n_distinct(health_analysis$iso3c), "\n",
  sep = ""
)

if (!all(checks)) {
  stop(
    "Verification failed: ",
    paste(names(checks)[!checks], collapse = ", ")
  )
}

cat("RESULT: GREEN. The saved health table meets its stated contract.\n")
