#' Create a river overlay for the area
#'
#' @param Lines An sf object that defines the line waterbodies to be put onto the map (e.g. rivers)
#' @param Polygons An sf object that defines the polygon waterbodies to be put onto the map (e.g. lakes)
#' @param Extent An sf object that defines the full map boundaries
#' @param MapArray An array object created specifically by the 'dem_base_map()' function
#' 
#' 
#' @returns The provided array object with waterbodies now embedded.
#'
#' @export
#' @examples
#' \dontrun{ #dont run because function takes a long time
#' 
#' ross_waters <- extract_watercourses("Ross", WaterAreas = TRUE, WaterLakes = TRUE, StreamOrder = 1
#' 
#' map_ext <- ext(my_spat_raster)
#' 
#' map_array <- dem_base_map(...)
#' 
#' dem_cropped <- dem_water_overlay(
#'   Lines = ross_waters,
#'   Polygons = ross_waters,
#'   Extent = map_ext,
#'   MapArray = map_array
#' )
#' }
#' 
dem_water_overlay <- function(Lines, Polygons, Extent, MapArray){
  
  #all arguments are required
  if (any(missing(Lines), missing(Extent), missing(MapArray))){stop("'Lines', 'Extent', and 'MapArray' arguments are required.")}

  #check types
  if (!inherits(Lines, "sf")){
    stop("The object supplied to 'Lines' must be a sf object.")
  }
  #check types
  if (exists(Polygons) & !inherits(Polygons, "sf")){
    stop("The object supplied to 'Polygons' must be a sf object.")
  }

  if (!inherits(Extent, "sf")){
    stop("The object supplied to 'Extent' must be a sf object.")
  }
  if (!(inherits(MapArray, "array") | inherits(MapArray, "rayimg"))){
    stop("The object supplied to 'MapArray' must be an array produced by the dem_pre_processing function.")
  }

  #update crs of sf objects
  Lines <- sf::st_transform(Lines, "EPSG:7844")
  if (exists(Polygons)){Polygons <- sf::st_transform(Polygons, "EPSG:7844")}
  Extent <- sf::st_transform(Extent, "EPSG:7844")

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