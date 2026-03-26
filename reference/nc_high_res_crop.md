# Crop A Raster and Increase its Resolution at the Same Time

Crop A Raster and Increase its Resolution at the Same Time

## Usage

``` r
nc_high_res_crop(nc, CropObj, DisaggFactor = 5)
```

## Arguments

- nc:

  A single NetCDF (stars) object, usually produced as part of the
  Climate workflow.

- CropObj:

  An sf object that defines the area in which data is to be cropped too.

- DisaggFactor:

  Numeric string. Defines the level of disaggregation to apply to the
  data (i.e. how many additional cells to create). Defaults to five,
  i.e. one cell will become five cells.

## Value

A singele NetCDF (stars) object.

## Examples

``` r
nc <- stars::read_mdim(system.file("extdata/turb_reg.nc", package = "RcTools"))
nc <- ereefs_reproject(nc)
#> threshold set to 1415.03 : set a larger value if you see missing values where there shouldn't be
area <- sf::st_read(system.file("extdata/example_box.gpkg", package = "RcTools"))
#> Reading layer `example_box' from data source 
#>   `/home/runner/work/_temp/Library/RcTools/extdata/example_box.gpkg' 
#>   using driver `GPKG'
#> Simple feature collection with 1 feature and 0 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 1517030 ymin: -2151353 xmax: 1619058 ymax: -2064030
#> Projected CRS: GDA94 / Australian Albers
area <- sf::st_transform(area, sf::st_crs(nc))

nc_high_res <- nc_high_res_crop(nc, area, 5)
#> Warning: no_data_value not set: missing values will appear as zero values
```
