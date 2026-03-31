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
#> Error in x[[1]]: subscript out of bounds

all_data <- extract_habitat(p1, p2, n3_region, "RV")
#> Error: object 'p1' not found
 # \dontrun{}
```
