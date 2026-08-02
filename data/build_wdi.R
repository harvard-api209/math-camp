# Math Camp 2026: maintainer-only build of the frozen WDI teaching files.
#
# The checked-in 2000–2022 baseline is protected. A maintainer must opt in:
#
# MATH_CAMP_WRITE_FROZEN=YES Rscript data/build_wdi.R
#
# Students should use code/04-update-indicator.R, which writes dated files only
# to data/updates/.

required <- c("dplyr", "jsonlite", "readr", "tidyr")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing) > 0) {
  stop("Install required packages first: ", paste(missing, collapse = ", "))
}

if (!identical(Sys.getenv("MATH_CAMP_WRITE_FROZEN"), "YES")) {
  stop(
    "Refusing to write the frozen teaching files.\n",
    "Maintainers must opt in with:\n",
    "MATH_CAMP_WRITE_FROZEN=YES Rscript data/build_wdi.R\n",
    "Students should run code/04-update-indicator.R instead."
  )
}

root <- normalizePath(".", winslash = "/", mustWork = TRUE)
if (!file.exists(file.path(root, "math-camp-2026.Rproj"))) {
  stop("Run this command from the Math Camp project root.")
}

output_dir <- file.path(root, "data", "derived")
documentation_dir <- file.path(root, "data", "documentation")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(documentation_dir, recursive = TRUE, showWarnings = FALSE)

start_year <- 2000L
end_year <- 2022L
retrieval_date <- Sys.Date()

indicator_spec <- dplyr::tribble(
  ~variable, ~track, ~indicator_code, ~unit,
  "gdp_per_capita_ppp", "Health", "NY.GDP.PCAP.PP.KD",
  "constant 2021 international dollars per person",
  "under5_mortality", "Health", "SH.DYN.MORT",
  "deaths before age five per 1,000 live births",
  "female_secondary_enrollment", "Gender", "SE.SEC.ENRR.FE",
  "percent, gross female secondary enrollment",
  "adolescent_fertility", "Gender", "SP.ADO.TFRT",
  "births per 1,000 women ages 15–19",
  "electricity_access", "Access", "EG.ELC.ACCS.ZS",
  "percent of population",
  "internet_use", "Access", "IT.NET.USER.ZS",
  "percent of population",
  "renewable_electricity", "Climate", "EG.ELC.RNEW.ZS",
  "percent of total electricity output",
  "carbon_intensity", "Climate", "EN.GHG.CO2.RT.GDP.PP.KD",
  "kilograms of CO2 equivalent per 2021 PPP dollar of GDP",
  "gdp_per_capita_growth", "Climate", "NY.GDP.PCAP.KD.ZG",
  "annual percent growth"
)

fetch_indicator <- function(variable_name, indicator_code, first_year, last_year) {
  url <- paste0(
    "https://api.worldbank.org/v2/country/all/indicator/",
    indicator_code,
    "?format=json&date=",
    first_year,
    ":",
    last_year,
    "&per_page=20000"
  )

  payload <- jsonlite::fromJSON(url)
  observations <- payload[[2]]

  if (is.null(observations) || nrow(observations) == 0) {
    stop("No observations returned for ", indicator_code)
  }

  dplyr::tibble(
    iso3c = observations$countryiso3code,
    country_from_indicator = observations$country$value,
    year = as.integer(observations$date),
    variable = variable_name,
    indicator_code = indicator_code,
    value = as.numeric(observations$value)
  )
}

fetch_indicator_metadata <- function(variable_name, track, indicator_code, unit) {
  source_url <- paste0(
    "https://api.worldbank.org/v2/indicator/",
    indicator_code,
    "?format=json"
  )
  payload <- jsonlite::fromJSON(source_url)
  metadata <- payload[[2]]

  if (is.null(metadata) || nrow(metadata) != 1L) {
    stop("Unexpected metadata response for ", indicator_code)
  }

  dplyr::tibble(
    variable = variable_name,
    track = track,
    indicator_code = indicator_code,
    indicator_name = trimws(metadata$name),
    unit = unit,
    definition = trimws(metadata$sourceNote),
    source = trimws(metadata$source$value),
    source_organization = trimws(metadata$sourceOrganization),
    periodicity = "Annual",
    aggregation_method = paste(
      "The API does not expose a separate aggregation-method field.",
      "Consult the definition and source organization."
    ),
    source_url = source_url,
    retrieval_date = as.character(retrieval_date)
  )
}

