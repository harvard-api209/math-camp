# Run from a terminal:
# Rscript code/check_setup.R --codex-confirmed

args <- commandArgs(trailingOnly = TRUE)
codex_confirmed <- "--codex-confirmed" %in% args

find_project_root <- function(start = getwd()) {
  candidate <- normalizePath(start, winslash = "/", mustWork = TRUE)
  repeat {
    if (file.exists(file.path(candidate, "math-camp-2026.Rproj"))) {
      return(candidate)
    }
    parent <- dirname(candidate)
    if (identical(parent, candidate)) {
      return(NA_character_)
    }
    candidate <- parent
  }
}

checks <- list()

add_check <- function(name, status, evidence, repair) {
  checks[[length(checks) + 1L]] <<- data.frame(
    check = name,
    status = status,
    evidence = evidence,
    repair = repair,
    stringsAsFactors = FALSE
  )
}

root <- find_project_root()
root_ok <- !is.na(root)
add_check(
  "Project",
  if (root_ok) "GREEN" else "RED",
  if (root_ok) root else "math-camp-2026.Rproj was not found",
  "Open math-camp-2026.Rproj in RStudio, then rerun this command."
)

r_ok <- getRversion() >= "4.2.0"
add_check(
  "R",
  if (r_ok) "GREEN" else "RED",
  paste("R", getRversion()),
  "Install a current version of R from CRAN."
)

packages <- c("dplyr", "ggplot2", "jsonlite", "readr", "tidyr")
missing_packages <- packages[
  !vapply(packages, requireNamespace, logical(1), quietly = TRUE)
]
packages_ok <- length(missing_packages) == 0
add_check(
  "Packages",
  if (packages_ok) "GREEN" else "RED",
  if (packages_ok) {
    paste(packages, collapse = ", ")
  } else {
    paste("Missing:", paste(missing_packages, collapse = ", "))
  },
  paste0(
    "Run install.packages(c(",
    paste(sprintf('"%s"', missing_packages), collapse = ", "),
    "))."
  )
)

quarto_path <- Sys.which("quarto")
quarto_ok <- nzchar(quarto_path)
add_check(
  "Quarto",
  if (quarto_ok) "GREEN" else "RED",
  if (quarto_ok) quarto_path else "quarto was not found on PATH",
  "Install Quarto, restart RStudio, and rerun this command."
)

data_path <- if (root_ok) {
  file.path(root, "data", "derived", "math-camp-wdi-2000-2022.csv")
} else {
  ""
}
data_ok <- root_ok && file.exists(data_path)
add_check(
  "Data",
  if (data_ok) "GREEN" else "RED",
  if (data_ok) data_path else "The frozen CSV was not found",
  "Download the complete course project rather than an individual HTML page."
)

add_check(
  "Codex",
  if (codex_confirmed) "GREEN" else "YELLOW",
  if (codex_confirmed) {
    "You confirmed that Codex opens with the course project."
  } else {
    "Manual confirmation is still required."
  },
  paste(
    "Open Codex with the Harvard-supported account, open this project,",
    "then rerun with --codex-confirmed."
  )
)

results <- do.call(rbind, checks)

cat("\nMATH CAMP 2026 SETUP CHECK\n")
cat(strrep("=", 72), "\n", sep = "")
for (i in seq_len(nrow(results))) {
  cat(sprintf("[%s] %s\n", results$status[i], results$check[i]))
  cat("  Evidence: ", results$evidence[i], "\n", sep = "")
  if (results$status[i] != "GREEN") {
    cat("  Repair:   ", results$repair[i], "\n", sep = "")
  }
}
cat(strrep("=", 72), "\n", sep = "")

automatic_failures <- any(results$status == "RED")
manual_pending <- any(results$status == "YELLOW")

if (automatic_failures) {
  cat("RESULT: RED. Repair every red check before the coding exercise.\n")
  quit(status = 1)
}
if (manual_pending) {
  cat("RESULT: YELLOW. Automatic checks passed; confirm Codex access.\n")
  quit(status = 2)
}

cat("RESULT: GREEN. The project is ready for the first coding exercise.\n")
