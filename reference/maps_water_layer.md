# Create a Tmap Water Layer

Create a Tmap Water Layer

## Usage

``` r
maps_water_layer(
  Basin,
  WaterLines = TRUE,
  WaterAreas = FALSE,
  WaterLakes = FALSE,
  StreamOrder = NULL
)
```

## Arguments

- Basin:

  Character Vector. Defines the area in which the water layer should be
  created.

- WaterLines:

  Boolean. Should water lines be included in the map layer? Defaults to
  TRUE.

- WaterAreas:

  Boolean. Should water areas be included in the map layer? Defaults to
  TRUE.

- WaterLakes:

  Boolean. Should lakes be included in the map layer? Defaults to TRUE.

- StreamOrder:

  Numeric Vector of length 1 or 2. Defines the minimum, or minimum and
  maximum, stream order to filter the WaterLines paramter by. Where 1 =
  the smallest streams and increasing numbers correspond to increasing
  stream sizes. Defaults to NULL (all).

## Value

A Tmap Object

## Examples

``` r
ross_and_black <- maps_water_layer(Basin = c("Black", "Ross"))
#> [working] (0 + 0) -> 9 -> 1 | ■■■■                              10%
#> [working] (0 + 0) -> 1 -> 9 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■      90%
#> [working] (0 + 0) -> 0 -> 10 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100%
```
