# Extract Habitat Data from Datasets on File

Extract Habitat Data from Datasets on File

## Usage

``` r
extract_habitat(RawPath, CropPath, CropObj, Habitat)
```

## Arguments

- RawPath:

  Character String. The path to where the full habitat files are found

- CropPath:

  Character String. The path to where the cropped files should be saved

- CropObj:

  Sf Object. The object to be used to crop the files.

- Habitat:

  Character String. Either 'RV' or 'MS' for Riparian Vegetation and
  Mangrove and Saltmarsh respectively. This tells the function what
  specific steps to take

## Value

A table object summarising areas and years. Also crops and saves spatial
data, and csv versions.

## Examples

``` r
if (FALSE)  #dont run because function takes a long time to process

p1 <- "path/to/folder/"
p2 <- "path/to/second_folder/"

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

all_data <- extract_habitat(p1, p2, n3_region, "RV")
#> Error: object 'p1' not found
 # \dontrun{}
```
