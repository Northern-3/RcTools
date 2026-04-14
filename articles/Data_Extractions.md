# Data Extractions

## Introduction

All Regional Report Cards use a variety of datasets to develop
contextual information as well as to calculate scores and grades. Within
the RcTools package, a range of data extraction functions and methods
have been provided. Some of these methods are entirely automated, whilst
others require the user to source raw datasets prior to running the
extraction code. In all cases, the functions require user inputs. The
following data extraction functions are provided:

- extract_air_temp
- extract_dhw
- extract_ereefs
- extract_habitat
- extract_land_use
- extract_logger
- extract_rainfall
- extract_sst
- extract_watercourses

The motivation and use cases behind each are explained below:

### extract_air_temp

This function relies on paid datasets that have been purchased from BOM.
To obtain these datasets refer the the Dry Tropics technical team.

The function requires three inputs:

1.  Where to find the min temperature raw data
2.  Where to find the max temperature raw data
3.  The object to crop the data with

It is generally advised that you provide the n3_region() dataset
produced by the \[build_n3_region()\] function as the cropping object.
Function usage can be defined as follows:

``` r
library(RcTools)
```

``` r
#create a path to the raw min and max temperature folders
min_tmp <- here("data/raw/tmin2")
max_tmp <- here("data/raw/tmax2")

#use custom extraction function to process data
n3_temp <- extract_air_temp(n3_region, min_tmp, max_tmp)
```

it is important to note that as of 27/03/20206, the output folders are
build automatically. Further, the construction of these folders relies
on the raw data path including the string “raw” and replacing it with
“processed”. This is an outdated methodology that should be updated when
possible.

