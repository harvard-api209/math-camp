source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)

access_complete <- wdi |>
  select(
    iso3c,
    country,
    region,
    year,
    electricity_access,
    internet_use
  ) |>
  filter(
    !is.na(electricity_access),
    !is.na(internet_use)
  )

first_complete <- access_complete |>
  group_by(iso3c) |>
  slice_min(year, n = 1, with_ties = FALSE) |>
  ungroup() |>
  rename(
    first_year = year,
    electricity_first = electricity_access,
    internet_first = internet_use
  )

last_complete <- access_complete |>
  group_by(iso3c) |>
  slice_max(year, n = 1, with_ties = FALSE) |>
  ungroup() |>
  rename(
    last_year = year,
    electricity_last = electricity_access,
    internet_last = internet_use
  )

access_change <- first_complete |>
  select(
    iso3c,
    country,
    region,
    first_year,
    electricity_first,
    internet_first
  ) |>
  inner_join(
    select(
      last_complete,
      iso3c,
      last_year,
      electricity_last,
      internet_last
    ),
    by = "iso3c"
  ) |>
  mutate(
    years_observed = last_year - first_year,
    electricity_change_per_year =
      (electricity_last - electricity_first) / years_observed,
    internet_change_per_year =
      (internet_last - internet_first) / years_observed,
    combined_gap_closed_per_year =
      electricity_change_per_year + internet_change_per_year
  ) |>
  filter(
    years_observed >= 10,
    is.finite(electricity_change_per_year),
    is.finite(internet_change_per_year)
  ) |>
  arrange(desc(combined_gap_closed_per_year))

stopifnot(!anyDuplicated(access_change["iso3c"]))

plot <- ggplot(
  access_change,
  aes(electricity_change_per_year, internet_change_per_year)
) +
  geom_hline(yintercept = 0, color = "#b8b6ae") +
  geom_vline(xintercept = 0, color = "#b8b6ae") +
  geom_point(aes(color = region), alpha = 0.72, size = 2) +
  labs(
    title = "Annual change in electricity and internet access",
    subtitle = "First-to-last complete observations at least ten years apart",
    x = "Electricity-access change, percentage points per year",
    y = "Internet-use change, percentage points per year",
    color = "Region",
    caption = paste(
      "World Bank WDI teaching snapshot.",
      "Endpoints differ by country; this is a descriptive trajectory comparison."
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

leaders <- access_change |>
  select(
    country,
    first_year,
    last_year,
    electricity_change_per_year,
    internet_change_per_year,
    combined_gap_closed_per_year
  ) |>
  slice_head(n = 12)

receipt <- c(
  "ACCESS TRACK",
  "Unit: country trajectory between first and last complete observations",
  paste("Countries with at least ten years of separation:", nrow(access_change)),
  "The two rates use each country’s actual elapsed years.",
  "Boundary: endpoint changes do not identify which policy caused improvement.",
  "",
  capture.output(print(leaders, n = 12))
)

ggsave(
  file.path(outputs_dir, "track-access.png"),
  plot,
  width = 9,
  height = 6,
  dpi = 160
)
write_csv(leaders, file.path(outputs_dir, "track-access-leaders.csv"))
writeLines(receipt, file.path(outputs_dir, "track-access.txt"))
cat(paste(receipt, collapse = "\n"), "\n")
