# Check if object is Stars or list of Stars, Convert if List

Check if object is Stars or list of Stars, Convert if List

## Usage

``` r
ereefs_list_safety_check_and_convert(nc)
```

## Arguments

- nc:

  A list of NetCDF (stars) objects, generally produced by the
  [`extract_ereefs()`](https://add-am.github.io/RcTools/reference/extract_ereefs.md)
  function

## Value

A single NetCDF (stars) object combined on the time dimension

## Examples

``` r
if (FALSE)  #dont run because function is not exported
ereefs_list_safety_check_and_convert("Turbidity")
 # \dontrun{}
```
