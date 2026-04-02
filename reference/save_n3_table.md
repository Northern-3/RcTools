# Conditional Formatting with .xlsx Output

Conditional Formatting with .xlsx Output

## Usage

``` r
save_n3_table(
  df,
  file_name,
  target_columns,
  target_rows = NULL,
  scheme,
  include_letter = FALSE
)
```

## Arguments

- df:

  A standard dataframe, data.frame, table, spreadsheet, etc.

- file_name:

  String. The name to save the output under, without an extension.

- target_columns:

  Numeric Vector. The columns that colour grading should be applied to.
  e.g. 1. 1:10. 1,2.

- target_rows:

  Numeric Vector. The rows that colour grading should be applied to.
  e.g. 1:10.

- scheme:

  String. One of several options: Report Card, Rainfall, Temperature,
  Summary Statistic, Presence Absence. This determines the colour scheme
  and conditional formatting schemes used.

- include_letter:

  Boolean. Should a letter grade be attached to the score? This is
  specific to Report Card scores (under the Report Card scheme).

## Value

A .xlsx output

## Examples

``` r
if (FALSE)  #dont run because the function saves an file externally 
x <- data.frame(
 Basin = c("Black", "Ross", "Haughton", "Suttor"),
 DIN = c(51, 76, 27, 98),
 TP = c(90, 57, 34, 72)
)
save_n3_table(
 df = x, 
 file_name = "final_scores", 
 target_columns = 2:3, 
 target_rows = 2:5, 
 scheme = "Report Card",
 include_letter = FALSE
)
#> Error: object 'x' not found
 # \dontrun{}
```
