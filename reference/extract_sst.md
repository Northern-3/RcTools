# Extract Sea Surface Temperature Data from NOAA's API

Extract Sea Surface Temperature Data from NOAA's API

## Usage

``` r
extract_sst(RawPath, CroppedPath, CropObj)
```

## Arguments

- RawPath:

  Character String. A path arguement to the location where each full
  file should be saved and retrived.

- CroppedPath:

  Character String. A path arguement to the location where each cropped
  file should be saved and retrived.

- CropObj:

  Sf Object. An sf object used to define the area in which data is to be
  cropped to. Generally, the n3_region object from the
  [`build_n3_region()`](https://add-am.github.io/RcTools/reference/build_n3_region.md)
  function is used.

## Value

A stars netCDF object AND saves individual laers to file. (Note, this is
because each file can only be downloaded individually. If just the
single netCDF was returned, every layer would need to be re-downloaded
once a new layer is published. Instead, only the new layer is
downloaded, and the single netCDF is rebuilt locally).

## Examples

``` r
if (FALSE)  #dont run because function takes a long time to process

p1 <- "path/to/folder/raw/"
p2 <- "path/to/folder/processed/"

n3_region <- build_n3_region()
#> Building Northern Three Basins...
#> Error in x[[1]]: subscript out of bounds

sst_data <- extract_sst(p1, p2, n3_region)
#> Error: object 'p1' not found
 # \dontrun{}
```
