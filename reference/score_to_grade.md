# Function that converts scores to grades

Function that converts scores to grades

## Usage

``` r
score_to_grade(df, score_cols)
```

## Arguments

- df:

  Dataframe. The table that contains the score(s) you are interested in.

- score_cols:

  Numeric column(s). Any number of numeric columns that contain scores.
  Values are expected to range from 0 to 100

## Value

The original dataframe with new grade columns added. Names are inherited
from the targeted columns.

## Examples

``` r
x <- data.frame(
 Basin = c("Black", "Ross", "Haughton", "Suttor"),
 ScoreA = c(51, 76, 27, 98),
 ScoreB = c(7, 42, 89, 63),
 ScoreC = c(15, 34, 56, 21)
)
x <- score_to_grade(x, c(ScoreA, ScoreB, ScoreC))
  
```
