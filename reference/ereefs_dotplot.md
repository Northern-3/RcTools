# Plotting eReefs Data

Plotting eReefs Data

## Usage

``` r
ereefs_dotplot(
  nc,
  SubSample = 500,
  Heading = NULL,
  YAxisName = NULL,
  LogTransform = FALSE,
  AttributeName = NULL
)
```

## Arguments

- nc:

  A single NetCDF (stars) object OR a list of NetCDF (stars) objects,
  generally produced by the
  [`extract_ereefs()`](https://add-am.github.io/RcTools/reference/extract_ereefs.md)
  function

- SubSample:

  Numeric String. The number of values per day to plot in the dot plot.
  Defaults to 500 values per day.

- Heading:

  Character String. The heading of the plot. Defaults to NULL.

- YAxisName:

  Character String. The yaxis label text for the plot. Defaults to NULL
  and returns "value" in the plot.

- LogTransform:

  Boolean. Should the data be presented with a log transformation -
  useful for some variables such as Turbidity or Chlorophyll

- AttributeName:

  Character String. The name of the attribute to be used if several
  exist. Defaults to NULL

## Value

A single ggplot object that can be further transformed/edited/saved

## Examples

``` r
nc <- system.file("extdata/turb_reg.nc", package = "RcTools")
nc <- stars::read_mdim(nc)

x_plot <- ereefs_dotplot(
  nc = nc,
  YAxisName = "Turbidity (NTU)", 
  Heading = "Dry Tropics", 
  LogTransform = TRUE
)
```
