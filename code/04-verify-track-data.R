# LESSON 4 DATA VERIFICATION -----------------------------------------------
# Rebuild the four policy-track datasets from the frozen source and compare
# them with the files students receive.

source("code/00-setup.R")

track_dir <- file.path(math_camp_root, "data", "lesson-4")
wdi <- read_csv(data_file, show_col_types = FALSE)

stopifnot(
  nrow(wdi) == 4991,
  n_distinct(wdi$iso3c) == 217,
  setequal(unique(wdi$year), 2000:2022),
  !anyDuplicated(wdi[c("iso3c", "year")])
)

check_file <- function(file, expected_rows, expected_columns) {
  object <- read_csv(file.path(track_dir, file), show_col_types = FALSE)
  stopifnot(
    nrow(object) == expected_rows,
    !anyDuplicated(object$iso3c),
    identical(names(object), expected_columns)
  )
  object
}

health <- check_file(
  "health-2022.csv",
  188,
  c("iso3c", "country", "region", "income_level_current", "year",
    "gdp_per_capita_ppp", "under5_mortality")
)
stopifnot(all(health$year == 2022), all(health$gdp_per_capita_ppp > 0))

gender <- check_file(
  "gender-2022.csv",
  140,
  c("iso3c", "country", "region", "income_level_current", "year",
    "female_secondary_enrollment", "adolescent_fertility")
)
stopifnot(all(gender$year == 2022))

access <- check_file(
  "access-2000-2022.csv",
  174,
  c("iso3c", "country", "region", "income_level_current",
    "electricity_access_2000", "electricity_access_2022",
    "internet_use_2000", "internet_use_2022", "electricity_change",
    "internet_change", "combined_gap_closed")
)
stopifnot(
  isTRUE(all.equal(
    access$electricity_change,
    access$electricity_access_2022 - access$electricity_access_2000
  )),
  isTRUE(all.equal(
    access$internet_change,
    access$internet_use_2022 - access$internet_use_2000
  )),
  isTRUE(all.equal(
    access$combined_gap_closed,
    access$electricity_change + access$internet_change
  ))
)

climate <- check_file(
  "climate-2000-2021.csv",
  172,
  c("iso3c", "country", "region", "income_level_current",
    "renewable_electricity_2000", "renewable_electricity_2021",
    "carbon_intensity_2000", "carbon_intensity_2021",
    "gdp_per_capita_ppp_2000", "gdp_per_capita_ppp_2021",
    "renewable_change", "carbon_percent_change", "income_percent_change",
    "transition")
)
stopifnot(
  all(climate$carbon_intensity_2000 > 0),
  all(climate$gdp_per_capita_ppp_2000 > 0),
  isTRUE(all.equal(
    climate$renewable_change,
    climate$renewable_electricity_2021 - climate$renewable_electricity_2000
  )),
  isTRUE(all.equal(
    climate$carbon_percent_change,
    100 * (climate$carbon_intensity_2021 / climate$carbon_intensity_2000 - 1)
  )),
  isTRUE(all.equal(
    climate$income_percent_change,
    100 * (climate$gdp_per_capita_ppp_2021 / climate$gdp_per_capita_ppp_2000 - 1)
  ))
)

message("Lesson 4 track files passed independent structural and arithmetic checks.")