message("Downloading current country metadata")
country_payload <- jsonlite::fromJSON(
  "https://api.worldbank.org/v2/country?format=json&per_page=400"
)

country_metadata <- country_payload[[2]] |>
  dplyr::transmute(
    iso3c = id,
    country = name,
    region = trimws(region$value),
    income_level_current = incomeLevel$value,
    lending_type_current = lendingType$value
  ) |>
  dplyr::filter(region != "Aggregates")

message("Downloading ", nrow(indicator_spec), " indicators")
downloaded <- Map(
  fetch_indicator,
  indicator_spec$variable,
  indicator_spec$indicator_code,
  MoreArgs = list(first_year = start_year, last_year = end_year)
) |>
  dplyr::bind_rows() |>
  dplyr::filter(nzchar(iso3c)) |>
  dplyr::semi_join(
    dplyr::select(country_metadata, iso3c),
    by = "iso3c"
  )

name_disagreements <- downloaded |>
  dplyr::distinct(iso3c, country_from_indicator) |>
  dplyr::inner_join(
    dplyr::select(country_metadata, iso3c, country),
    by = "iso3c"
  ) |>
  dplyr::filter(country_from_indicator != country)

if (nrow(name_disagreements) > 0) {
  message("Country-name disagreements retained for review:")
  print(name_disagreements, n = Inf)
}

join_losses <- dplyr::anti_join(
  dplyr::distinct(downloaded, iso3c),
  dplyr::distinct(country_metadata, iso3c),
  by = "iso3c"
)
if (nrow(join_losses) > 0) {
  stop(
    "Indicator observations have ISO3 codes absent from country metadata: ",
    paste(join_losses$iso3c, collapse = ", ")
  )
}

long_data <- downloaded |>
  dplyr::select(-country_from_indicator) |>
  dplyr::inner_join(country_metadata, by = "iso3c") |>
  dplyr::select(
    iso3c,
    country,
    year,
    variable,
    indicator_code,
    value,
    region,
    income_level_current,
    lending_type_current
  ) |>
  dplyr::arrange(iso3c, year, variable)

wide_data <- long_data |>
  dplyr::select(
    iso3c,
    country,
    region,
    income_level_current,
    lending_type_current,
    year,
    variable,
    value
  ) |>
  tidyr::pivot_wider(names_from = variable, values_from = value) |>
  dplyr::arrange(iso3c, year)

dictionary <- Map(
  fetch_indicator_metadata,
  indicator_spec$variable,
  indicator_spec$track,
  indicator_spec$indicator_code,
  indicator_spec$unit
) |>
  dplyr::bind_rows()

expected_variables <- sort(indicator_spec$variable)
actual_variables <- sort(setdiff(
  names(wide_data),
  c(
    "iso3c",
    "country",
    "region",
    "income_level_current",
    "lending_type_current",
    "year"
  )
))

stopifnot(!anyDuplicated(wide_data[c("iso3c", "year")]))
stopifnot(!anyDuplicated(long_data[c("iso3c", "year", "indicator_code")]))
stopifnot(min(wide_data$year) == start_year)
stopifnot(max(wide_data$year) == end_year)
stopifnot(identical(actual_variables, expected_variables))
stopifnot(nrow(dictionary) == nrow(indicator_spec))
stopifnot(!anyNA(dictionary[c("indicator_name", "unit", "definition")]))

write_atomically <- function(data, target) {
  temporary <- tempfile(
    pattern = paste0(basename(target), "-"),
    tmpdir = dirname(target),
    fileext = ".tmp"
  )
  on.exit(unlink(temporary), add = TRUE)
  readr::write_csv(data, temporary, na = "")

  if (file.exists(target) && !file.remove(target)) {
    stop("Could not replace existing file: ", target)
  }
  if (!file.rename(temporary, target)) {
    stop("Could not move validated output into place: ", target)
  }
}

write_atomically(
  wide_data,
  file.path(output_dir, "math-camp-wdi-2000-2022.csv")
)
write_atomically(
  long_data,
  file.path(output_dir, "math-camp-wdi-2000-2022-long.csv")
)
write_atomically(
  dictionary,
  file.path(documentation_dir, "indicator-dictionary.csv")
)

message("Rows in wide file: ", nrow(wide_data))
message("Countries: ", dplyr::n_distinct(wide_data$iso3c))
message("Years: ", min(wide_data$year), "-", max(wide_data$year))
message("Dictionary rows: ", nrow(dictionary))
message("Frozen teaching files replaced after validation")
