# Create the base map elements for a DEM map

Create the base map elements for a DEM map

## Usage

``` r
dem_base_map(
  sr,
  Resolution,
  OutputPath,
  FileName,
  Reload = TRUE,
  Overwrite = TRUE,
  Texture = "Desert",
  Zscale = NULL,
  SeaLevel = 0
)
```

## Arguments

- sr:

  A SpatRaster object, generally produced by the dem_pre_processing()
  function.

- Resolution:

  A numeric vector, either 30 or 100. This should match the resolution
  of the sr object provided.

- OutputPath:

  A character vector that defines the path to the folder where the
  outputs should be saved

- FileName:

  A character vector that uniquely identifies the outputs. Do not
  include a file type

- Reload:

  Boolean. Do you want to try and reload a prior saved dataset with the
  same name? Defaults to TRUE.

- Overwrite:

  Boolean. Do you want to overwrite the previously saved dataset with
  the same name? Defaults to FALSE

- Texture:

  A character vector. Describes the colour palette to use. One of:
  “imhof1”, “imhof2”, “imhof3”, “imhof4”, “desert”, “bw”, “unicorn”.

- Zscale:

  A numeric vector. Defines ratio between x and y spacing. Defaults to
  Resolution input (realistic). Decrease Zscale to exagerate heights

- SeaLevel:

  A numeric vector. Defines the elevation of sea level. Defaults to 0m.
  Decrease or increse to simulate various sea levels.

## Value

A matrix object and an array object. Both are saved to the path
specified and returned to the active environment

## Examples

``` r
if (FALSE)  #dont run because function takes a long time

dem_cropped <- dem_base_map(
  sr = my_spat_raster,
  Resolution = 30,
  OutputPath = "path/to/output folder/",
  FileNmae = "my_file",
  Reload = FALSE,
  Overwrite = FALSE,
  Texture = "Desert",
  Zscale = 30,
  SeaLevel = 0
)
 # \dontrun{}
```
