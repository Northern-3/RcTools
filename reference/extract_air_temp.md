# Extract, Crop, and Combine Air Temperature Data

Extract, Crop, and Combine Air Temperature Data

## Usage

``` r
extract_air_temp(MinPath, MaxPath, CropObj)
```

## Arguments

- MinPath:

  A character string. Defines the full path to the folder in which all
  min temp sub folders are stored. Generally this will be
  user/.../.../raw/tmin2/

- MaxPath:

  A character string. Defines the full path to the folder in which all
  max temp sub folders are stored. Generally this will be
  user/.../.../raw/tmax2/

- CropObj:

  Sf Object. An sf object used to define the area in which data is to be
  cropped to. Generally, the n3_region object from the
  [`build_n3_region()`](https://add-am.github.io/RcTools/reference/build_n3_region.md)
  function is used.

## Value

A list of three netCDF objects. Specifically a min temp, max temp, and
mean temp netCDF

## Examples

``` r
if (FALSE)  #dont run because function takes a while

min_path <- "C:/Users/path/to/data/raw/tmin2"
max_path <- "C:/Users/path/to/data/raw/tmax2"

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

nc <- extract_air_temp(n3_region, min_path, max_path)
#> Error in extract_air_temp(n3_region, min_path, max_path): You must supply an sf object to the 'CropObj' parameter

 # \dontrun{}
```
