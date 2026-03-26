# Build the Sub Basins Within the Northern Three Region

Build the Sub Basins Within the Northern Three Region

## Usage

``` r
build_sub_basins(n3_land, basins, n3_marine)
```

## Arguments

- n3_land:

  An sf object produced within the
  [`build_n3_region()`](https://add-am.github.io/RcTools/reference/build_n3_region.md)
  function

- basins:

  An sf object produced by the
  [`build_basins()`](https://add-am.github.io/RcTools/reference/build_basins.md)
  function

- n3_marine:

  An sf object produced within the
  [`build_waterbody_boundaries()`](https://add-am.github.io/RcTools/reference/build_waterbody_boundaries.md)
  function

## Value

An sf object

## Examples

``` r
if (FALSE)  #dont run because function is not exported
n3_land <- build_sub_basins(n3_land, basins, n3_marine)
 # \dontrun{}
```
