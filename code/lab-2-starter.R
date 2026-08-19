source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)

# LAB 2 TABLE PLAN: define the finished table before writing data verbs.
# Population:
# Unit:
# Key:
# Period:
# Outcome:
# Comparison:

# Build the common health table one verb at a time. After every verb, predict
# what should change, run the smallest useful check, and record what happened.
health_analysis <- wdi

# 1. select(): retain the identifiers, metadata, and two health-track measures.

# 2. filter(): apply the period and observed-value rules in your table plan.

# 3. mutate(): create log_income only after checking that income is positive.

# 4. arrange(): make the saved table easy to inspect by economy and year.

# 5. save(): write the checked object to outputs/02-health-analysis.csv.

# 6. record: create a one-row build record with source rows, output rows,
# exclusions, economies, years, duplicate keys, missingness, and ranges.

# 7. verify independently: in the RStudio Terminal, run:
# Rscript code/02-verify-analysis.R

# 8. agent review (read only): write one draft sentence about the saved table.
# Ask Codex to classify each part as supported by the current artifacts, not yet
# calculated, or unsupported by this descriptive design. Require exact file and
# value citations. Do not ask it to edit the builder or verifier.

# 9. handoff: record one fact the artifacts support and one question that must
# wait for Lesson 3, when we will calculate and visualize the relationship.

message(
  "Starter opened successfully. Replace the scaffold with your checked ",
  "pipeline, save its evidence, run code/02-verify-analysis.R from the ",
  "Terminal, and then review one claim."
)
