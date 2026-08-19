# LESSON 2 WALKTHROUGH: FROM A POLICY QUESTION TO A CHECKED TABLE ------------
#
# Open math-camp-2026.Rproj before using this file. During the lesson, run one
# section at a time with Command+Enter (macOS) or Ctrl+Enter (Windows). Use
# Source only when you want to rebuild the complete walkthrough from the frozen
# teaching file.
#
# The sections below follow the Lesson 2 deck in teaching order:
#   0       working setup
#   1-2     policy question, observation, key, and table plan
#   3       R grammar and source inspection
#   4-8     select, filter, mutate, arrange, group_by, and summarise
#   9-10    reshape and join while protecting the unit
#   11-12   save, record, and independently verify the table
#   13      bounded agent review and the Lab 2 handoff

# 0. Working setup ------------------------------------------------------------

source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)
dictionary <- read_csv(dictionary_file, show_col_types = FALSE)

cat("Lesson 2 source loaded:", format(nrow(wdi), big.mark = ","), "rows\n")


# 1. Begin with the policy question ------------------------------------------

briefing_context <- paste(
  "A development-policy team wants a short briefing on economic resources",
  "and child survival. It needs to see where higher income coincides with",
  "lower mortality and which economies do not follow that broad pattern.",
  "Its draft analysis table should contain one row per economy-year."
)

policy_question <- paste(
  "How is national income associated with under-five mortality",
  "across economies from 2000 to 2022?"
)

interpretation_boundary <- paste(
  "This is a descriptive, associational exercise.",
  "The table cannot by itself establish that income causes mortality to change."
)

briefing_context
policy_question
interpretation_boundary

# IN-CLASS PAUSE (2 minutes): Suppose Kenya-2022 appears in two rows of the
# draft analysis table. Ask students what could produce two rows for the same
# economy and period, and why that could change a table, plot, or conclusion.
# Do not reveal the role of indicator or join keys until after the discussion.

# 2. Define the observation, key, and table plan ------------------------------
#
# These two small objects reproduce the conceptual tables in the deck. We are
# not transforming the source yet. First, compare what one row means and which
# columns are required to identify it uniquely.

kenya_2022_long_example <- tibble(
  iso3c = c("KEN", "KEN"),
  country = c("Kenya", "Kenya"),
  year = c(2022L, 2022L),
  indicator = c("GDP per capita, PPP", "Under-five mortality"),
  value = c(5492, 40.5)
)

kenya_2022_wide_example <- tibble(
  iso3c = "KEN",
  country = "Kenya",
  year = 2022L,
  gdp_per_capita_ppp = 5492,
  under5_mortality = 40.5
)

kenya_2022_long_example
kenya_2022_wide_example

stopifnot(
  !anyDuplicated(
    kenya_2022_long_example[c("iso3c", "year", "indicator")]
  ),
  !anyDuplicated(kenya_2022_wide_example[c("iso3c", "year")])
)

# RETURN TO THE OPENING QUESTION
# Two Kenya-2022 rows could reflect a legitimate indicator dimension, another
# unnamed dimension such as sex/unit/version, a nonunique join key, or a record
# appended twice. If the intended unit is one economy-year, leaving both rows
# can give Kenya excess weight, duplicate a plotted point, create conflicting
# values, and change the apparent association. Diagnose before using distinct().

table_plan <- tibble(
  field = c("Population", "Unit", "Key", "Period", "Outcome", "Comparison"),
  decision = c(
    "Economy-years with both measures observed and positive income",
    "One economy-year",
    "iso3c + year",
    "2000-2022",
    "Under-five mortality per 1,000 live births",
    "GDP per capita, PPP"
  )
)

table_plan


# 3. Read R sentences and inspect the frozen source ---------------------------

# DECK CUE: Read this sentence as object -> assignment -> pipe -> function ->
# arguments. We run the full selection in Section 4, after inspecting the
# source. Keeping the preview commented prevents us from changing the table
# before we have described it.
#
# health_selected <- wdi |>
#   select(iso3c, year, gdp_per_capita_ppp, under5_mortality)

glimpse(wdi)
names(wdi)

# Run one small inspection at a time. We introduce summarise() later.
source_rows <- nrow(wdi)
source_rows

source_economies <- n_distinct(wdi$iso3c)
source_economies

source_years <- range(wdi$year)
source_years

source_duplicate_keys <- anyDuplicated(wdi[c("iso3c", "year")])
source_duplicate_keys

stopifnot(source_rows == 4991L)
stopifnot(source_economies == 217L)
stopifnot(identical(source_years, c(2000, 2022)))
stopifnot(source_duplicate_keys == 0)


# 4. select(): retain the columns required by the table plan -----------------

