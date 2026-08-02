source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)

health <- wdi |>
  select(
    iso3c,
    country,
    year,
    income_level_current,
    gdp_per_capita_ppp,
    under5_mortality
  ) |>
  filter(
    !is.na(gdp_per_capita_ppp),
    gdp_per_capita_ppp > 0,
    !is.na(under5_mortality)
  ) |>
  mutate(log_income = log(gdp_per_capita_ppp))

stopifnot(!anyDuplicated(health[c("iso3c", "year")]))

fit <- lm(
  under5_mortality ~ log_income + income_level_current,
  data = health
)

plot <- ggplot(health, aes(log_income, under5_mortality)) +
  geom_point(aes(color = income_level_current), alpha = 0.4) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "#151515") +
  labs(
    title = "Income and under-five mortality",
    subtitle = "Complete country-year observations, 2000–2022",
    x = "Log GDP per capita, PPP",
    y = "Deaths per 1,000 live births",
    color = "Current income level",
    caption = "World Bank WDI teaching snapshot. Association is not causation."
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

beta <- unname(coef(fit)[["log_income"]])
describe_change <- function(value) {
  direction <- if (value < 0) "decrease" else "increase"
  paste(direction, "of", sprintf("%.2f", abs(value)))
}
receipt <- c(
  "HEALTH TRACK",
  paste("Unit: country-year"),
  paste("Complete rows:", nrow(health)),
  paste("Economies:", n_distinct(health$iso3c)),
  paste("Years:", min(health$year), "to", max(health$year)),
  paste(
    "Estimated change associated with 10% higher income:",
    paste(describe_change(beta * log(1.10)), "deaths per 1,000")
  ),
  paste(
    "Estimated change associated with doubled income:",
    paste(describe_change(beta * log(2)), "deaths per 1,000")
  ),
  "Boundary: pooled association; no causal effect is identified."
)

ggsave(
  file.path(outputs_dir, "track-health.png"),
  plot,
  width = 9,
  height = 6,
  dpi = 160
)
writeLines(receipt, file.path(outputs_dir, "track-health.txt"))
cat(paste(receipt, collapse = "\n"), "\n")
