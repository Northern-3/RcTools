#' Create the base map elements for a DEM map
#'
#' @param sr A SpatRaster object, generally produced by the dem_pre_processing() function.
#' @param OutputPath A character vector that defines the path to the folder where the outputs should be saved
#' @param FileName A character vector that uniquely identifies the outputs. Do not include a file type
#' @param Zscale A numeric vector. Defines ratio between x and y spacing. Defaults to Resolution input (realistic). Decrease 
#' Zscale to exagerate heights
#' @param CropObj A sf object. This is optionally used to further crop the data to a specific location
#' @param Reload Boolean. Do you want to try and reload a prior saved dataset with the same name? Defaults to TRUE.
#' @param Overwrite Boolean. Do you want to overwrite the previously saved dataset with the same name? Defaults to FALSE
#' @param Texture A character vector. Describes the colour palette to use. One of: “imhof1”, “imhof2”, “imhof3”, “imhof4”, “desert”, “bw”, “unicorn”.
#' @param SeaLevel A numeric vector. Defines the elevation of sea level. Defaults to 0m. Decrease or increse to simulate
#' various sea levels.
#' @param Crs A character string that describes the cooridnate reference system to use. Defaults to "EPSG:4326"
#' 
#' 
#' @returns A raster object, matrix object, array object, and extent object. All are saved to the path specified and returned to the active environment
#'
#' @export
#' @examples
#' \dontrun{ #dont run because function takes a long time
#' 
#' ross <- build_n3_region() |> 
#'   filter(BasinOrZone == "Ross")
#' 
#' dem_cropped <- dem_base_map(
#'   sr = my_spat_raster,
#'   OutputPath = "path/to/output folder/",
#'   FileName = "my_file",
#'   Zscale = 30,
#'   CropObj = ross,
#'   Reload = FALSE,
#'   Overwrite = FALSE,
#'   Texture = "Desert",
#'   SeaLevel = 0,
#'   Crs = "EPSG:4326"
#' )
#' }
#' 
dem_base_map <- function(
  sr, OutputPath, FileName, Zscale, CropObj = NULL, Reload = TRUE, 
  Overwrite = TRUE, Texture = "Desert", SeaLevel = 0, Crs = "EPSG:4326"){
  
  #check required arguments
  if (any(missing(sr), missing(OutputPath), missing(FileName), missing(Zscale))){
    stop("You must supply all arguments: 'sr', 'OutputPath', 'FileName' and 'Zscale'.")}

  #check required arguement types
  if (!inherits(sr, "SpatRaster")){stop("The argument supplied to the 'sr' parameter must be of SpatRaster type.")}
  if (!is.numeric(Zscale)){stop("The argument supplied to the 'Zscale' parameter must be of numeric type.")}
  if (!is.character(OutputPath)){stop("The argument supplied to the 'OutputPath' parameter must be of character type.")}
  if (!is.character(FileName)){stop("The argument supplied to the 'FileName' parameter must be of numeric type.")}

  #check optional arguments
  if (!is.null(CropObj)){
    if (!inherits(CropObj, "sf")){
      stop("The object supplied to 'CropObj' is not an sf object.")
    }
  }
  if (!is.logical(Reload)){stop("The argument supplied to the 'Reload' parameter must be boolean (TRUE or FALSE).")}
  if (!is.logical(Overwrite)){stop("The argument supplied to the 'Overwrite' parameter must be boolean (TRUE or FALSE).")}
  if (!is.numeric(SeaLevel)){stop("The argument supplied to the 'SeaLevel' parameter must be of numeric type.")}
  if (!is.character(Texture)){stop("The argument supplied to the 'Texture' parameter must be of character type.")}
  if (!is.character(Crs)){stop("The argument supplied to the 'Crs' parameter must be of character type.")}

  #check if texture argument is correct
  Texture <- stringr::str_to_lower(Texture)
  if (!Texture %in% c("imhof1", "imhof2", "imhof3", "imhof4", "desert", "bw", "unicorn")){
    stop("The Texture argument must be one of: 'imhof1', 'imhof2', 'imhof3', 'imhof4', 'desert', 'bw', 'unicorn'.")
  }

  #create full paths to where the matrix and array will be stored and raster
  sr_path <- glue::glue("{OutputPath}/{FileName}_raster.nc")
  array_path <- glue::glue("{OutputPath}/{FileName}_array")
  matrix_path <- glue::glue("{OutputPath}/{FileName}_matrix")
  extent_path <- glue::glue("{OutputPath}/{FileName}_extent.gpkg")

  #reload files if requested and existing
  if (Reload & all(file.exists(c(sr_path, array_path, matrix_path, extent_path)))){

    #read in
    sr <- terra::rast(sr_path)
    area_array <- readRDS(file = array_path)
    area_matrix <- readRDS(file = matrix_path)
    sr_extent <- sf::st_read(extent_path)

    #store in a list
    base_map_objects <- list(sr, area_array, area_matrix, sr_extent)

    #update names
    names(base_map_objects) <- c("raster", "array", "matrix", "extent")

    #return and end
    return(base_map_objects)

  #if the files dont exist, or the user didnt request them. Build
  } else {

    #if a crop object has been provide, further crop the data
    if (!is.null(CropObj)){

      #convert the crop object into a simple box of the area
      CropObj <- CropObj |> 
        sf::st_transform(Crs) |>
        sf::st_bbox() |>
        sf::st_as_sfc() |> 
        sf::st_union()

      #change it to a vect object just for the cropping part
      CropObj <- CropObj |> 
        terra::vect()

      #force file into memory
      terra::setMinMax(sr)

      #crop the SpatRaster
      sr <- terra::trim(terra::mask(sr, CropObj))
      
    }

    #get full ext of the raster (crop or unchanged) and convert it to a polygon
    sr_extent <- terra::as.polygons(terra::ext(sr), crs = Crs)

    #convert the polygon to an sfc object (for later)
    sr_extent <- sf::st_as_sf(sr_extent)

    #convert raster into a matrix
    area_matrix <- rayshader::raster_to_matrix(sr)

    #check if na values are present in the matrix
    if (any(is.na(area_matrix))){area_matrix <- zoo::na.approx(area_matrix, rule = 2)}

    #create a bathymetry version for water colours (remove everything above the sea level variable)
    area_bathymetry <- area_matrix
    area_bathymetry[area_bathymetry > SeaLevel] <- NA
    
    #create a water colour palettte
    bathy_palette <- grDevices::colorRampPalette(
      c("gray5", "midnightblue", "blue4", "blue2", "blue", "dodgerblue", "lightblue"), 
      bias = 0.5)(256)
    
    #create the core layers, a ray shade matrix, ambient shade matrix, and texture matrix
    ray_matrix <- rayshader::ray_shade(area_matrix, zscale = Zscale)
    print("Rayshade matrix created.")
    
    lam_matrix <- rayshader::lamb_shade(area_matrix, zscale = Zscale)
    print("Lambert shade matrix created.")
    
    amb_matrix <- rayshader::ambient_shade(area_matrix, zscale = Zscale)
    print("Ambient occlusion matrix created.")
    
    tex_matrix <- rayshader::texture_shade(area_matrix, detail = 1)
    print("Texture shade matrix created.")

    #if there is bathymetry to do, create the bathymetry information
    if (!all(is.na(area_bathymetry))){#note there is not always bathymetry, e.g. if the sea level was set to -100000, or if the target is inland.
      bath_array <- rayshader::height_shade(area_bathymetry, texture = bathy_palette)
      print("Bathymetry matrix created.")
    }

    #combine core layers to form the area_array
    area_array <- area_matrix |> 
      rayshader::sphere_shade(texture = Texture, zscale = 1) |> 
      rayshader::add_shadow(ray_matrix, max_darken = 0.3) |> 
      rayshader::add_shadow(lam_matrix) |> 
      rayshader::add_shadow(amb_matrix) |>
      rayshader::add_shadow(tex_matrix)
      
    print("Core array created.")
    
    if (!all(is.na(area_bathymetry))){#same logic as bathymetry section above
      area_array <- area_array |> 
        rayshader::add_overlay(
          rayshader::generate_altitude_overlay(bath_array, area_matrix, SeaLevel, SeaLevel))
      print("Bathymetry maxtrix added.")
    }

    #save the raster, array and associated matrix so they don't have to be recalculated every time
    saveRDS(area_array, array_path)
    saveRDS(area_matrix, matrix_path)
    terra::writeCDF(sr, sr_path, overwrite = Overwrite)

    #store in a list
    base_map_objects <- list(sr, area_array, area_matrix, sr_extent)

    #update names
    names(base_map_objects) <- c("raster", "array", "matrix", "extent")
    
    #return and end
    return(base_map_objects)
    
  }
}