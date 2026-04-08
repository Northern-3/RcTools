# Create the base map elements for a DEM map

Create the base map elements for a DEM map

Preprocess Digital Elevation Model data from AUSSEABED for the GBR

## Usage

``` r
dem_pre_processing(RawPath, CropPath, OutputName, CropObj, Reload, Overwrite)

dem_pre_processing(RawPath, CropPath, OutputName, CropObj, Reload, Overwrite)
```

## Arguments

- RawPath:

  The path to where to find the raw, unprocessed data

- CropPath:

  The path where the function should save the processed data

- OutputName:

  The name of the file when it is saved

- CropObj:

  The object to use for cropping the dataset

- Reload:

  Boolean. Do you want to try and reload a prior saved dataset with the
  same name? Defaults to TRUE.

- Overwrite:

  Boolean. Do you want to overwrite the previously saved dataset with
  the same name? Defaults to FALSE

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

A saved .nc file, plus a netcdf object in the active session

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

if (FALSE)  #dont run because function takes a long time

raw_path <- "path/to/raw folder/"
crop_path <- "path/to/crop folder/"
n3_region <- build_n3_region()
#> Building Northern Three Basins...
#> Registered S3 method overwritten by 'jsonify':
#>   method     from    
#>   print.json jsonlite
#> Building Northern Three Islands...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Building Northern Three Marine Boundary...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Creating Internal Marine Boundaries...
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE
#> Building Northern Three Sub Basins...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: repeating attributes for all sub-geometries for which they may not be constant
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Assigning Freshwater and Estuarine Zonations...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: x is already of type POLYGON.
#> Warning: repeating attributes for all sub-geometries for which they may not be constant
#> Warning: x is already of type POLYGON.
#> Warning: repeating attributes for all sub-geometries for which they may not be constant
#> Adding Special Land Features...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Adding Special Marine Features...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries

dem_cropped <- dem_pre_processing(raw_path, crop_path, "n3_dem_100m", n3_region, Reload = TRUE, Overwrite = FALSE)
#> Error: object 'raw_path' not found
 # \dontrun{}
```
