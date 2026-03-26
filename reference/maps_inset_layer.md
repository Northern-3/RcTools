# Create a Tmap Inset (corner) Map

Create a Tmap Inset (corner) Map

## Usage

``` r
maps_inset_layer(
  supplied_sf_1,
  background,
  aspect,
  use_bbox_1 = TRUE,
  supplied_sf_1_colour = "red",
  background_colour = "white",
  supplied_sf_2 = NULL,
  use_bbox_2 = TRUE,
  supplied_sf_2_colour = "blue"
)
```

## Arguments

- supplied_sf_1:

  Sf object. An sf object that defines the main area of interest.

- background:

  Sf object. An sf object that defines the greater region around the
  area of interest. For example if supplied_sf_1 is a collection of
  water quality samples, background would be the basin in which they
  were collected. This parameter also defines the zoom level of the map,
  i.e. the map size is adjusted to the scale of the object.

- aspect:

  Numeric String. A numeric value that describes the aspect ratio of the
  parent map. Suggest range between 0.8 and 1.2. This ensures correct
  positioning of the inset map.

- use_bbox_1:

  Boolean. Should a bounding box of the sf object be used (TRUE) or the
  actual outline of the sf object (FALSE). Deafults to TRUE.

- supplied_sf_1_colour:

  Character String. A character value that changes the colour of the
  supplied_sf_1 object. Defaults to red.

- background_colour:

  Character String. A character value that changes the colour of the
  background object. Defaults to white.

- supplied_sf_2:

  Sf object. An sf object. An sf object that defines the secondary area
  of interest. Defaults to NULL

- use_bbox_2:

  Boolean. Should a bounding box of the sf object be used (TRUE) or the
  actual outline of the sf object (FALSE). Deafults to TRUE.

- supplied_sf_2_colour:

  Character String. A character value that changes the colour of the
  supplied_sf_2 object. Defaults to blue.

## Value

A Tmap Object

## Examples

``` r
#load in required sf objects
sf_obj_1 <- sf::st_read(system.file("extdata/ross.gpkg", package = "RcTools"), quiet = TRUE)
sf_obj_2 <- sf::st_read(system.file("extdata/dry_tropics.gpkg", package = "RcTools"), quiet = TRUE)

example_inset <- maps_inset_layer(
 supplied_sf_1 = sf_obj_1, 
 background = sf_obj_2, 
 aspect = 1.1
)
```
