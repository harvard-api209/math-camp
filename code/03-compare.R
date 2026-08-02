source("code/00-setup.R")

analysis_file <- file.path(outputs_dir, "02-health-analysis.csv")
if (!file.exists(analysis_file)) {
  stop(
    "outputs/02-health-analysis.csv is missing. ",
    "Run Rscript code/02-build-analysis.R first."
  )
}

health_analysis <- read_csv(analysis_file, show_col_types = FALSE)

health_plot <- ggplot(
  health_analysis,
  aes(log_income, under5_mortality)
) +
  geom_point(
    aes(color = income_level_current),
    alpha = 0.42,
    size = 1.6,
    na.rm = TRUE
  ) +
  geom_smooth(
    method = "lm",
    formula = y ~ x,
    se = FALSE,
    color = "#151515",
    linewidth = 0.8
  ) +
  labs(
    title = "Observed income and under-five mortality",
    subtitle = "Complete country-year observations, 2000–2022",
    x = "Log GDP per capita, PPP",
    y = "Under-five deaths per 1,000 live births",
    color = "Current income level",
    caption = paste(
      "World Bank WDI teaching snapshot.",
      "The pooled association is not a causal effect."
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

fit <- lm(
  under5_mortality ~ log_income + income_level_current,
  data = health_analysis
)

health_model <- health_analysis |>
  mutate(
    fitted = predict(fit),
    residual = resid(fit)
  ) |>
  arrange(desc(abs(residual)))

log_income_coefficient <- unname(coef(fit)[["log_income"]])
change_for_10_percent <- log_income_coefficient * log(1.10)
change_for_doubling <- log_income_coefficient * log(2)

describe_change <- function(value) {
  direction <- if (value < 0) "decrease" else "increase"
  paste(direction, "of", sprintf("%.2f", abs(value)))
}

interpretation <- c(
  "HEALTH COMPARISON RECEIPT",
  paste("Model observations:", nobs(fit)),
  paste(
    "A 10% increase in GDP per capita is associated with an estimated",
    describe_change(change_for_10_percent),
    "in under-five deaths per 1,000 live births,"
  ),
  "comparing observations in the same included current income-level category.",
  paste(
    "A doubling of GDP per capita is associated with an estimated",
    describe_change(change_for_doubling),
    "in under-five deaths per 1,000 live births."
  ),
  paste(
    "These are pooled descriptive associations.",
    "They do not identify the effect of changing national income."
  )
)

ggsave(
  file.path(outputs_dir, "03-health-comparison.png"),
  health_plot,
  width = 9,
  height = 6,
  dpi = 160
)
write_csv(
  select(
    health_model,
    iso3c,
    country,
    year,
    under5_mortality,
    fitted,
    residual
  ) |>
    slice_head(n = 12),
  file.path(outputs_dir, "03-largest-residuals.csv")
)
writeLines(
  c(interpretation, "", capture.output(summary(fit))),
  file.path(outputs_dir, "03-model-receipt.txt")
)

cat(paste(interpretation, collapse = "\n"), "\n")
cat("Saved the figure, residual table, and model receipt in outputs/.\n")