This function is exclusively used with the climate_air_temperature
script and has been written such that the climate_air_temperature script
can be run automatically. Please note that the output of this function
is a list of netCDF STARS files. Further reading on STARS files can be
found at [R
Stars](https://northern-3.github.io/RcTools/articles/)<https://r-spatial.github.io/stars/>

### extract_dhw

This function is entirely automated and thus its documentation is
minimal. It extracts degree heating week data from [NOAA’s](NA) API. The
function requires three inputs:

1.  Where to save the raw data
2.  Where to save the cropped data
3.  The object to crop the data with

It is generally advised that you provide the n3_region() dataset
produced by the \[build_n3_region()\] function as the cropping object.
Function usage can be defined as follows:

``` r
#define the place where full files should be saved
full_file_loc <- here("data/raw/")

#define the place where cropped files should be saved
cropped_file_loc <- here("data/processed/")

#download, save, crop, and build the data
n3_dhw <- extract_dhw(full_file_loc, cropped_file_loc, n3_region)
```

This function is exclusively used with the climate_dhw script and has
been written such that the climate_dhw script can be run automatically.
Please note that the output of this function is a list of netCDF STARS
files. Further reading on STARS files can be found at [R
Stars](https://northern-3.github.io/RcTools/articles/)<https://r-spatial.github.io/stars/>

### extract_ereefs

This function is the core function required for the entire eReefs
workflow. The explaination of its usage can be found under the eReefs
vignette.

### extract_habitat

This function relies on data that has been **manually downloaded** from
the [Biodiversity status of pre-clearing and 2021 remnant regional
ecosystems - Queensland
series](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7B01972496-CD6D-4314-B0C0-DA0E0421FB0A%7D).
Refer to the RcHabitat repository for further information on sourcing
and saving data. This function requires four inputs:

1.  Where to save the raw data
2.  Where to save the cropped data
3.  The object to crop the data with
4.  The type of data to extract

Currently, there are only two types of data to extract. The usage of the
function is as follows:

``` r
#point to where the raw data is
raw_data_path <- here("data/habitat/")

#point to where the cropped data should be saved
cropped_data_path <- here("data/mangroves_and_saltmarsh/")

#run the function
all_data <- extract_habitat(
  raw_data_path, cropped_data_path, est_region, "MS")

#alternatively, riparian data can be extracted
cropped_data_path_2 <- here("data/riparian/")

#run the function
all_data <- extract_habitat(
  raw_data_path, cropped_data_path, n3_riparian_boundaries, "RV")
```

### extract_land_use

This function relies on data that has been **manually downloaded** from
the [Land use mapping
series](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7BBE30CE16-B1B9-48B1-BF21-DBE70597FA93%7D).
Refer to the RcClimate repository for further information on sourcing
and saving data. This function requires three inputs:

1.  Where to save the raw data
2.  Where to save the cropped data
3.  The object to crop the data with

The usage of the function is as follows:

``` r
#build path to the raw data
raw_data_path <- here("data/raw/")

#build path to where cropped datasets should be saved
cropped_data_path <- here("data/processed/")

#run custom function
n3_land <- extract_land_use(raw_data_path, cropped_data_path, n3_sub_basins)
```

### extract_logger

This function extracts logger dataset from the THREDDS AODN servers.
Currently it has been put in place to bridge the gap between manually
requesting data from AIMS and the eventual front-end storage of data on
the AODN servers. It is possible that this function will be retired but
for the time being it is actively in use.

Basic usage of the function is as follows:

``` r
#load the library
library(RcLoggers)

#run the function (basic)
data_extract <- logger_extract(
 Years = 2025, 
 Loggers = "BUR2"
)
```

Where only the year(s) of data required, and the name(s) of loggers
requested need to be provided to the function. However, this function
does have some more advanced options, which are explained below:

``` r
#run the function (detailed)
data_extract <- logger_extract(
 Years = c(2024, 2025), #you can dowload more than one year
 Loggers = c("BUR1", "BUR2"), #you can download more than one logger
 Indicators = "Chlorophyll", # if you only want one indicator you can define that (it defaults to chlorophyll and turbidity)
 FilterFlags = TRUE, #filtering occurs by default, however you can customise or stop filtering
 FlagTags = c(1,2), #by default flags 1 and 2 are kept, you can adjust this as needed
 Aggregate = TRUE, #you can aggregate data
 AggregationType = "Hourly" #if you do decide to aggregate, you need to define the type of aggregation (hourly or daily)
 SmallTables = TRUE #you can request that outputs are broken into several small tables 
 RowCount = 1500 #if you do want to break up tables, you can define the number of rows per table
)
```

The output of the function (regardless of if small tables is true or
false) is a list of dataframes. The reason for outputs to be provided as
a list is to streamline further data processing steps. Each item in the
list is assigned an appropriate name. This allows the list of dataframes
to be saved using the following code:

``` r
#save
purrr::walk2(
  data_extract, 
  names(data_extract), 
  ~readr::write_csv(.x, paste0(.y, ".csv"))
  )
```

However, should `SmallTables = TRUE` it is reccomended that files are
saved within broader folders based on logger and year using the
following code:

``` r
purrr::walk2(data_extract, names(data_extract), ~{

  #create a folder name based on the first two elements of the dataframe name
  folder_name <- paste(
    stringr::str_split(.y, pattern = "_")[[1]][1:2], 
    collapse = "_")

  #if you want to expand/move where the folder is located, do that here:
  # folder_name <- paste0("path_to_location/", folder_name)

  #if the folder doesnt already exist, create it
  if (!dir.exists(folder_name)){dir.create(folder_name, recursive = TRUE)}

  #save the dataframe inside the associated folder
  readr::write_csv(.x, paste0(folder_name, "/", .y, ".csv"))

  }
)
```

This fuction is a utility function that can, and is, used in a variety
of places. Generally the workflow of this function is purely to download
and save data to a local machine. Further steps such as loading the
files into a database or copying data into a master spreadsheet are
often done outside of the R ecosystem. It is possible to integrate this
function into an R workflow, however none currently rely on the
function.

### extract_rainfall

This function is entirely automated and thus its documentation is
minimal. It extracts rainfall from the [Australia Water Outlook
(BOM)](https://awo.bom.gov.au/) exclusively within the N3 region. The
function only requires one input (where to save the data), and its usage
can be easily defined as follows:

``` r
#define the path and name of the dataset to be saved on file (or read back in)
data_name <- here("data/n3_rainfall.nc")

#if the data is on file, load it, otherwise built it and save it for next time
if (file.exists(data_name)){
  n3_rain <- read_stars(data_name)
} else {
  n3_rain <- extract_rainfall(n3_region)
  write_mdim(n3_rain, data_name)
}
```

This function is exclusively used with the climate_rainfall script and
has been written such that the climate_rainfall script can be run
automatically. Please note that the output of this function is a netCDF
STARS file. Further reading on STARS files can be found at [R
Stars](https://northern-3.github.io/RcTools/articles/)<https://r-spatial.github.io/stars/>

### extract_sst

This function is entirely automated and thus its documentation is
minimal. It extracts sea surface temperature from [NOAA’s](NA) API. The
function requires three inputs:

1.  Where to save the raw data
2.  Where to save the cropped data
3.  The object to crop the data with

It is generally advised that you provide the n3_region() dataset
produced by the \[build_n3_region()\] function as the cropping object.
Function usage can be defined as follows:

``` r
#define the place where full files should be saved
full_file_loc <- here("data/raw/")

#define the place where cropped files should be saved
cropped_file_loc <- here("data/processed/")

#download, save, crop, and build the data
n3_sst <- extract_sst(full_file_loc, cropped_file_loc, n3_region)
```

This function is exclusively used with the climate_sst script and has
been written such that the climate_sst script can be run automatically.
Please note that the output of this function is a list of netCDF STARS
files. Further reading on STARS files can be found at [R
Stars](https://northern-3.github.io/RcTools/articles/)<https://r-spatial.github.io/stars/>

### extract_watercourses

This function automatically extracts waterbody information from the
[Hydrographic features - Queensland
series](https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid=%7B9D9CBCDA-6D4A-49AC-B993-AEF00B2D16F9%7D)
on QSpatial.

At a basic level the function only requires one input: “Basin”. The
function allows the user to select from all available basins within
Queensland, if you function selection is invalid it will provide a
vector of valid inputs to choose from. Basic usage of the function is as
follows:

``` r
ross_and_black <- extract_watercourses(Basin = c("Black", "Ross"))
 
```

However, in this case several assumptions are made. Below, each optional
input is explained:

``` r
data_extract <- extract_watercourses(
  Basin = c("Black", "Ross"), #pick one or several basins
  WaterLines = TRUE, #by default only water lines are returned
  WaterAreas = FALSE,  #you can request to include water areas (such as wetlands and unnamed lakes)
  WaterLakes = FALSE,  #you can request to include large, named, lakes
  StreamOrder = c(1,2) #by default all streamorders are returned. However you can provide either a lower bound, or an upper and lower bound for stream orders to return
)
```

This function is used in several places. Most notably in:

1.  The creation of waterlayers for maps, and
2.  The creation of the riparian boundaries dataset