health_selected <- wdi |>
  select(
    iso3c,
    country,
    region,
    income_level_current,
    year,
    gdp_per_capita_ppp,
    under5_mortality
  )

names(health_selected)
glimpse(health_selected)

stopifnot(all(c("iso3c", "year") %in% names(health_selected)))


# 5. filter(): define the analytical population ------------------------------

health_filtered <- health_selected |>
  filter(
    between(year, 2000L, 2022L),
    !is.na(gdp_per_capita_ppp),
    gdp_per_capita_ppp > 0,
    !is.na(under5_mortality)
  )

filter_record <- tibble(
  stage = c("Frozen source", "Common health sample"),
  rows = c(nrow(wdi), nrow(health_filtered)),
  economies = c(n_distinct(wdi$iso3c), n_distinct(health_filtered$iso3c))
) |>
  mutate(rows_excluded = first(rows) - rows)

filter_record

# The filtered table is no longer evidence about every economy-year in the
# source. Its population is the economy-years included by the table plan.
#
# CHECKPOINT 1 — NAME WHO LEFT
# Discuss which population the filtered result represents, how to distinguish
# missing years from missing indicators, and what sample sentence should
# accompany a later table, plot, or model.


# 6. mutate(): create a value with a stated meaning ---------------------------

health_mutated <- health_filtered |>
  mutate(log_income = log(gdp_per_capita_ppp))

mutation_record <- health_mutated |>
  summarise(
    missing_income = sum(is.na(gdp_per_capita_ppp)),
    missing_log_income = sum(is.na(log_income)),
    min_income = min(gdp_per_capita_ppp),
    max_income = max(gdp_per_capita_ppp),
    all_log_values_finite = all(is.finite(log_income)),
    log_recomputes = isTRUE(all.equal(
      log_income,
      log(gdp_per_capita_ppp),
      tolerance = 1e-12
    ))
  )

mutation_record
stopifnot(mutation_record$all_log_values_finite)
stopifnot(mutation_record$log_recomputes)


# 7. arrange(): change display order, not the analytical unit ----------------

health_analysis <- health_mutated |>
  arrange(iso3c, year)

health_analysis |>
  select(iso3c, year, gdp_per_capita_ppp, under5_mortality, log_income) |>
  slice_head(n = 8)

stopifnot(nrow(health_analysis) == nrow(health_mutated))
stopifnot(!anyDuplicated(health_analysis[c("iso3c", "year")]))


# 8. group_by() + summarise(): deliberately change the unit ------------------

regional_year <- health_analysis |>
  group_by(region, year) |>
  summarise(
    mean_mortality = mean(under5_mortality),
    economies = n_distinct(iso3c),
    .groups = "drop"
  )

regional_year |>
  arrange(region, year) |>
  print(n = 12)

stopifnot(!anyDuplicated(regional_year[c("region", "year")]))

# One row now means a region-year. This is a new table for a new descriptive
# purpose; it does not replace the economy-year analysis table.
#
# DECK CUE — PREDICT THE REGIONAL OUTPUT
# With seven regions and 23 years, the largest possible result has 161 rows.
# Ask why incomplete coverage could make the observed count smaller and why
# the number of contributing economies matters alongside the mean.


# 9. Reshape only after naming the source and target units --------------------
#
# The frozen source is already wide. Here we temporarily reshape one real
# Kenya-2022 observation to demonstrate the deck's long-to-wide logic with R.

kenya_2022_wide <- wdi |>
  filter(iso3c == "KEN", year == 2022L) |>
  select(
    iso3c,
    country,
    year,
    gdp_per_capita_ppp,
    under5_mortality
  )

kenya_2022_long <- kenya_2022_wide |>
  pivot_longer(
    cols = c(gdp_per_capita_ppp, under5_mortality),
    names_to = "indicator",
    values_to = "value"
  )

kenya_2022_long

# Two Kenya-2022 rows are correct here because one row means an
# economy-year-indicator. The indicator therefore belongs in the key.
stopifnot(
  !anyDuplicated(kenya_2022_long[c("iso3c", "year", "indicator")])
)

kenya_2022_rebuilt <- kenya_2022_long |>
  pivot_wider(names_from = indicator, values_from = value)

kenya_2022_rebuilt
stopifnot(!anyDuplicated(kenya_2022_rebuilt[c("iso3c", "year")]))


# 10. left_join(): protect the left table from row multiplication -------------

country_metadata <- wdi |>
  distinct(iso3c, country, region, income_level_current)

stopifnot(!anyDuplicated(country_metadata["iso3c"]))

health_core <- health_analysis |>
  select(-country, -region, -income_level_current)

health_joined <- health_core |>
  left_join(country_metadata, by = "iso3c") |>
  relocate(country, region, income_level_current, .after = iso3c)

