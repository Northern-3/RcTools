# A function to help with various forms of netCDF aggregation

A function to help with various forms of netCDF aggregation

## Usage

``` r
nc_aggregation_helper(nc, agg, func)
```

## Arguments

- nc:

  A netCDF object

- agg:

  The type of aggregation to complete, defaults to "Month". Options are
  "Month", "Season", "Financial", "Annual"

- func:

  Function. (NO QUOTES). Defines the function to apply to the level of
  aggregation. Generally only "mean" and "sum" have been used so far.
  Again, without quotes.

## Value

A netCDF object

## Examples

``` r
nc <- system.file("extdata/turb_reg.nc", package = "RcTools")
nc <- stars::read_mdim(nc)

x <- nc_aggregation_helper(nc, "Month", mean)
 
```
