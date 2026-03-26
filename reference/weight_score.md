# Function that weights scores based on predetermined weighting values

Function that weights scores based on predetermined weighting values

## Usage

``` r
weight_score(df, score, weighting)
```

## Arguments

- df:

  Dataframe. The table that contains the value(s) you are interested in.

- score:

  Numeric column(s). Any number of numeric columns that contain scores
  to be weighted.

- weighting:

  Numeric column. A singular numeric column that contains weighting
  values, must be the same length as the score column(s). Weights should
  be decimal (i.e. a 25% weighting should be written as 0.25).

## Value

The original dataframe with new weighted scores added. Names are
inherited from the targeted columns.

## Examples

``` r
x <- data.frame(
 Basin = c("Black", "Ross", "Haughton", "Suttor"),
 Indicator = c("DIN", "DIN", "Low_DO", "Low_DO"),
 Score = c(100, 55, 67, 18),
 Weight = c(0.25, 0.5, 0.3, 0.2)
)

x <- x |> 
  weight_score(
    score = Score,
    weighting = Weight
  )
 
```
