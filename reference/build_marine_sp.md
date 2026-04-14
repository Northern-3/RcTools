# Apply Special Transformations to the n3_marine Dataset

Apply Special Transformations to the n3_marine Dataset

## Usage

``` r
build_marine_sp(n3_marine, n3_land)
```

## Arguments

- n3_marine:

  An sf object produced within the
  [`build_waterbody_boundaries()`](https://northern-3.github.io/RcTools/reference/build_waterbody_boundaries.md)
  function

- n3_land:

  An sf object produced within the
  [`build_n3_region()`](https://northern-3.github.io/RcTools/reference/build_n3_region.md)
  function

## Value

An sf object

## Examples

``` r
if (FALSE)  #dont run because function is not exported
n3_marine <- build_marine_sp(n3_marine, n3_land)
 # \dontrun{}
```
