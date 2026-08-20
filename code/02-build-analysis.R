source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)

# ANALYSIS PLAN: define the finished dataset before writing data verbs.
# Population: economies observed between 2000 and 2022 with positive GDP per
# capita and observed under-five mortality.
# Unit: one economy-year.
# Key: iso3c + year.
# Source: the protected Math Camp WDI snapshot.
source_rows <- nrow(wdi)

health_analysis <- wdi |>
  select(
    iso3c,
    country,
    region,
    income_level_current,
    year,
    gdp_per_capita_ppp,
    under5_mortality
  ) |>
  filter(
    between(year, 2000L, 2022L),
    !is.na(gdp_per_capita_ppp),
    gdp_per_capita_ppp > 0,
    !is.na(under5_mortality)
  ) |>
  mutate(log_income = log(gdp_per_capita_ppp)) |>
  arrange(iso3c, year)

stopifnot(!anyDuplicated(health_analysis[c("iso3c", "year")]))
stopifnot(all(between(health_analysis$year, 2000L, 2022L)))
stopifnot(all(health_analysis$gdp_per_capita_ppp > 0))
stopifnot(all(is.finite(health_analysis$log_income)))
stopifnot(all(health_analysis$under5_mortality >= 0))

write_csv(
  health_analysis,
  file.path(outputs_dir, "02-health-analysis.csv"),
  na = ""
)

build_record <- health_analysis |>
  summarise(
    source_rows = source_rows,
    rows = n(),
    rows_excluded = source_rows - n(),
    economies = n_distinct(iso3c),
    first_year = min(year),
    last_year = max(year),
    duplicate_keys = anyDuplicated(data.frame(iso3c, year)),
    missing_income = sum(is.na(gdp_per_capita_ppp)),
    missing_mortality = sum(is.na(under5_mortality)),
    min_income_ppp = min(gdp_per_capita_ppp),
    max_income_ppp = max(gdp_per_capita_ppp),
    min_under5_mortality = min(under5_mortality),
    max_under5_mortality = max(under5_mortality),
    median_income_ppp = median(gdp_per_capita_ppp),
    median_under5_mortality = median(under5_mortality)
  )

write_csv(
  build_record,
  file.path(outputs_dir, "02-health-build-record.csv"),
  na = ""
)

print(build_record, width = Inf)
cat(
  "\nSaved outputs/02-health-analysis.csv.\n",
  "Saved outputs/02-health-build-record.csv.\n",
  "One row is one observed economy-year with both health variables present.\n",
  sep = ""
)
