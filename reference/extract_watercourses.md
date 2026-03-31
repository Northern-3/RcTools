# Extract Watercourses

Extract Watercourses

## Usage

``` r
extract_watercourses(
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

A sf object

## Examples

``` r
ross_and_black <- extract_watercourses(Basin = c("Black", "Ross"))
#> [working] (0 + 0) -> 9 -> 1 | ■■■■                              10%
#> [working] (0 + 0) -> 8 -> 2 | ■■■■■■■                           20%
#> [working] (0 + 0) -> 0 -> 10 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100%
#> Error in purrr::map(feature_list, function(x) {    layer_url <- glue::glue("https://spatial-gis.information.qld.gov.au/arcgis/rest/services/InlandWaters/WaterCoursesAndBodies/MapServer{x}")    if (x == "/33" & !is.null(StreamOrder)) {        final_query = glue::glue("{basin_query} AND {stream_query}")    }    else {        final_query = basin_query    }    layer <- arcgislayers::arc_open(layer_url)    water_data <- arcgislayers::arc_select(layer, where = final_query)    water_data <- dplyr::select(dplyr::mutate(water_data, ID = x,         Basin = drainage_basin), Basin, ID)    return(water_data)}): ℹ In index: 1.
#> Caused by error in `x[[i]]`:
#> ! subscript out of bounds
```
