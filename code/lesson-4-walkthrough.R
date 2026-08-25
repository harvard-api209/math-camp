# LESSON 4 WALKTHROUGH: FOUR QUESTIONS, ONE WORKFLOW -----------------------
# This script follows the order of the Lesson 4 slides. Run one section at a
# time in RStudio. The lab starter files use the same functions and objects.

# 1. Packages and files -----------------------------------------------------
# install.packages() is used once, only when a package is absent.
# library() attaches an installed package in the current R session.

library(tidyverse)

health <- read_csv("data/lesson-4/health-2022.csv", show_col_types = FALSE)

# Related readers include read_excel() for Excel workbooks and readRDS() for
# one saved R object. The file format determines the reader.

# 2. Inspect before transforming ------------------------------------------

glimpse(health)
names(health)
count(health, income_level_current)
summary(select(health, gdp_per_capita_ppp, under5_mortality))
n_distinct(health$iso3c)

# 3. Select, filter, arrange, and mutate -----------------------------------

health_focus <- health |>
  select(
    country,
    region,
    income_level_current,
    gdp_per_capita_ppp,
    under5_mortality
  ) |>
  filter(gdp_per_capita_ppp > 10000) |>
  mutate(log_income = log(gdp_per_capita_ppp)) |>
  arrange(desc(under5_mortality))

health_focus

# 4. Group and summarise ---------------------------------------------------

health_table <- health_focus |>
  group_by(income_level_current) |>
  summarise(
    economies = n(),
    min_mortality = min(under5_mortality),
    average_mortality = mean(under5_mortality),
    median_mortality = median(under5_mortality),
    max_mortality = max(under5_mortality),
    .groups = "drop"
  ) |>
  arrange(median_mortality)

health_table

# 5. Make a figure ---------------------------------------------------------

health_figure <- ggplot(
  health_focus,
  aes(x = gdp_per_capita_ppp, y = under5_mortality,
      color = income_level_current)
) +
  geom_point(alpha = 0.75, size = 2) +
  scale_x_log10(labels = scales::label_number()) +
  labs(
    title = "Income and under-five mortality in 2022",
    x = "GDP per capita, PPP (log scale)",
    y = "Deaths per 1,000 live births",
    color = "Current income group",
    caption = "Source: World Bank, World Development Indicators."
  ) +
  theme_minimal(base_size = 12)

health_figure

# 6. Save a figure when the report needs a separate file ------------------

dir.create("outputs/lesson-4", recursive = TRUE, showWarnings = FALSE)
ggsave(
  "outputs/lesson-4/health-figure.png",
  health_figure,
  width = 8,
  height = 5,
  dpi = 200
)

# 7. Rendered reports ------------------------------------------------------
# Open materials/lesson-4-demo.qmd in RStudio. The document places prose and
# executable R chunks in one file. Click Render. Quarto reruns the chunks from
# a clean session, so a successful render is evidence that the brief contains
# the objects and steps it needs.

# 8. Plan the lab before asking an agent -----------------------------------
# For the selected track, write down:
#   - the unit and period;
#   - the variables required;
#   - the function sequence for the table;
#   - the mappings required for the figure;
#   - one claim the evidence could support;
#   - one claim the evidence could not support.

# After writing the table, figure, finding, and limitation, ask Codex to work
# read-only: reproduce the table, inspect the figure mappings, and challenge
# the most consequential statement. Independently verify one material claim
# before accepting, revising, or rejecting its recommendation.
