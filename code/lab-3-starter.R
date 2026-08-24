# LAB 3 STUDENT STARTER: ALL COUNTRIES AND ONE REGION ----------------------
#
# Complete four exercises in this file before opening Codex:
#   1. Describe one region.
#   2. Construct an all-countries briefing and a regional briefing.
#   3. Visualize the all-countries and regional patterns.
#   4. Write your own interpretation of the evidence.
#
# Save this file after Exercise 4. Codex will then read the same file, fit a
# bounded model for all countries and the selected region, and draft a claim
# for you to check against your tables and figures.


# 00-05: OPEN THE CHECKED LESSON 2 DATA ------------------------------------

source("code/00-setup.R")

analysis_file <- file.path(outputs_dir, "02-health-analysis.csv")

health_panel <- read_csv(
  analysis_file,
  show_col_types = FALSE
) |>
  mutate(log_mortality = log(under5_mortality))

glimpse(health_panel)

region_options <- sort(unique(health_panel$region))

region_options


# EXERCISE 1: DESCRIBE ONE REGION -----------------------------------------
# 05-14 minutes

# Replace the example with one region from region_options. Keep this choice
# unchanged for the remainder of the lab.
selected_region <- "Sub-Saharan Africa"

regional_panel <- health_panel |>
  filter(region == selected_region)

regional_record <- regional_panel |>
  summarise(
    rows = n(),
    economies = n_distinct(iso3c),
    years = n_distinct(year),
    first_year = min(year),
    last_year = max(year),
    missing_income = sum(is.na(gdp_per_capita_ppp)),
    missing_mortality = sum(is.na(under5_mortality))
  )

regional_record

# CHECKPOINT 1
# In your own words, record:
#   - what one row represents;
#   - whether every economy contributes the same number of years;
#   - one coverage issue that could affect a regional comparison.

regional_description <- ""


# EXERCISE 2: CONSTRUCT TWO BRIEFING TABLES --------------------------------
# 14-28 minutes

briefing_years <- c(2000L, 2010L, 2022L)

# The all-countries table establishes the comparison. It reports the number of
# contributing economies and the median value of each outcome in three years.
all_countries_briefing <- health_panel |>
  filter(year %in% briefing_years) |>
  group_by(year) |>
  summarise(
    economies = n_distinct(iso3c),
    median_income = median(gdp_per_capita_ppp, na.rm = TRUE),
    median_mortality = median(under5_mortality, na.rm = TRUE),
    .groups = "drop"
  )

all_countries_briefing

# Construct regional_briefing from regional_panel. It should have the same
# years and columns as all_countries_briefing so the two tables can be compared.
# Explore ?group_by, ?summarise, ?n_distinct, and ?median if needed.
regional_briefing <- NULL

regional_briefing

# CHECKPOINT 2
# Compare 2000 with 2022. Record one all-countries change, one regional change,
# and one reason to inspect the number of contributing economies before making
# the comparison.

briefing_table_notes <- ""


# EXERCISE 3: VISUALIZE BOTH PATTERNS --------------------------------------
# 28-42 minutes

# Recreate the full-panel figure from Lesson 3. Each point should represent one
# economy-year, GDP per capita should be horizontal, mortality should be
# vertical, and both axes should use logarithmic scales. Include the years,
# units, and source in the labels.
plot_all_countries <- ggplot()

plot_all_countries

# Create the same figure using regional_panel. Keep the variables, units,
# scales, and visual treatment unchanged so the regional and all-countries
# patterns are directly comparable. Change the title to name selected_region.
plot_region <- ggplot()

plot_region

# CHECKPOINT 3
# Record one feature shared by the two figures, one meaningful difference, and
# one conclusion that neither figure can establish.

figure_notes <- ""


# EXERCISE 4: WRITE YOUR INTERPRETATION BEFORE CODEX -----------------------
# 42-48 minutes

# Work independently. Use the two briefing tables and two figures to complete
# all three entries. Name the sample, period, direction of the association, and
# at least one limitation. Do not ask Codex yet.

all_countries_claim <- ""

regional_claim <- ""

comparison_note <- ""

# Save this script now. Codex must inspect the version containing your selected
# region, completed tables, figures, and initial interpretation.


# AFTER EXERCISE 4: GIVE THE SAVED FILE TO CODEX ---------------------------
# 48-57 minutes

# Give Codex this prompt only after saving your completed work:
#
# Read my completed code/lab-3-starter.R and
# outputs/02-health-analysis.csv. Work read-only and do not edit files. First,
# run or reproduce the objects in my saved script and confirm my selected
# region, sample sizes, briefing tables, and plot mappings. Then fit two pooled
# log-log models of under-five mortality on GDP per capita: one using
# health_panel and one using regional_panel. For each model, report the number
# of observations and economies, the log-income coefficient, and the estimated
# percentage difference in mortality associated with 10% higher income. Show
# the exact R code used. Finally, assess all_countries_claim, regional_claim,
# and comparison_note against my saved tables, figures, and your calculations.
# Draft one revised all-countries claim and one revised regional claim. Clearly
# separate numerical reproduction from interpretation and do not assume that
# an association is causal.

# CHECK THE CODEX RESPONSE
# Select one material statement from the response. Record the statement, the R
# object or calculation you used to check it, and whether you accept, revise,
# or reject it.

agent_statement <- ""

verification_evidence <- ""

verification_decision <- ""


# 57-60: DEBRIEF -----------------------------------------------------------

# Be ready to report:
#   1. the main difference between the all-countries and regional briefings;
#   2. one claim supported by your regional figure;
#   3. one Codex statement you accepted, revised, or rejected and why.
