# A Helper That Presents Conditional Formatting Options

A Helper That Presents Conditional Formatting Options

## Usage

``` r
conditional_formatter(
  data,
  workbook,
  target_columns,
  target_rows,
  scheme,
  include_letter,
  file_name
)
```

## Arguments

- data:

  The main dataframe to run functions on

- workbook:

  An excel workbook object.

- target_columns:

  Numeric Vector. The columns that colour grading should be applied to.
  e.g. 1:10.

- target_rows:

  Numeric Vector. The rows that colour grading should be applied to.
  e.g. 1:10.

- scheme:

  String. Defines the conditional formatting rules and colours. Options
  are Report Card Grade, Report Card Score, Rainfall Temperature,
  Summary Stat

- include_letter:

  Boolean. Should a letter grade be attached to the score? This is
  specific to Report Card scores

- file_name:

  String. The name of the file you want to save. Without the extension

## Value

An excel workbook object

## Examples

``` r
if (FALSE) { # \dontrun{
conditional_formatter(
  data, workbook, target_columns, target_rows, 
  scheme, include_letter, file_name
)
} # }
```
