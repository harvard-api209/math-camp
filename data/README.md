# Math Camp 2026 data

The default teaching dataset is a frozen country-year extract from the World Bank World Development Indicators API.

## Student use

Open `math-camp-2026.Rproj`. The frozen files are inputs, not scratch space.
Inspect them with:

```bash
Rscript code/01-inspect.R
```

To request current public observations for one indicator without changing the
baseline:

```bash
Rscript code/04-update-indicator.R SH.DYN.MORT under5_mortality
```

That command writes a retrieval-dated file under `data/updates/`. Compare new
years and historical revisions explicitly; do not rename the result to look
like the frozen file.

## Maintainer build

From `math-camp/2026` run:

```bash
MATH_CAMP_WRITE_FROZEN=YES Rscript data/build_wdi.R
```

Without the opt-in variable, the build stops before writing. The validated
build creates:

- `derived/math-camp-wdi-2000-2022.csv`: one row per country-year.
- `derived/math-camp-wdi-2000-2022-long.csv`: one row per country-year-indicator.
- `documentation/indicator-dictionary.csv`: track, indicator name, unit,
  definition, source organization, periodicity, source URL, and retrieval date.

The 2000-2022 end date is intentional. It makes the class copy stable. Lab 2 asks students to use an agent and the World Bank API to update the file to the latest available observations, then audit what changed. The latest available year will differ across indicators.

The data contain no individual records or personally identifiable information.

## Classification warning

`income_level_current` and `lending_type_current` come from the country metadata
available when the snapshot was assembled. They are current descriptors joined
to historical observations, not historically varying classifications. Do not
write that a country belonged to the same category in every year. Country joins
use `iso3c`; the build reports country-name disagreements rather than joining on
names.
