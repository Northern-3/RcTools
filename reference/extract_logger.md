# Extract AIMS MMP Logger Data

Extract AIMS MMP Logger Data

## Usage

``` r
extract_logger(
  Years,
  Loggers,
  Indicators = c("chlorophyll", "turbidity"),
  FilterFlags = TRUE,
  FlagTags = c(1, 2),
  Aggregate = FALSE,
  AggregationType,
  SmallTables = FALSE,
  RowCount = 1500
)
```

## Arguments

- Years:

  Numeric Vector. The year(s) of data you want to access.

- Loggers:

  Character Vector. The name(s) of the logger(s) you want to access.

- Indicators:

  Character Vector. The name(s) of the indicators you want to access,
  can be Chlorophyll and/or Turbidity.

- FilterFlags:

  Boolean. Do you want to filter the data by its quality flags? This
  defaults to TRUE (yes).

- FlagTags:

  Numeric Vector. A vector of flag tags to keep, choices are: 0 =
  No_QC_performed, 1 = Good_data, 2 = Probably_good_data, 3 =
  Bad_data_that_are_potentially_correctable, 4 = Bad_data, 5 =
  Value_changed. Advice from data providers is to keep only tags 1
  and 2. By default only tags 1 and 2 are kept.

- Aggregate:

  Boolean. Do you want to aggregate data to daily values? This defaults
  to FALSE (no) and returns 10-minute interval data.

- AggregationType:

  Character String. Defines the type of aggregation to apply, one of:
  Hourly, or Daily

- SmallTables:

  Boolean. Do you want to return small tables (less than 1,500 rows per
  table). This defaults to FALSE (no)

- RowCount:

  Numeric String. The number of rows in each "small table", defaults to
  1500

## Value

A list of dataframes

## Examples

``` r
wq_data <- extract_logger(
Years = 2025, 
Loggers = "BUR2"
)
```
