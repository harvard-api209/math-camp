# Math Camp 2026 data

The default teaching dataset is a frozen country-year extract from the World Bank World Development Indicators API.

## Build

From `math-camp/2026` run:

```bash
Rscript data/build_wdi.R
```

The build creates:

- `derived/math-camp-wdi-2000-2022.csv`: one row per country-year.
- `derived/math-camp-wdi-2000-2022-long.csv`: one row per country-year-indicator.
- `documentation/indicator-dictionary.csv`: source codes and API links.

The 2000-2022 end date is intentional. It makes the class copy stable. Lab 2 asks students to use an agent and the World Bank API to update the file to the latest available observations, then audit what changed. The latest available year will differ across indicators.

The data contain no individual records or personally identifiable information.
