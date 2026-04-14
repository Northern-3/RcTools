# Extract Land Use Data from a collection of Datasets on File

Extract Land Use Data from a collection of Datasets on File

## Usage

``` r
extract_land_use(RawPath, CroppedPath, CropObj)
```

## Arguments

- RawPath:

  Character String. A path arguement to the location where each full
  file should be retrived from.

- CroppedPath:

  Character String. A path arguement to the location where each cropped
  file should be saved and retrived.

- CropObj:

  Sf Object. An sf object used to define the area in which data is to be
  cropped to. Generally, the n3_region object from the
  [`build_n3_region()`](https://northern-3.github.io/RcTools/reference/build_n3_region.md)
  function is used.

## Value

A single sf object.

## Examples

``` r
if (FALSE)  #dont run because function takes a long time to process

p1 <- "path/to/folder/raw/"
p2 <- "path/to/folder/processed/"

n3_region <- build_n3_region()
#> Building Northern Three Basins...
#> Building Northern Three Islands...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Building Northern Three Marine Boundary...
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Warning: attribute variables are assumed to be spatially constant throughout all geometries
#> Creating Internal Marine Boundaries...
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

lu_data <- extract_land_use(p1, p2, n3_region)
#> Error: object 'p1' not found
 # \dontrun{}
```
