# Mapping eReefs Data

Mapping eReefs Data

## Usage

``` r
ereefs_map(
  nc,
  MapType,
  Aggregation = "Month",
  LegendTitle = NULL,
  LogScale = FALSE,
  nrow = NULL
)
```

## Arguments

- nc:

  A single NetCDF (stars) object OR a list of NetCDF (stars) objects,
  generally produced by the
  [`extract_ereefs()`](https://add-am.github.io/RcTools/reference/extract_ereefs.md)
  function

- MapType:

  Character String. Defines the type of map produced. One of
  "Concentration", "True Colour", or "Vector Field" (AKA wind)

- Aggregation:

  Character String. Defines the level of aggregation to apply. Defaults
  to "Month". Options are "Month", "Season", "Financial", "Annual"

- LegendTitle:

  Character String. The title of the legend. Defaults to the name of the
  netCDF's attribute

- LogScale:

  Boolean. Do you want data to be displayed on a log scale?

- nrow:

  Numeric String. The number of rows to be used when facetting maps.
  Defaults to NULL and uses underlying default value

## Value

A tmap object

## Examples

``` r
nc <- system.file("extdata/turb_reg.nc", package = "RcTools")
nc <- stars::read_mdim(nc)

m <- ereefs_map(
  nc = nc,
  MapType = "Concentration",
  Aggregation = "Annual"
)
```
