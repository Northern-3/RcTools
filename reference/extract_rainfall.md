# Extract Rainfall Data from BOM AWO API

Extract Rainfall Data from BOM AWO API

## Usage

``` r
extract_rainfall(CropObj, StartDate = NULL, EndDate = NULL)
```

## Arguments

- CropObj:

  Sf Object. An sf object used to define the area in which data is to be
  cropped to. Generally, the n3_region object from the
  [`build_n3_region()`](https://add-am.github.io/RcTools/reference/build_n3_region.md)
  function is used.

- StartDate:

  A character string in the format of YYYY-MM-DD. Defaults to
  "1911-01-31" (earliest value)

- EndDate:

  A character string in the format of YYYY-MM-DD. Defaults to newest
  value

## Value

A stars netCDF object

## Examples

``` r
if (FALSE)  #dont run because example takes a while
n3_region <- build_n3_region()

rain_data <- extract_rainfall(n3_region, "2022-01-01", "2022-02-01")
#> Error: object 'n3_region' not found
 # \dontrun{}
```
