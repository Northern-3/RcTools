#' Create the base map elements for a DEM map
#'
#' @param Highlight An sf object that defines the area of interest. Must be within map boundaries
#' @param Extent An sf object, bbox object, or SpatExtent that defines the full map boundaries
#' @param MapArray An array object created specifically by the 'dem_base_map()' function
#' 
#' 
#' @returns The provided array object with highlights now embedded.
#'
#' @export
#' @examples
#' \dontrun{ #dont run because function takes a long time
#' 
#' maggie <- build_n3_region() |> 
#'     filter(SubBasinOrSubZone == "Magnetic Island")
#' 
#' map_ext <- ext(my_spat_raster)
#' 
#' map_array <- dem_base_map(...)
#' 
#' dem_cropped <- dem_polygon_highlight(
#'   Highlight = maggie,
#'   Extent = map_ext,
#'   MapArray = map_array
#' )
#' }
#' 
dem_polygon_highlight <- function(Highlight, Extent, MapArray){
  
  #all arguments are required
  if (any(missing(Highlight), missing(Extent), missing(MapArray))){stop("All arguments are required.")}

  #check types
  if (!inherits(Highlight, "sf")){
    stop("The object supplied to 'Highlight' must be either a sf object.")
  }
  if (!inherits(Extent, "sf")){
    stop("The object supplied to 'Extent' must be either a sf object.")
  }
  if (!(inherits(MapArray, "array") | inherits(MapArray, "rayimg"))){
    stop("The object supplied to 'MapArray' must be an array produced by the dem_pre_processing function.")
  }

  #update crs of sf objects
  Highlight <- sf::st_transform(Highlight, "EPSG:4326")
  Extent <- sf::st_transform(Extent, "EPSG:4326")
  
  #create an inversion of the targeted polygon without required external "help" or user input:
  highlight_inversion <- Extent |> 
    sf::st_bbox() |>
    sf::st_as_sfc() |> 
    sf::st_union() |> 
    sf::st_difference(sf::st_union(Highlight))

  #create the overlay
  overlay_1 <- rayshader::generate_polygon_overlay(
    Highlight, extent = Extent, MapArray, palette = "transparent", linecolor = "black", linewidth = "2")

  overlay_2 <- rayshader::generate_polygon_overlay(
    Highlight, extent = Extent, MapArray, palette = "transparent", linecolor = "white", linewidth = "1.5")

  overlay_3 <- rayshader::generate_polygon_overlay(
    highlight_inversion, extent = Extent, MapArray, palette = "black", linecolor = "black", linewidth = "0")

  #put the overlays into the main array
  MapArray <- MapArray |> 
    rayshader::add_overlay(overlay_1) |>
    rayshader::add_overlay(overlay_2) |> 
    rayshader::add_overlay(overlay_3, alphalayer = 0.7)

  #return the array
  return(MapArray)
}