# Create a Windrose Plot from eReefs Data

Create a Windrose Plot from eReefs Data

## Usage

``` r
ereefs_windrose(
  nc,
  SubSample = 500,
  Aggregation = "Month",
  Heading = "Approximated Wind Speed",
  LegendTitle = "Speed (km/h)"
)
```

## Arguments

- nc:

  A single NetCDF (stars) object OR a list of NetCDF (stars) objects,
  generally produced by the
  [`extract_ereefs()`](https://northern-3.github.io/RcTools/reference/extract_ereefs.md)
  function

- SubSample:

  Numeric String. The number of values per day to plot in the wind rose.
  Defaults to 500 values per day.

- Aggregation:

  Character String. What type of grouping to apply to the data. Defaults
  to "Month". Options are "Month", "Season", "Financial", "Annual"

- Heading:

  Character String. The heading of the plot. Defaults to "Approximated
  Wind Speed".

- LegendTitle:

  Character String. The title of the legend. Defaults to "Speed (km/h)".

## Value

A ggplot2 object (a windrose plot)

## Examples

``` r
nc <- system.file("extdata/wind_reg.nc", package = "RcTools")
nc <- stars::read_mdim(nc)

wr_plot <- ereefs_windrose(nc)
```
