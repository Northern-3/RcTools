# Helper to Extract A Letter Grade From Scores

Helper to Extract A Letter Grade From Scores

## Usage

``` r
bind_letter_to_score(df, columns, rows)
```

## Arguments

- df:

  A dataframe/table/spreadsheet

- columns:

  Range. The column indices to be targeted.

- rows:

  Range. The row indicies to be targeted.

## Value

A dataframe with letters attached to scores

## Examples

``` r
if (FALSE)  #dont run because function is not exported
df <- data.frame(
 "Areas" = c("A", "B", "C", "D", "E", "F"),
 "Score1" = c(0, 20, 40, 60, 80, 100),
 "Score2" = c(0, 20, 40, 60, 80, 100),
 "Other" = c("Z", "Y", "X", "W", "V", "U")
)

bind_letter_to_score(
 df = df, 
 columns = 2:3,
 rows = 2:3
)
#> Error in bind_letter_to_score(df = df, columns = 2:3, rows = 2:3): could not find function "bind_letter_to_score"
 # \dontrun{}
```
