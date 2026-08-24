# LESSON 4 DATA BUILD --------------------------------------------------------
# Create four documented, question-specific files from the frozen WDI source.
# Each output has one row per economy so students can complete a short policy
# briefing during Lab 4 without rebuilding the underlying country-year panel.

source("code/00-setup.R")

track_data_dir <- file.path(math_camp_root, "data", "lesson-4")
dir.create(track_data_dir, recursive = TRUE, showWarnings = FALSE)

wdi <- read_csv(data_file, show_col_types = FALSE)

stopifnot(
  nrow(wdi) == 4991,
  n_distinct(wdi$iso3c) == 217,
  setequal(unique(wdi$year), 2000:2022),
  !anyDuplicated(wdi[c("iso3c", "year")])
)

# Health: one economy in 2022 -----------------------------------------------

health_track <- wdi |>
  filter(
    year == 2022,
    !is.na(gdp_per_capita_ppp),
    gdp_per_capita_ppp > 0,
    !is.na(under5_mortality)
  ) |>
  select(
    iso3c,
    country,
    region,
    income_level_current,
    year,
    gdp_per_capita_ppp,
    under5_mortality
  ) |>
  arrange(region, country)

stopifnot(
  nrow(health_track) == 188,
  !anyDuplicated(health_track$iso3c),
  all(health_track$year == 2022)
)

# Gender: one economy in 2022 -----------------------------------------------

gender_track <- wdi |>
  filter(
    year == 2022,
    !is.na(female_secondary_enrollment),
    !is.na(adolescent_fertility)
  ) |>
  select(
    iso3c,
    country,
    region,
    income_level_current,
    year,
    female_secondary_enrollment,
    adolescent_fertility
  ) |>
  arrange(region, country)

stopifnot(
  nrow(gender_track) == 140,
  !anyDuplicated(gender_track$iso3c),
  all(gender_track$year == 2022)
)

# Access: one economy with 2000 and 2022 endpoints --------------------------

economy_metadata_2022 <- wdi |>
  filter(year == 2022) |>
  select(iso3c, country, region, income_level_current)

access_track <- wdi |>
  filter(year %in% c(2000, 2022)) |>
  select(iso3c, year, electricity_access, internet_use) |>
  pivot_wider(
    names_from = year,
    values_from = c(electricity_access, internet_use),
    names_glue = "{.value}_{year}"
  ) |>
  left_join(economy_metadata_2022, by = "iso3c") |>
  filter(
    !is.na(electricity_access_2000),
    !is.na(electricity_access_2022),
    !is.na(internet_use_2000),
    !is.na(internet_use_2022)
  ) |>
  select(
    iso3c,
    country,
    region,
    income_level_current,
    electricity_access_2000,
    electricity_access_2022,
    internet_use_2000,
    internet_use_2022
  ) |>
  mutate(
    electricity_change = electricity_access_2022 - electricity_access_2000,
    internet_change = internet_use_2022 - internet_use_2000,
    combined_gap_closed = electricity_change + internet_change
  ) |>
  arrange(region, country)

stopifnot(
  nrow(access_track) == 174,
  !anyDuplicated(access_track$iso3c)
)

# Climate: one economy with 2000 and 2021 endpoints -------------------------
# Renewable-electricity output ends in 2021 in the frozen teaching source.
# The endpoint comparison uses real GDP per capita, PPP. It supports the claim
# that income ended higher or lower, not that it changed continuously.

economy_metadata_2021 <- wdi |>
  filter(year == 2021) |>
  select(iso3c, country, region, income_level_current)

climate_endpoints <- wdi |>
  filter(year %in% c(2000, 2021)) |>
  select(
    iso3c,
    year,
    renewable_electricity,
    carbon_intensity,
    gdp_per_capita_ppp
  ) |>
  pivot_wider(
    names_from = year,
    values_from = c(
      renewable_electricity,
      carbon_intensity,
      gdp_per_capita_ppp
    ),
    names_glue = "{.value}_{year}"
  )

climate_track <- climate_endpoints |>
  left_join(economy_metadata_2021, by = "iso3c") |>
  filter(
    !is.na(renewable_electricity_2000),
    !is.na(renewable_electricity_2021),
    !is.na(carbon_intensity_2000),
    !is.na(carbon_intensity_2021),
    carbon_intensity_2000 > 0,
    !is.na(gdp_per_capita_ppp_2000),
    !is.na(gdp_per_capita_ppp_2021),
    gdp_per_capita_ppp_2000 > 0,
    gdp_per_capita_ppp_2021 > 0
  ) |>
  select(
    iso3c,
    country,
    region,
    income_level_current,
    renewable_electricity_2000,
    renewable_electricity_2021,
    carbon_intensity_2000,
    carbon_intensity_2021,
    gdp_per_capita_ppp_2000,
    gdp_per_capita_ppp_2021
  ) |>
  mutate(
    renewable_change = renewable_electricity_2021 - renewable_electricity_2000,
    carbon_percent_change = 100 *
      (carbon_intensity_2021 / carbon_intensity_2000 - 1),
    income_percent_change = 100 *
      (gdp_per_capita_ppp_2021 / gdp_per_capita_ppp_2000 - 1),
    transition = renewable_change > 0 &
      carbon_percent_change < 0 &
      income_percent_change > 0
  ) |>
  arrange(region, country)

stopifnot(
  nrow(climate_track) == 172,
  !anyDuplicated(climate_track$iso3c)
)

# Documentation and saved files --------------------------------------------

track_manifest <- tibble(
  track = c("Health", "Gender", "Access", "Climate"),
  file = c(
    "health-2022.csv",
    "gender-2022.csv",
    "access-2000-2022.csv",
    "climate-2000-2021.csv"
  ),
  question = c(
    paste(
      "How is national income associated with under-five mortality,",
      "and does the pattern differ by income group?"
    ),
    paste(
      "Where is girls' secondary enrollment associated with lower adolescent",
      "fertility, and where does the relationship depart from the overall pattern?"
    ),
    paste(
      "Does electricity access travel with internet access, and which",
      "countries closed the combined access gap fastest?"
    ),
    paste(
      "Can renewable electricity expand while carbon intensity falls and",
      "income continues to grow?"
    )
  ),
  unit = c(
    "economy in 2022",
    "economy in 2022",
    "economy with observed 2000 and 2022 endpoints",
    "economy with observed 2000 and 2021 renewable, carbon, and income endpoints"
  ),
  period = c("2022", "2022", "2000 and 2022", "2000--2021"),
  rows = c(
    nrow(health_track),
    nrow(gender_track),
    nrow(access_track),
    nrow(climate_track)
  )
)

track_dictionary <- read_csv(dictionary_file, show_col_types = FALSE) |>
  filter(
    variable %in% c(
      "gdp_per_capita_ppp",
      "under5_mortality",
      "female_secondary_enrollment",
      "adolescent_fertility",
      "electricity_access",
      "internet_use",
      "renewable_electricity",
      "carbon_intensity",
      "gdp_per_capita_ppp"
    )
  ) |>
  arrange(track, variable)

write_csv(health_track, file.path(track_data_dir, "health-2022.csv"))
write_csv(gender_track, file.path(track_data_dir, "gender-2022.csv"))
write_csv(access_track, file.path(track_data_dir, "access-2000-2022.csv"))
write_csv(climate_track, file.path(track_data_dir, "climate-2000-2021.csv"))
write_csv(track_manifest, file.path(track_data_dir, "track-manifest.csv"))
write_csv(track_dictionary, file.path(track_data_dir, "track-dictionary.csv"))

message("Saved four Lesson 4 track datasets in data/lesson-4/.")