join_record <- tibble(
  left_rows = nrow(health_core),
  joined_rows = nrow(health_joined),
  unmatched_economies = health_core |>
    anti_join(country_metadata, by = "iso3c") |>
    distinct(iso3c) |>
    nrow(),
  duplicate_economy_year_keys = anyDuplicated(
    health_joined[c("iso3c", "year")]
  )
)

join_record
stopifnot(join_record$left_rows == join_record$joined_rows)
stopifnot(join_record$unmatched_economies == 0)
stopifnot(join_record$duplicate_economy_year_keys == 0)

# Demonstration only: duplicating Kenya in the right-side metadata table makes
# every Kenya-year row appear twice after the join. We diagnose the right-side
# key instead of deleting duplicated output rows.
bad_metadata <- bind_rows(
  country_metadata,
  country_metadata |> filter(iso3c == "KEN")
)

bad_metadata |>
  count(iso3c, sort = TRUE) |>
  filter(n > 1)

bad_join <- health_core |>
  left_join(bad_metadata, by = "iso3c", relationship = "many-to-many")

tibble(
  correct_rows = nrow(health_core),
  bad_join_rows = nrow(bad_join),
  extra_rows = nrow(bad_join) - nrow(health_core),
  distinct_economy_years = n_distinct(paste(bad_join$iso3c, bad_join$year))
)

# CHECKPOINT 2 — APPROVE OR STOP THE JOIN
# The code can run without an R error while multiplying rows. Before accepting
# a join, identify the broken assumption, inspect the right-side key, and state
# the evidence required for the join to proceed.


# 11. Save the checked analysis table and its build record --------------------

health_analysis <- health_joined |>
  select(
    iso3c,
    country,
    region,
    income_level_current,
    year,
    gdp_per_capita_ppp,
    under5_mortality,
    log_income
  ) |>
  arrange(iso3c, year)

build_record <- health_analysis |>
  summarise(
    source_rows = nrow(wdi),
    rows = n(),
    rows_excluded = nrow(wdi) - n(),
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
  health_analysis,
  file.path(outputs_dir, "02-health-analysis.csv"),
  na = ""
)

write_csv(
  build_record,
  file.path(outputs_dir, "02-health-build-record.csv"),
  na = ""
)

build_record


# 12. Independently verify the saved object ----------------------------------
#
# This reopens the saved output in a separate script and verifies it against
# the frozen source. Run this section after the output files have been written.

source("code/02-verify-analysis.R")


# 13. Guided agent review and Lab 2 handoff ----------------------------------
#
# DEMONSTRATION GOAL
# Strengthen one documented check for under5_mortality without changing the
# table, sample, key, or transformation. The target evidence is that the data
# dictionary identifies the variable as SH.DYN.MORT and states its unit per
# 1,000 live births.
#
# STEP 1 — ESTABLISH THE BASELINE
# Run these commands in the RStudio Terminal before opening the agent:
#   Rscript code/02-build-analysis.R
#   Rscript code/02-verify-analysis.R
# Record the green result so the class knows what must remain true.
#
# STEP 2 — LOCATE THE GAP
# The verifier checks observed and nonnegative mortality values, but it does not
# yet connect the column to the documented indicator identity and unit.
#
# STEP 3 — REQUEST ONE READ-ONLY PROPOSAL

bounded_agent_request <- paste(
  "Goal: Propose the smallest change to code/02-verify-analysis.R that",
  "confirms the under5_mortality dictionary entry has indicator code",
  "SH.DYN.MORT and a unit stated per 1,000 live births.",
  "Context: Read the verifier and data/documentation/indicator-dictionary.csv.",
  "Permission: Read only. Show a proposed diff; do not edit yet.",
  "Constraints: Do not change the table, sample, key, or variables.",
  "Done when: Explain what the new check proves and name the command we",
  "should rerun after reviewing it."
)

bounded_agent_request

# STEP 4 — INSPECT BEFORE EDITING
# Check that the proposal reads the dictionary, tests the code and unit, leaves
# the analysis table unchanged, and has a predictable result.
#
# CHECKPOINT 3 — WHICH PROPOSAL SERVES THE GOAL?
# Reject an invented upper bound of 100: mortality is measured per 1,000 live
# births, not as a percentage. Prefer a definition-aware dictionary check.
#
# STEP 5 — APPLY ONE ACCEPTED CHANGE AND RERUN THE VERIFIER
# The demonstration ends only if the new check and all existing checks pass,
# the table is unchanged, and the class can explain the evidence produced.

# LAB 2 HANDOFF
# Students reopen the green project, complete code/lab-2-starter.R, build the
# table, preserve a build record, request at most one bounded agent improvement,
# and finish by running Rscript code/02-verify-analysis.R in the Terminal.
