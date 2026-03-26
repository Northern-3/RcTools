# Extracting eReefs Data

Extracting eReefs Data

## Usage

``` r
extract_ereefs(
  Model = "catalog",
  Region,
  StartDate,
  EndDate,
  Variable,
  Downsample = 0
)
```

## Arguments

- Model:

  Character String. Describes the url of the model to use. Defaults to
  "catalog" and provides the user with options

- Region:

  SF Object. An sf object defining the area to extract data from

- StartDate:

  POSIX time. Supplied as a string in the format YYYY-MM-DD that defines
  the first day to extract data from

- EndDate:

  POSIX time. Supplied as a string in the format YYYY-MM-DD that defines
  the last day to extract data from

- Variable:

  Character Vector. The variable to extract from eReefs, currently
  accessible: "Turbidity", "Chlorophyll a", "DIN", "NH4", "NO3",
  "Secchi", "pH", "Wind", "True Colour"

- Downsample:

  Integer. A singular value that defines the level of downsampling to
  apply to the data (reduces data size and processing time, also reduces
  resolution)

## Value

A single NetCDF (stars) object of specified dimensions and attributes

## Examples

``` r
if (FALSE)  #dont run because function takes a while to execute and calls interactive component
sf_obj <- system.file("extdata/boundary.gpkg", package = "RcTools")
sf_obj <- sf::st_read(sf_obj)
#> Error: object 'sf_obj' not found

nc <- extract_ereefs(
  Region = sf_obj,
  StartDate = "2022-03-01",
  EndDate = "2022-03-03",
  Variable = "Turbidity",
  Downsample = 0
)
#> Error: object 'sf_obj' not found
 # \dontrun{}
```
