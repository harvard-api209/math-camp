# Shared project setup for Math Camp 2026 scripts.

find_math_camp_root <- function(start = getwd()) {
  candidate <- normalizePath(start, winslash = "/", mustWork = TRUE)

  repeat {
    project_file <- file.path(candidate, "math-camp-2026.Rproj")
    if (file.exists(project_file)) {
      return(candidate)
    }

    parent <- dirname(candidate)
    if (identical(parent, candidate)) {
      stop(
        "Could not find math-camp-2026.Rproj. ",
        "Open the project in RStudio or run the script from inside the project."
      )
    }
    candidate <- parent
  }
}

required_packages <- c("dplyr", "ggplot2", "readr", "tidyr", "broom")
missing_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]

if (length(missing_packages) > 0) {
  stop(
    "Install required packages before continuing: ",
    paste(missing_packages, collapse = ", ")
  )
}

math_camp_root <- find_math_camp_root()
data_file <- file.path(
  math_camp_root,
  "data",
  "derived",
  "math-camp-wdi-2000-2022.csv"
)
dictionary_file <- file.path(
  math_camp_root,
  "data",
  "documentation",
  "indicator-dictionary.csv"
)
lab2_draft_file <- file.path(
  math_camp_root,
  "data",
  "lab-2",
  "health-briefing-draft.csv"
)
outputs_dir <- file.path(math_camp_root, "outputs")

if (!file.exists(data_file)) {
  stop("The frozen teaching file is missing: ", data_file)
}
if (!file.exists(dictionary_file)) {
  stop("The indicator dictionary is missing: ", dictionary_file)
}
if (!file.exists(lab2_draft_file)) {
  lab2_draft_file <- NA_character_
}

dir.create(outputs_dir, recursive = TRUE, showWarnings = FALSE)

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(readr)
  library(tidyr)
  library(broom)
})
