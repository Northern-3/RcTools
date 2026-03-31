# Extract AIMS MMP Logger Data

Extract AIMS MMP Logger Data

## Usage

``` r
extract_logger(
  Years,
  Loggers,
  Indicators = c("chlorophyll", "turbidity"),
  FilterFlags = TRUE,
  FlagTags = c(1, 2),
  Aggregate = FALSE,
  AggregationType,
  SmallTables = FALSE,
  RowCount = 1500
)
```

## Arguments

- Years:

  Numeric Vector. The year(s) of data you want to access.

- Loggers:

  Character Vector. The name(s) of the logger(s) you want to access.

- Indicators:

  Character Vector. The name(s) of the indicators you want to access,
  can be Chlorophyll and/or Turbidity.

- FilterFlags:

  Boolean. Do you want to filter the data by its quality flags? This
  defaults to TRUE (yes).

- FlagTags:

  Numeric Vector. A vector of flag tags to keep, choices are: 0 =
  No_QC_performed, 1 = Good_data, 2 = Probably_good_data, 3 =
  Bad_data_that_are_potentially_correctable, 4 = Bad_data, 5 =
  Value_changed. Advice from data providers is to keep only tags 1
  and 2. By default only tags 1 and 2 are kept.

- Aggregate:

  Boolean. Do you want to aggregate data to daily values? This defaults
  to FALSE (no) and returns 10-minute interval data.

- AggregationType:

  Character String. Defines the type of aggregation to apply, one of:
  Hourly, or Daily

- SmallTables:

  Boolean. Do you want to return small tables (less than 1,500 rows per
  table). This defaults to FALSE (no)

- RowCount:

  Numeric String. The number of rows in each "small table", defaults to
  1500

## Value

A list of dataframes

## Examples

``` r
wq_data <- extract_logger(
Years = 2025, 
Loggers = "BUR2"
)
#> Error in purrr::pmap(target_matrix, function(Years, Loggers) {    catalogue_url <- glue::glue("https://thredds.aodn.org.au/thredds/catalog/AIMS/Marine_Monitoring_Program/FLNTU_timeseries/{Years}/catalog.xml")    catalogue <- xml2::read_html(catalogue_url)    nc_files <- xml2::xml_find_all(catalogue, ".//dataset")    file_names <- xml2::xml_attr(nc_files, "id")    logger_names <- stringr::str_extract_all(file_names, "_.{3,5}_(?=FV01)")    logger_names <- stringr::str_remove_all(unlist(logger_names),         "_")    logger_dates <- stringr::str_extract_all(file_names, "\\d{8}(?=Z)")    logger_dates <- stringr::str_remove_all(unlist(logger_dates),         "_")    logger_indicies <- which(logger_names %in% Loggers)    logger_dates <- logger_dates[logger_indicies]    all_data_one_year <- purrr::list_rbind(purrr::map(logger_dates,         function(date) {            completed_url <- glue::glue("https://thredds.aodn.org.au/thredds/dodsC/AIMS/Marine_Monitoring_Program/FLNTU_timeseries/{Years}/AIMS_MMP-WQ_KUZ_{date}Z_{Loggers}_FV01_timeSeries_FLNTU.nc")            nc <- ncdf4::nc_open(completed_url)            att_text <- ncdf4::ncatt_get(nc, 0, "acknowledgement")$value            log_serial <- nc$id            att_text <- stringr::str_extract(att_text, "(?<=\")([^\"]*)(?=\")")            variable_names <- names(nc$var)            dimension_names <- names(nc$dim)            vec_of_data_names <- stringr::str_replace(variable_names,                 "TIMESERIES", dimension_names)            target_data <- purrr::map(vec_of_data_names, function(x) ncdf4::ncvar_get(nc,                 x))            names(target_data) <- vec_of_data_names            time_vals <- target_data$TIME            time_origin <- lubridate::ymd_hms("1950-01-01 00:00:00",                 tz = "UTC")            time_vals <- time_origin + lubridate::ddays(time_vals)            time_vals <- time_vals + lubridate::hours(10)            simple_df <- data.frame(DateTime = time_vals, Result_Chlorophyll = target_data$CPHL,                 Flags_Chlorophyll = target_data$CPHL_quality_control,                 Result_Turbidity = target_data$TURB, Flags_Turbidity = target_data$TURB_quality_control,                 Latitude = target_data$LATITUDE, Longitude = target_data$LONGITUDE)            simple_df <- dplyr::mutate(simple_df, Logger = Loggers,                 Year = Years, Units_Chlorophyll = "mgm3", Units_Turbidity = "ntu")            pivot_df <- tidyr::pivot_longer(simple_df, cols = c(Result_Chlorophyll,                 Flags_Chlorophyll, Units_Chlorophyll, Result_Turbidity,                 Flags_Turbidity, Units_Turbidity), names_to = c(".value",                 "Indicator"), names_pattern = "(.*)_(.*)")            pivot_df <- tidyr::unite(pivot_df, "Indicator", c(Indicator,                 Units), sep = "_")            pivot_df <- dplyr::mutate(pivot_df, Attribution = att_text,                 SerialNumber = log_serial)            return(pivot_df)        }))}): ℹ In index: 1.
#> Caused by error in `open.connection()`:
#> ! cannot open the connection
```
