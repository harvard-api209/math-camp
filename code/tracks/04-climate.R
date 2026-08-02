source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)

complete_climate <- wdi |>
  filter(
    !is.na(renewable_electricity),
    !is.na(carbon_intensity),
    !is.na(gdp_per_capita_growth)
  )

analysis_year <- max(complete_climate$year)

climate <- complete_climate |>
  filter(year == analysis_year) |>
  select(
    iso3c,
    country,
    region,
    renewable_electricity,
    carbon_intensity,
    gdp_per_capita_growth
  )

stopifnot(!anyDuplicated(climate["iso3c"]))

fit <- lm(
  carbon_intensity ~ renewable_electricity + gdp_per_capita_growth,
  data = climate
)

plot <- ggplot(
  climate,
  aes(renewable_electricity, carbon_intensity)
) +
  geom_point(
    aes(color = gdp_per_capita_growth),
    alpha = 0.76,
    size = 2.3
  ) +
  scale_color_gradient2(
    low = "#2166ac",
    mid = "#f4f3ef",
    high = "#b2182b",
    midpoint = 0
  ) +
  labs(
    title = "Renewable electricity and carbon intensity",
    subtitle = paste("Latest common complete year:", analysis_year),
    x = "Renewable electricity, percent of output",
    y = "Carbon intensity of economic activity",
    color = "Real GDP per-capita\ngrowth (%)",
    caption = paste(
      "World Bank WDI teaching snapshot.",
      "A single-year comparison cannot establish a transition path."
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

receipt <- c(
  "CLIMATE TRACK",
  paste("Unit: country in", analysis_year),
  paste("Complete countries:", nrow(climate)),
  paste(
    "The frozen file has no complete climate rows in 2022;",
    "the latest common complete year is",
    analysis_year
  ),
  "Color represents current-year growth rather than a long-run transition.",
  "Boundary: this cross-section cannot show whether an individual country decarbonized."
)

ggsave(
  file.path(outputs_dir, "track-climate.png"),
  plot,
  width = 9,
  height = 6,
  dpi = 160
)
writeLines(
  c(receipt, "", capture.output(summary(fit))),
  file.path(outputs_dir, "track-climate.txt")
)
cat(paste(receipt, collapse = "\n"), "\n")
