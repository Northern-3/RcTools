#' Preprocess Digital Elevation Model data from AUSSEABED for the GBR
#'
#' @param RawPath The path to where to find the raw, unprocessed data
#' @param CropPath The path where the function should save the processed data
#' @param OutputName The name of the file when it is saved
#' @param CropObj The object to use for cropping the dataset
#' 
#' @returns A saved .nc file, plus a netcdf object in the active session
#'
#' @export
#' @examples
#' 
#' 
dem_pre_processing <- function(RawPath, CropPath, OutputName, CropObj){

  #check required arguments
  if (any(missing(RawPath), missing(CropPath), missing(OutputName), missing(CropObj))){
    stop("You must supply all arguments: 'RawPath', 'CropPath', 'OutputName' and 'CropObj'.")}

  #check required arguement types
  if (!is.character(RawPath)){stop("The object supplied to the 'RawPath' parameter must be of character type.")}
  if (!is.character(CropPath)){stop("The object supplied to the 'CropPath' parameter must be of character type.")}
  if (!is.character(OutputName)){stop("The object supplied to the 'OutputName' parameter must be of numeric type.")}
  if (!inherits(CropObj, "sf")){stop("The object supplied to the 'CropObj' parameter must be of type sf.")}

  #list all .tif files at the raw path
  all_tif <- list.files(RawPath, pattern = ".tif", full.names = TRUE)

  #for each tif, open, and force origin
  all_tif <- purrr::map(all_tif, \(x) {
    x_open <- terra::rast(x)
    origin(x_open) <- 0
    return(x_open)
  })

  #if more than one item in list (30m data) merge the objects. If 1, extract from list
  if(length(all_tif) > 1) {all_tif <- merge(all_tif) |> terra::project("EPSG:7844")}
  if(length(all_tif) == 1) {all_tif <- all_tif[[1]] |> terra::project("EPSG:7844")}

  #prepare cropping object
  CropObj <- CropObj |> 
    sf::st_bbox() |> 
    sf::st_as_sfc() |> 
    terra::vect() |>
    terra::project("EPSG:7844") 

  #crop data by cropping object
  all_tif <- terra::trim(terra::mask(all_tif, CropObj))

  #save using the name provided
  terra::writeCDF(all_tif, glue::glue("{CropPath}/{OutputName}.nc")) 

  #return the object to the active environment as well
  return(all_tif)

}

