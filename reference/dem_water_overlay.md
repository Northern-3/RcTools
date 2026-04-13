# Create a river overlay for the area

Create a river overlay for the area

## Usage

``` r
dem_water_overlay(Lines, Polygons, Extent, MapArray)
```

## Arguments

- Lines:

  An sf object that defines the line waterbodies to be put onto the map
  (e.g. rivers)

- Polygons:

  An sf object that defines the polygon waterbodies to be put onto the
  map (e.g. lakes)

- Extent:

  An sf object that defines the full map boundaries

- MapArray:

  An array object created specifically by the 'dem_base_map()' function

## Value

The provided array object with waterbodies now embedded.

## Examples
