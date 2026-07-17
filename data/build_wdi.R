# Math Camp 2026: build the frozen World Development Indicators teaching file.
# Run from the math-camp/2026 directory with: Rscript data/build_wdi.R

required <- c("dplyr", "jsonlite", "readr", "tidyr")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing) > 0) {
  stop("Install required packages first: ", paste(missing, collapse = ", "))
}

root <- normalizePath(".", winslash = "/", mustWork = TRUE)
output_dir <- file.path(root, "data", "derived")
documentation_dir <- file.path(root, "data", "documentation")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(documentation_dir, recursive = TRUE, showWarnings = FALSE)

start_year <- 2000
end_year <- 2022

indicators <- c(
  gdp_per_capita_ppp = "NY.GDP.PCAP.PP.KD",
  under5_mortality = "SH.DYN.MORT",
  female_secondary_enrollment = "SE.SEC.ENRR.FE",
  adolescent_fertility = "SP.ADO.TFRT",
  electricity_access = "EG.ELC.ACCS.ZS",
  internet_use = "IT.NET.USER.ZS",
  renewable_electricity = "EG.ELC.RNEW.ZS",
  carbon_intensity = "EN.GHG.CO2.RT.GDP.PP.KD",
  gdp_per_capita_growth = "NY.GDP.PCAP.KD.ZG"
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
    country = observations$country$value,
    year = as.integer(observations$date),
    variable = variable_name,
    indicator_code = indicator_code,
    value = as.numeric(observations$value)
  )
}

message("Downloading country metadata")
country_payload <- jsonlite::fromJSON(
  "https://api.worldbank.org/v2/country?format=json&per_page=400"
)

country_metadata <- country_payload[[2]] |>
  dplyr::transmute(
    iso3c = id,
    country = name,
    region = trimws(region$value),
    income_level = incomeLevel$value,
    lending_type = lendingType$value
  ) |>
  dplyr::filter(region != "Aggregates")

message("Downloading ", length(indicators), " indicators")
long_data <- Map(
  fetch_indicator,
  names(indicators),
  unname(indicators),
  MoreArgs = list(first_year = start_year, last_year = end_year)
) |>
  dplyr::bind_rows() |>
  dplyr::inner_join(country_metadata, by = c("iso3c", "country")) |>
  dplyr::arrange(iso3c, year, variable)

wide_data <- long_data |>
  dplyr::select(
    iso3c,
    country,
    region,
    income_level,
    lending_type,
    year,
    variable,
    value
  ) |>
  tidyr::pivot_wider(names_from = variable, values_from = value) |>
  dplyr::arrange(iso3c, year)

stopifnot(!anyDuplicated(wide_data[c("iso3c", "year")]))
stopifnot(min(wide_data$year) == start_year)
stopifnot(max(wide_data$year) == end_year)

dictionary <- dplyr::tibble(
  variable = names(indicators),
  indicator_code = unname(indicators)
) |>
  dplyr::mutate(
    source = "World Development Indicators",
    source_url = paste0(
      "https://api.worldbank.org/v2/indicator/",
      indicator_code,
      "?format=json"
    )
  )

readr::write_csv(
  wide_data,
  file.path(output_dir, "math-camp-wdi-2000-2022.csv"),
  na = ""
)
readr::write_csv(
  long_data,
  file.path(output_dir, "math-camp-wdi-2000-2022-long.csv"),
  na = ""
)
readr::write_csv(
  dictionary,
  file.path(documentation_dir, "indicator-dictionary.csv"),
  na = ""
)

message("Rows in wide file: ", nrow(wide_data))
message("Countries: ", dplyr::n_distinct(wide_data$iso3c))
message("Years: ", min(wide_data$year), "-", max(wide_data$year))
message("Done")
