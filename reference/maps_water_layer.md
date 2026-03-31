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
#> Error in purrr::map(feature_list, function(x) {    layer_url <- glue::glue("https://spatial-gis.information.qld.gov.au/arcgis/rest/services/InlandWaters/WaterCoursesAndBodies/MapServer{x}")    if (x == "/33" & !is.null(StreamOrder)) {        final_query = glue::glue("{basin_query} AND {stream_query}")    }    else {        final_query = basin_query    }    layer <- arcgislayers::arc_open(layer_url)    water_data <- arcgislayers::arc_select(layer, where = final_query)    water_data <- dplyr::select(dplyr::mutate(water_data, ID = x,         Basin = drainage_basin), Basin, ID)    return(water_data)}): ℹ In index: 1.
#> Caused by error in `as_layer_class()`:
#> ! Failed to perform HTTP request.
#> Caused by error in `curl::curl_fetch_memory()`:
#> ! Timeout was reached [spatial-gis.information.qld.gov.au]:
#> SSL connection timeout
```
