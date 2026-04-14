# Create a river overlay for the area

Create a river overlay for the area

## Usage

``` r
dem_water_overlay(
  Lines,
  Polygons = NULL,
  Extent,
  MapArray,
  MapMatrix,
  Crs = "EPSG:4326"
)
```

## Arguments

- Lines:

  An sf object that defines the line waterbodies to be put onto the map
  (e.g. rivers)

- Polygons:

  An sf object that defines the polygon waterbodies to be put onto the
  map (e.g. lakes). Optional

- Extent:

  An sf object that defines the full map boundaries

- MapArray:

  An array object created specifically by the 'dem_base_map()' function

- MapMatrix:

  A matrix object created specifically by the 'dem_base_map()' function

- Crs:

  A character string that describes the cooridnate reference system to
  use. Defaults to "EPSG:4326"

## Value

The provided array object with waterbodies now embedded.

## Examples

``` r
if (FALSE)  #dont run because function takes a long time

ross_waters <- extract_watercourses("Ross", WaterAreas = TRUE, WaterLakes = TRUE, StreamOrder = 2)

map_ext <- ext(my_spat_raster)
#> Error in ext(my_spat_raster): could not find function "ext"

map_array <- dem_base_map(...)
#> Error: '...' used in an incorrect context
map_matrix <- dem_base_map(...)
#> Error: '...' used in an incorrect context

dem_cropped <- dem_water_overlay(
  Lines = ross_waters,
  Polygons = ross_waters,
  Extent = map_ext,
  MapArray = map_array,
  MapMatrix = map_matrix
)
#> Error: object 'ross_waters' not found
 # \dontrun{}
```
