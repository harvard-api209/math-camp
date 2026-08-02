source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)
dictionary <- read_csv(dictionary_file, show_col_types = FALSE)

expected_columns <- c(
  "iso3c",
  "country",
  "region",
  "income_level_current",
  "lending_type_current",
  "year",
  "gdp_per_capita_ppp",
  "under5_mortality",
  "female_secondary_enrollment",
  "adolescent_fertility",
  "electricity_access",
  "internet_use",
  "renewable_electricity",
  "carbon_intensity",
  "gdp_per_capita_growth"
)

missing_columns <- setdiff(expected_columns, names(wdi))
if (length(missing_columns) > 0) {
  stop("Missing expected columns: ", paste(missing_columns, collapse = ", "))
}

stopifnot(!anyDuplicated(wdi[c("iso3c", "year")]))
stopifnot(min(wdi$year) == 2000L)
stopifnot(max(wdi$year) == 2022L)

indicator_variables <- dictionary$variable
missingness <- wdi |>
  summarise(across(all_of(indicator_variables), ~ mean(is.na(.x)))) |>
  pivot_longer(
    everything(),
    names_to = "variable",
    values_to = "missing_share"
  ) |>
  left_join(
    select(dictionary, variable, indicator_name, unit, track),
    by = "variable"
  ) |>
  arrange(desc(missing_share))

inspection_receipt <- c(
  "MATH CAMP 2026 EVIDENCE INVENTORY",
  paste("Rows:", format(nrow(wdi), big.mark = ",")),
  paste("Economies:", n_distinct(wdi$iso3c)),
  paste("Years:", min(wdi$year), "to", max(wdi$year)),
  paste("Unique iso3c-year key:", !anyDuplicated(wdi[c("iso3c", "year")])),
  "",
  "MISSINGNESS BY INDICATOR",
  capture.output(print(missingness, n = Inf))
)

writeLines(
  inspection_receipt,
  file.path(outputs_dir, "01-evidence-inventory.txt")
)

cat(paste(inspection_receipt, collapse = "\n"), "\n")
