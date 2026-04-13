# Create the base map elements for a DEM map

Create the base map elements for a DEM map

## Usage

``` r
dem_base_map(
  sr,
  OutputPath,
  FileName,
  Zscale,
  CropObj = NULL,
  Reload = TRUE,
  Overwrite = TRUE,
  Texture = "Desert",
  SeaLevel = 0,
  Crs = "EPSG:7844"
)
```

## Arguments

- sr:

  A SpatRaster object, generally produced by the dem_pre_processing()
  function.

- OutputPath:

  A character vector that defines the path to the folder where the
  outputs should be saved

- FileName:

  A character vector that uniquely identifies the outputs. Do not
  include a file type

- Zscale:

  A numeric vector. Defines ratio between x and y spacing. Defaults to
  Resolution input (realistic). Decrease Zscale to exagerate heights

- CropObj:

  A sf object. This is optionally used to further crop the data to a
  specific location

- Reload:

  Boolean. Do you want to try and reload a prior saved dataset with the
  same name? Defaults to TRUE.

- Overwrite:

  Boolean. Do you want to overwrite the previously saved dataset with
  the same name? Defaults to FALSE

- Texture:

  A character vector. Describes the colour palette to use. One of:
  “imhof1”, “imhof2”, “imhof3”, “imhof4”, “desert”, “bw”, “unicorn”.

- SeaLevel:

  A numeric vector. Defines the elevation of sea level. Defaults to 0m.
  Decrease or increse to simulate various sea levels.

## Value

A matrix object and an array object. Both are saved to the path
specified and returned to the active environment

## Examples

``` r
if (FALSE)  #dont run because function takes a long time

ross <- build_n3_region() |> 
  filter(BasinOrZone == "Ross")

dem_cropped <- dem_base_map(
  sr = my_spat_raster,
  OutputPath = "path/to/output folder/",
  FileName = "my_file",
  Zscale = 30,
  CropObj = ross,
  Reload = FALSE,
  Overwrite = FALSE,
  Texture = "Desert",
  SeaLevel = 0
)
#> Error: object 'my_spat_raster' not found
 # \dontrun{}
```
