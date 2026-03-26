# Helper to Select Various Colour Schemes

Helper to Select Various Colour Schemes

## Usage

``` r
define_colour_scheme(workbook, scheme)
```

## Arguments

- workbook:

  A excel workbook object created by openxlsx2

- scheme:

  String. One of several options: Report Card, Rainfall, Temperature,
  Summary Stat, TBD.

## Value

The supplied workbook object, now with the colour scheme embedded

## Examples

``` r
if (FALSE)  #dont run because function is not exported
wb <- openxlsx2::wb_workbook()
define_colour_scheme(workbook = wb, scheme = "Report Card")
#> Error in define_colour_scheme(workbook = wb, scheme = "Report Card"): could not find function "define_colour_scheme"
 # \dontrun{}
```
