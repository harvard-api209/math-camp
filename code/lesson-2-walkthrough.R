# LESSON 2 WALKTHROUGH: FROM A POLICY QUESTION TO A CHECKED TABLE ------------
#
# Open math-camp-2026.Rproj before using this file. During the lesson, run one
# section at a time with Command+Enter (macOS) or Ctrl+Enter (Windows). Use
# Source only when you want to rebuild the complete walkthrough from the frozen
# teaching file.

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

# IN-CLASS PAUSE (2 minutes): Suppose Kenya-2022 appears in two rows of the
# draft analysis table. Ask students what could produce two rows for the same
# economy and period, and why that could change a table, plot, or conclusion.
# Do not reveal the role of indicator or join keys until after the discussion.

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

briefing_context
policy_question
interpretation_boundary
table_plan


# 2. The same evidence can have different row meanings -----------------------
#
# The frozen teaching file is already wide: one economy-year row contains many
# indicators in separate columns. We temporarily reshape one real observation
# to long form so the role of the key is visible.

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

# Two Kenya-2022 rows are correct here. One row means an
# economy-year-indicator, so indicator belongs in the key.
kenya_2022_long |>
  count(iso3c, year, name = "rows_per_economy_year")

stopifnot(
  !anyDuplicated(kenya_2022_long[c("iso3c", "year", "indicator")])
)

# For our analysis, the two indicators must be columns on one economy-year row.
kenya_2022_rebuilt <- kenya_2022_long |>
  pivot_wider(names_from = indicator, values_from = value)

kenya_2022_rebuilt
stopifnot(!anyDuplicated(kenya_2022_rebuilt[c("iso3c", "year")]))

# RETURN TO THE OPENING QUESTION
# Two Kenya-2022 rows could reflect a legitimate indicator dimension, another
# unnamed dimension such as sex/unit/version, a nonunique join key, or a record
# appended twice. If the intended unit is one economy-year, leaving both rows
# can give Kenya excess weight, duplicate a plotted point, create conflicting
# values, and change the apparent association. Diagnose before using distinct().


# 3. Inspect the frozen source before transforming it -------------------------

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


# 9. left_join(): protect the left table from row multiplication --------------

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


# 10. Save the checked analysis table and its build record --------------------

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


# 11. Independent completion check -------------------------------------------
#
# This reopens the saved output in a separate script and verifies it against
# the frozen source. Run this section after the output files have been written.

source("code/02-verify-analysis.R")
