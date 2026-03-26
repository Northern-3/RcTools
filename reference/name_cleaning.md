# A Name Cleaning Function for N3 Tables

A Name Cleaning Function for N3 Tables

## Usage

``` r
name_cleaning(df)
```

## Arguments

- df:

  Adf object of any dimensions. With or without a geometry column

## Value

A df object of the same dimensions as input

## Examples

``` r
df <- data.frame(
  "Column 1" = c(1,2,3),
  "column-2" = c(1,2,3),
  "COLUMN    3" = c(1,2,3)
)
df <- name_cleaning(df)
```
