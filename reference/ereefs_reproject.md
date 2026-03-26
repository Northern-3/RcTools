# Convert the eReefs object from curvilinear to a regular grid

Convert the eReefs object from curvilinear to a regular grid

## Usage

``` r
ereefs_reproject(nc)
```

## Arguments

- nc:

  A single NetCDF (stars) object, generally produced by the
  [`extract_ereefs()`](https://add-am.github.io/RcTools/reference/extract_ereefs.md)
  function

## Value

A single NetCDF (stars) object, with the same values as x, but in a
regular grid format

## Examples

``` r
load(system.file("extdata/turb_curvi.RData", package = "RcTools"))
 
nc_reg <- ereefs_reproject(turb_curvi)
#> threshold set to 1054.63 : set a larger value if you see missing values where there shouldn't be
```
