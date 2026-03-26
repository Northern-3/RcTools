# Compare how a dataset changes over time

Compare how a dataset changes over time

## Usage

``` r
sf_change_over_time(sf, Col, StartYear, EndYear, Resolution = 1000)
```

## Arguments

- sf:

  An sf object. Generally the object should contain polygons geometries,
  and must contain at least 2 years of data.

- Col:

  Character string. The name of the column from which to extract
  information about the geometry

- StartYear:

  Numeric string. The first year of data to use. Must exist within the
  sf object.

- EndYear:

  Numeric string. The second year of data to use. Must exist within the
  sf object.

- Resolution:

  Numeric string. The number of grid cells to create along the x and y
  planes - will for a square grid. Defaults to 1000

## Value

An sf object

## Examples

``` r
polygons <- list(
  rbind(c(0,0), c(1,0), c(1,1), c(0,1), c(0,0)), 
  rbind(c(1,0), c(2,0), c(2,1), c(1,1), c(1,0)),
  rbind(c(0,1), c(1,1), c(1,2), c(0,2), c(0,1)),
  rbind(c(1,1), c(2,1), c(2,2), c(1,2), c(1,1)))

polygons <- sf::st_sfc(lapply(polygons, function(x) sf::st_polygon(list(x))))

poly_sf <- dplyr::bind_rows(
  sf::st_sf(Year = 2000, Id = c("a", "b", "c", "d"), geometry = polygons, crs = 4326), 
  sf::st_sf(Year = 2020, Id = rep("a",4), geometry = polygons, crs = 4326))

change <- sf_change_over_time(poly_sf, "Id", 2000, 2020)
#> Warning: x is already of type POLYGON.
#> Joining with `by = join_by(PreValue)`
#> Joining with `by = join_by(PostValue)`

tmap::tm_shape(change) + tmap::tm_polygons(fill = "ValueChange")

```
