#' Preprocess Digital Elevation Model data from AUSSEABED for the GBR
#'
#' @param RawPath The path to where to find the raw, unprocessed data
#' @param CropPath The path where the function should save the processed data
#' @param OutputName The name of the file when it is saved
#' @param CropObj The object to use for cropping the dataset
#' @param Overwrite Boolean. Do you want to overwrite the previously saved dataset with the same name? If FALSE function will reload data 
#' with the same name if it exists, if it does not it will then fall back to recreating the data
#' 
#' @returns A saved .nc file, plus a netcdf object in the active session
#'
#' @export
#' @examples
#' \dontrun{ #dont run because function takes a long time
#' 
#' raw_path <- "path/to/raw folder/"
#' crop_path <- "path/to/crop folder/"
#' n3_region <- build_n3_region()
#' 
#' dme_cropped <- dem_pre_processing(raw_path, crop_path, "n3_dem_100m", n3_region, Overwrite = FALSE)
#' }
#' 
dem_pre_processing <- function(RawPath, CropPath, OutputName, CropObj, Overwrite){

  #check required arguments
  if (any(missing(RawPath), missing(CropPath), missing(OutputName), missing(CropObj), missing(Overwrite))){
    stop("You must supply all arguments: 'RawPath', 'CropPath', 'OutputName', 'CropObj' and 'Overwrite'.")}

  #check required arguement types
  if (!is.character(RawPath)){stop("The argument supplied to the 'RawPath' parameter must be of character type.")}
  if (!is.character(CropPath)){stop("The argument supplied to the 'CropPath' parameter must be of character type.")}
  if (!is.character(OutputName)){stop("The argument supplied to the 'OutputName' parameter must be of numeric type.")}
  if (!inherits(CropObj, "sf")){stop("The argument supplied to the 'CropObj' parameter must be of type sf.")}
  if (!is.logical(Overwrite)){stop("The argument supplied to the 'Overwrite' parameter must be boolean (TRUE or FALSE).")}

  #if overwrite is false and the file exists, open it
  if (!Overwrite & file.exists(glue::glue("{CropPath}{OutputName}.nc"))){

    #open
    all_tif <- terra::rast(glue::glue("{CropPath}{OutputName}.nc")) 

    #return the object to the active environment
    return(all_tif)

  #if overwrite is true, or the file does not exist, build from scratch
  } else {

    #list all .tif files at the raw path
    all_tif <- list.files(RawPath, pattern = ".tif", full.names = TRUE)

    #for each tif, open, and force origin
    all_tif <- purrr::map(all_tif, \(x) {
      x_open <- terra::rast(x)
      origin(x_open) <- 0
      return(x_open)
    })

    #create a temporary directory (avoids strange permission issues)
    dir.create("C:/tmp", showWarnings = FALSE)

    #tell terra to use this directory as the temporary directory
    terra::terraOptions(tempdir = "C:/tmp")

    #if more than one item in list (30m data) merge the objects. If 1, extract from list
    if(length(all_tif) > 1) {all_tif <- merge(all_tif[[1]], all_tif[[2]], all_tif[[3]], all_tif[[4]])}
    if(length(all_tif) == 1) {all_tif <- all_tif[[1]]}

    #remove temp file and temp directory
    unlink("C:/tmp", recursive = TRUE, force = TRUE)

    #prepare cropping object
    CropObj <- CropObj |> 
      sf::st_bbox() |> 
      sf::st_as_sfc() |> 
      terra::vect() |>
      terra::project(glue::glue("EPSG:{terra::crs(all_tif, describe = TRUE)$code}")) 

    #crop data by cropping object
    all_tif <- terra::trim(terra::mask(all_tif, CropObj))

    #save using the name provided
    terra::writeCDF(all_tif, glue::glue("{CropPath}/{OutputName}.nc"), overwrite = TRUE) 

    #return the object to the active environment as well
    return(all_tif)

  }
}

