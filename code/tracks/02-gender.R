source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)
analysis_year <- 2022L

gender <- wdi |>
  filter(year == analysis_year) |>
  select(
    iso3c,
    country,
    region,
    female_secondary_enrollment,
    adolescent_fertility
  ) |>
  filter(
    !is.na(female_secondary_enrollment),
    !is.na(adolescent_fertility)
  )

stopifnot(!anyDuplicated(gender["iso3c"]))

fit <- lm(
  adolescent_fertility ~ female_secondary_enrollment,
  data = gender
)

plot <- ggplot(
  gender,
  aes(female_secondary_enrollment, adolescent_fertility)
) +
  geom_point(aes(color = region), alpha = 0.72, size = 2) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "#151515") +
  labs(
    title = "Girls’ secondary enrollment and adolescent fertility",
    subtitle = paste("Complete country observations in", analysis_year),
    x = "Female secondary enrollment, gross percent",
    y = "Births per 1,000 women ages 15–19",
    color = "Region",
    caption = paste(
      "World Bank WDI teaching snapshot.",
      "Coverage is incomplete and the association is not causal."
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

receipt <- c(
  "GENDER TRACK",
  paste("Unit: country in", analysis_year),
  paste("Complete countries:", nrow(gender)),
  paste(
    "Female enrollment missing in the full 2022 file:",
    sum(
      wdi$year == analysis_year &
        is.na(wdi$female_secondary_enrollment)
    )
  ),
  paste(
    "Estimated slope:",
    sprintf(
      "%.2f births per 1,000 for one percentage-point higher enrollment",
      coef(fit)[["female_secondary_enrollment"]]
    )
  ),
  "Boundary: cross-sectional association; coverage and regional context matter."
)

ggsave(
  file.path(outputs_dir, "track-gender.png"),
  plot,
  width = 9,
  height = 6,
  dpi = 160
)
writeLines(receipt, file.path(outputs_dir, "track-gender.txt"))
cat(paste(receipt, collapse = "\n"), "\n")
