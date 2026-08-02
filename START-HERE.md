# Math Camp 2026 student project

This folder is the runnable companion to the Math Camp teaching book. Open
`math-camp-2026.Rproj` in RStudio before running code.

## First day

1. Follow the public `setup/` guide.
2. Confirm that Codex opens with your Harvard-supported account.
3. From the project root, run:

   ```sh
   Rscript code/check_setup.R --codex-confirmed
   ```

4. Do not continue until every automatic check is green.
5. Run the scripts in order:

   ```sh
   Rscript code/01-inspect.R
   Rscript code/02-build-analysis.R
   Rscript code/03-compare.R
   ```

Each script starts from saved files. None depends on objects created manually in
the R console.

## The four policy paths

Everyone begins with the health example in `code/02-build-analysis.R` and
`code/03-compare.R`. After that, choose one complete optional recipe:

- `code/tracks/01-health.R`
- `code/tracks/02-gender.R`
- `code/tracks/03-access.R`
- `code/tracks/04-climate.R`

Each recipe reads the frozen dataset, defines its own sample, checks its key,
creates a figure, and writes a short evidence receipt to `outputs/`.

## Updating public data

The frozen 2000–2022 files are protected teaching inputs. The student update
script writes only to `data/updates/`:

```sh
Rscript code/04-update-indicator.R SH.DYN.MORT under5_mortality
```

Never rename an update to look like the frozen baseline. Record retrieval dates
and compare new years separately from historical revisions.

## What to keep

Nothing is submitted or graded. If useful, keep:

- one script you understand;
- one figure and a careful sentence;
- one verification record;
- one note describing how an AI agent helped and how you checked it.
