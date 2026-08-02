# Intentionally broken Math Camp handoff fixture.

library(tidyverse)

wdi <- read_csv(
  "~/Downloads/math-camp-wdi-2000-2022.csv",
  show_col_types = FALSE
)

fit <- lm(
  under5_mortality ~ log_income,
  data = health_analysis
)

figure <- ggplot(health_analysis, aes(log_income, under5_mortality)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Higher income reduces child mortality",
    x = "Income",
    y = "Mortality"
  )

figure
