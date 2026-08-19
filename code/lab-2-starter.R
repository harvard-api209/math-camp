source("code/00-setup.R")

wdi <- read_csv(data_file, show_col_types = FALSE)

# LAB 2 TABLE CONTRACT
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

# 2. filter(): apply the period and observed-value rules in your contract.

# 3. mutate(): create log_income only after checking that income is positive.

# 4. arrange(): make the saved table easy to inspect by economy and year.

# 5. verify(): add checks for columns, rows, the key, period, missingness,
# ranges, and the relationship between income and log_income.

# 6. save(): write the checked object to outputs/02-health-analysis.csv.

# 7. record: create a one-row build record with source rows, output rows,
# exclusions, economies, years, duplicate keys, missingness, and ranges.

message(
  "Starter opened successfully. Replace the scaffold with your checked ",
  "pipeline, then compare your result with code/02-verify-analysis.R."
)
