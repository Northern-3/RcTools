# Preprocess Digital Elevation Model data from AUSSEABED for the GBR

Preprocess Digital Elevation Model data from AUSSEABED for the GBR

## Usage

``` r
dem_pre_processing(RawPath, CropPath, OutputName, CropObj)
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

## Value

A saved .nc file, plus a netcdf object in the active session

## Examples

``` r
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

dme_cropped <- dem_pre_processing(raw_path, crop_path, "n3_dem_100m", n3_region)
#> Error: object 'raw_path' not found
 # \dontrun{}
```
