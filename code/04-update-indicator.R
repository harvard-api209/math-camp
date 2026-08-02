# Safe student-facing World Bank indicator update.
# Example:
# Rscript code/04-update-indicator.R SH.DYN.MORT under5_mortality

source("code/00-setup.R")

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Install jsonlite before running the update: install.packages('jsonlite')")
}

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2L) {
  stop(
    "Supply exactly two arguments: INDICATOR_CODE variable_name\n",
    "Example: Rscript code/04-update-indicator.R ",
    "SH.DYN.MORT under5_mortality"
  )
}

indicator_code <- args[[1]]
variable_name <- args[[2]]
retrieval_date <- Sys.Date()
first_year <- 2000L
requested_last_year <- as.integer(format(retrieval_date, "%Y"))

if (!grepl("^[A-Za-z][A-Za-z0-9_]*$", variable_name)) {
  stop("variable_name must be a valid R-style name using letters, numbers, and _.")
}

url <- paste0(
  "https://api.worldbank.org/v2/country/all/indicator/",
  indicator_code,
  "?format=json&per_page=30000"
)

message("Requesting ", url)
payload <- jsonlite::fromJSON(url)
observations <- payload[[2]]

if (is.null(observations) || nrow(observations) == 0) {
  stop("The official API returned no observations for ", indicator_code)
}

baseline_countries <- read_csv(
  data_file,
  show_col_types = FALSE
) |>
  distinct(iso3c, country)

downloaded_indicator <- tibble(
  iso3c = observations$countryiso3code,
  country_from_api = observations$country$value,
  year = as.integer(observations$date),
  indicator_code = indicator_code,
  variable = variable_name,
  value = as.numeric(observations$value),
  retrieval_date = as.character(retrieval_date)
) |>
  filter(
    nzchar(iso3c),
    nchar(iso3c) == 3L,
    year >= first_year,
    year <= requested_last_year
  )

name_disagreements <- downloaded_indicator |>
  distinct(iso3c, country_from_api) |>
  inner_join(baseline_countries, by = "iso3c") |>
  filter(country_from_api != country)

if (nrow(name_disagreements) > 0) {
  message(
    nrow(name_disagreements),
    " API country names differ from the frozen metadata; ",
    "the iso3c join and frozen names are retained."
  )
}

updated_indicator <- downloaded_indicator |>
  inner_join(baseline_countries, by = "iso3c") |>
  select(
    iso3c,
    country,
    year,
    indicator_code,
    variable,
    value,
    retrieval_date
  ) |>
  arrange(iso3c, year)

if (anyDuplicated(updated_indicator[c("iso3c", "year", "indicator_code")])) {
  stop("The update produced duplicate iso3c-year-indicator keys.")
}

updates_dir <- file.path(math_camp_root, "data", "updates")
dir.create(updates_dir, recursive = TRUE, showWarnings = FALSE)
output_path <- file.path(
  updates_dir,
  paste0(variable_name, "-", retrieval_date, ".csv")
)

frozen_paths <- normalizePath(
  c(
    data_file,
    file.path(
      math_camp_root,
      "data",
      "derived",
      "math-camp-wdi-2000-2022-long.csv"
    )
  ),
  winslash = "/",
  mustWork = FALSE
)
candidate_path <- normalizePath(output_path, winslash = "/", mustWork = FALSE)
if (candidate_path %in% frozen_paths) {
  stop("Refusing to overwrite a frozen teaching file.")
}

write_csv(updated_indicator, output_path, na = "")

coverage <- updated_indicator |>
  summarise(
    rows = n(),
    economies = n_distinct(iso3c),
    first_observed_year = min(year[!is.na(value)]),
    latest_observed_year = max(year[!is.na(value)]),
    missing_values = sum(is.na(value))
  )

print(coverage)
cat("Wrote new dated output:", output_path, "\n")
cat("The frozen 2000–2022 files were not modified.\n")
