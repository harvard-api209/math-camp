source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)

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
    !is.na(gdp_per_capita_ppp),
    gdp_per_capita_ppp > 0,
    !is.na(under5_mortality)
  ) |>
  mutate(log_income = log(gdp_per_capita_ppp)) |>
  arrange(iso3c, year)

stopifnot(!anyDuplicated(health_analysis[c("iso3c", "year")]))
stopifnot(all(is.finite(health_analysis$log_income)))

write_csv(
  health_analysis,
  file.path(outputs_dir, "02-health-analysis.csv"),
  na = ""
)

sample_receipt <- health_analysis |>
  summarise(
    rows = n(),
    economies = n_distinct(iso3c),
    first_year = min(year),
    last_year = max(year),
    median_income_ppp = median(gdp_per_capita_ppp),
    median_under5_mortality = median(under5_mortality)
  )

print(sample_receipt)
cat(
  "\nSaved outputs/02-health-analysis.csv.\n",
  "One row is one observed economy-year with both health variables present.\n",
  sep = ""
)
