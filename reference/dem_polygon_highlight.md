# Create the base map elements for a DEM map

Create the base map elements for a DEM map

## Usage

``` r
dem_polygon_highlight(Highlight, Extent, MapArray)
```

## Arguments

- Highlight:

  An sf object that defines the area of interest. Must be within map
  boundaries

- Extent:

  An sf object, bbox object, or SpatExtent that defines the full map
  boundaries

- MapArray:

  An array object created specifically by the 'dem_base_map()' function

## Value

The provided array object with highlights now embedded.

## Examples

``` r
if (FALSE)  #dont run because function takes a long time

maggie <- build_n3_region() |> 
    filter(SubBasinOrSubZone == "Magnetic Island")

map_ext <- ext(my_spat_raster)
#> Error in ext(my_spat_raster): could not find function "ext"

map_array <- dem_base_map(...)
#> Error: '...' used in an incorrect context

dem_cropped <- dem_polygon_highlight(
  Highlight = maggie,
  Extent = map_ext,
  MapArray = map_array
)
#> Error: object 'maggie' not found
 # \dontrun{}
```
