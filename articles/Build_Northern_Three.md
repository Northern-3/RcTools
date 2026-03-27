# Building The Northern Three Spatial File

## Introduction

Across all three Regional Report Cards spatial context is required, and
spatial files are used. These files are used for a range of purposes
including:

1.  Defining Region, Basin, and Environment boundaries
2.  Identifying relevant Water Quality Objectives based on site
    locations
3.  Creating site maps for each index
4.  Extracting datasets within the bounds of the reporting region
5.  Calculating location sizes
6.  etc.

Thus, in almost any case of R analysis, the “Northern Three boundaries
dataset” (herein referred to as “n3_region”) is a key requirement.

The purpose of the following functions is to automate and standardise
the construction of the n3_region dataset such that all analyses
conducted by all users refer to the same underlying dataset. This
vignette walks through the steps required to obtain the n3_region
dataset, as well as the method used to build the dataset.

## build_n3_region

The key function to obtain the n3_region dataset is the
\[build_n3_region()\] function. This function internally calls and runs
all other “build” functions. At a high level, this is the only function
you need to be concerned with.

The recommended method for running this function in your code is as
follows:

``` r
#define where you want the dataset to be saved in your file system
file_loc <- here("data/n3_region.gpkg")

#check the location provided.
if (file.exists(file_loc)){
  #if the data is there, open the file
  n3_region <- sf::st_read(file_loc)
} else {
  #if the data is not on file, build it and save it for next time
  n3_region <- build_n3_region()
  sf::st_write(n3_region, file_loc)
}
```

**Note that there are no user inputs required.**

### Internal Components

Should you be interested in the internal components of the
\[build_n3_region()\] function, such as where the data is source from,
or you have found an error and/or want to update the function, the below
section covers this in more detail.

\[build_n3_region()\] is comprised of 8 internal functions:

- \[build_basins()\]
- \[(build_named_islands)\]
- \[(build_waterbodies)\]
- \[(build_waterbody_boundaries)\]
- \[(build_sub_basins)\]
- \[(build_water_types)\]
- \[(build_land_sp)\]
- \[(build_marine_sp)\]

#### build_basins

This function automatically extracts the following basins from [Drainage
Basins -
Queensland](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7BF79B22E5-7BD4-44AF-98EB-AC1A46513EDD%7D)
on Qspatial:

- Black, Ross
- Burdekin, Haughton
- Barron, Daintree, Herbert, Johnstone, Mossman, Murray, Tully, Russell,
  Mulgrave
- Don, O’Connell, Pioneer, Plane, Proserpine

The dataset is cleaned and organised, and the appropriate N3 region is
assigned to each basin.

#### build_named_islands

This function extracts all named islands from with the [GISAIMSR R
package](https://open-aims.github.io/gisaimsr/articles/examples.html),
specifically from the gbr_feat dataset.

For each island the function assess the closest mainland region and the
closet mainland basin and assigns this to the island’s metadata. For
example, Magnetic Island is closest to the Ross Basin, and thus the
polygon representing Magnetic Island retains its name (Magnetic Island),
and gains the basin Ross, and the region Dry Tropics.

Named islands that are outside the boundaries of the N3 region are
discarged, islands that overlap the mainland (such as sand islands
present in river mouths) are discarded.

#### build_waterbodies

This function extracts all waterbodies from with the [GISAIMSR R
package](https://open-aims.github.io/gisaimsr/articles/examples.html),
specifically from the wbodies dataset. This dataset is the source of the
“Enclosed Coastal”, “Open Coastal”, and “Offshore” boundaries.

This data is buffered and cropped to fit perfectly against the mainland.
The data then has holes cut into it based on the islands obtained above.
The regions and “zones” (defined as the same level as a basin) are not
yet defined in this function. However the “sub zone” (defined as the
same level as a sub basin) is defined inherintly within the data. These
are the “Enclosed Coastal”, “Open Coastal”, definitions.

#### build_waterbody_boundaries

This function is a **hardcoded** delineation of the N3 marine region
boundaries. Several border lines were **manually** created. The
waterbodies dataset is then cut into multiple pieces, and each peice is
**manually** assigned the appropriate region and zone.

It is very important to understand that there is no online equivalent to
these hardcoded delineations. While some are based on boundaries found
in other documents such as EPP WQ guideline documents, others are hand
drawn and created by the report card’s individual technical team. Should
these hard coded numbers be lost, this function and the data it uses
would need to be rebuilt from scratch.

#### build_sub_basins

This function relies on data that has been manually extracted from
[Environmental Protection (Water and Wetland Biodiversity) Policy 2019 -
Environmental Value Zones -
Queensland](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7BF9713089-2799-4C96-BD9E-E9E2C5FF01E8%7D)
on Qspatial.

A subset of the data is small enough that it has been saved as a data
file within this R package. There is no need to manually retrieve the
dataset again unless this stored file is lost. Within the function the
appropriate pre-cleaning steps are listed.

This functions creates the required Dry Tropics and Burdekin sub basins
based on environmental value zones. These sub basins are a custom
combination of environmental value zones. The sub basins are nested
within the relevant basins, and a buffer-cut is used to ensure no gaps
are created.

#### build_water_types

This function relies on data that has been manually extracted from
[Environmental Protection (Water and Wetland Biodiversity) Policy 2019 -
Water Types -
Queensland](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7B538A8977-70FD-4612-A043-FE789F1C31D7%7D)
on Qspatial.

A subset of the data is small enough that it has been saved as a data
file within this R package. There is no need to manually retrieve the
dataset again unless this stored file is lost. Within the function the
appropriate pre-cleaning steps are listed.

This function assigns the freshwater and estuarine boundaries. It
intersections across the entire N3 region to assign these labels. At
this point each polygon (row of data) has been assigned a region,
basin/zone, sub_basin/sub_zone, and an environment.

#### build_land_sp

This function relies on data that has been manually extracted from
[Environmental Protection (Water and Wetland Biodiversity) Policy 2019 -
Environmental Value Zones -
Queensland](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7BF9713089-2799-4C96-BD9E-E9E2C5FF01E8%7D)
on Qspatial.

A subset of the data is small enough that it has been saved as a data
file within this R package. There is no need to manually retrieve the
dataset again unless this stored file is lost. Within the function the
appropriate pre-cleaning steps are listed.

This function create small, special features within the **land** portion
Dry Tropics region, such as the boundary of the Palumna Dam/Lake sub
basin. Should you wish to add further customisation to the land portion
of the \[build_n3_region()\] function, this would be the place to
include it.

#### build_marine_sp

This function relies on data that has been manually extracted from
[Environmental Protection (Water and Wetland Biodiversity) Policy 2019 -
Management Intent -
Queensland](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7BDB9A289C-8DD5-4F97-A61C-C452F2AF78F8%7D)
on Qspatial.

A subset of the data is small enough that it has been saved as a data
file within this R package. There is no need to manually retrieve the
dataset again unless this stored file is lost. Within the function the
appropriate pre-cleaning steps are listed.

This function create small, special features within the **marine** Dry
Tropics region, such as the the special marine zone around Magnetic
Island and the Port of Townsville. Should you wish to add further
customisation to the marine portion of the \[build_n3_region()\]
function, this would be the place to include it.

``` r
library(RcTools)
```
