#' Create a river overlay for the area
#'
#' @param Lines An sf object that defines the line waterbodies to be put onto the map (e.g. rivers)
#' @param Polygons An sf object that defines the polygon waterbodies to be put onto the map (e.g. lakes). Optional
#' @param Extent An sf object that defines the full map boundaries
#' @param MapArray An array object created specifically by the 'dem_base_map()' function
#' @param MapMatrix A matrix object created specifically by the 'dem_base_map()' function
#' @param Crs A character string that describes the cooridnate reference system to use. Defaults to "EPSG:4326"
#' 
#' 
#' @returns The provided array object with waterbodies now embedded.
#'
#' @export
#' @examples
#' \dontrun{ #dont run because function takes a long time
#' 
#' ross_waters <- extract_watercourses("Ross", WaterAreas = TRUE, WaterLakes = TRUE, StreamOrder = 2)
#' 
#' map_ext <- ext(my_spat_raster)
#' 
#' map_array <- dem_base_map(...)
#' map_matrix <- dem_base_map(...)
#' 
#' dem_cropped <- dem_water_overlay(
#'   Lines = ross_waters,
#'   Polygons = ross_waters,
#'   Extent = map_ext,
#'   MapArray = map_array,
#'   MapMatrix = map_matrix
#' )
#' }
#' 
dem_water_overlay <- function(Lines, Polygons = NULL, Extent, MapArray, MapMatrix, Crs = "EPSG:4326"){
  
  #all arguments are required
  if (any(missing(Lines), missing(Extent), missing(MapArray), missing(MapMatrix))){
    stop("'Lines', 'Extent', 'MapArray', and 'MapMatrix' arguments are required.")}
  
  if (!is.character(Crs)){stop("The argument supplied to the 'Crs' parameter must be of character type.")}

  #check types
  if (!inherits(Lines, "sf")){
    stop("The object supplied to 'Lines' must be a sf object.")
  }
  #check types
  if (!is.null(Polygons) & !inherits(Polygons, "sf")){
    stop("The object supplied to 'Polygons' must be a sf object.")
  }

  if (!inherits(Extent, "sf")){
    stop("The object supplied to 'Extent' must be a sf object.")
  }
  if (!(inherits(MapArray, "array") | inherits(MapArray, "rayimg"))){
    stop("The object supplied to 'MapArray' must be an array produced by the dem_pre_processing function.")
  }
  if (!(inherits(MapMatrix, "matrix") | inherits(MapArray, "array"))){
    stop("The object supplied to 'MapMatrix' must be an matrix produced by the dem_pre_processing function.")
  }

  #update crs of sf objects
  Lines <- sf::st_transform(Lines, Crs)
  if (!is.null(Polygons)){Polygons <- sf::st_transform(Polygons, Crs)}
  Extent <- sf::st_transform(Extent, Crs)

  #create the overlay
  water_line_overlay <- rayshader::generate_line_overlay(
    Lines, Extent, MapMatrix, color = "dodgerblue", linewidth = "1")

  water_polygon_overlay <- rayshader::generate_polygon_overlay(
    Polygons, Extent, MapMatrix, palette = "aliceblue", linewidth = "1", linecolor = "dodgerblue")

  #put the overlays into the main array
  MapArray <- MapArray |> 
    rayshader::add_overlay(water_line_overlay) |> 
    rayshader::add_overlay(water_polygon_overlay)

  #return the array
  return(MapArray)
}