#' Create the base map elements for a DEM map
#'
#' @param sr A SpatRaster object, generally produced by the dem_pre_processing() function.
#' @param Resolution A numeric vector, either 30 or 100. This should match the resolution of the sr object provided.
#' @param OutputPath A character vector that defines the path to the folder where the outputs should be saved
#' @param FileName A character vector that uniquely identifies the outputs. Do not include a file type
#' @param Reload Boolean. Do you want to try and reload a prior saved dataset with the same name? Defaults to TRUE.
#' @param Overwrite Boolean. Do you want to overwrite the previously saved dataset with the same name? Defaults to FALSE
#' @param Texture A character vector. Describes the colour palette to use. One of: “imhof1”, “imhof2”, “imhof3”, “imhof4”, “desert”, “bw”, “unicorn”.
#' @param Zscale A numeric vector. Defines ratio between x and y spacing. Defaults to Resolution input (realistic). Decrease 
#' Zscale to exagerate heights
#' @param SeaLevel A numeric vector. Defines the elevation of sea level. Defaults to 0m. Decrease or increse to simulate
#' various sea levels.
#' 
#' 
#' @returns A matrix object and an array object. Both are saved to the path specified and returned to the active environment
#'
#' @export
#' @examples
#' \dontrun{ #dont run because function takes a long time
#' 
#' dem_cropped <- dem_base_map(
#'   sr = my_spat_raster,
#'   Resolution = 30,
#'   OutputPath = "path/to/output folder/",
#'   FileNmae = "my_file",
#'   Reload = FALSE,
#'   Overwrite = FALSE,
#'   Texture = "Desert",
#'   Zscale = 30,
#'   SeaLevel = 0
#' )
#' }
#' 
dem_pre_processing <- function(
  sr, Resolution, OutputPath, FileName, Reload = TRUE, 
  Overwrite = TRUE, Texture = "Desert", Zscale = NULL, SeaLevel = 0){

  #check required arguments
  if (any(missing(sr), missing(Resolution), missing(OutputPath), missing(FileName))){
    stop("You must supply all arguments: 'sr', 'Resolution', 'OutputPath' and 'FileName'.")}

  #check required arguement types
  if (!inherits(sr, "SpatRaster")){stop("The argument supplied to the 'sr' parameter must be of SpatRaster type.")}
  if (!is.numeric(Resolution)){stop("The argument supplied to the 'Resolution' parameter must be of numeric type.")}
  if (!is.character(OutputPath)){stop("The argument supplied to the 'OutputPath' parameter must be of character type.")}
  if (!is.character(FileName)){stop("The argument supplied to the 'FileName' parameter must be of numeric type.")}

  #check optional arguments
  if (is.null(Zscale)){Zscale <- Resolution}
  if (!is.numeric(Zscale)){stop("The argument supplied to the 'Zscale' parameter must be of numeric type.")}
  if (!is.logical(Reload)){stop("The argument supplied to the 'Reload' parameter must be boolean (TRUE or FALSE).")}
  if (!is.logical(Overwrite)){stop("The argument supplied to the 'Overwrite' parameter must be boolean (TRUE or FALSE).")}
  if (!is.numeric(SeaLevel)){stop("The argument supplied to the 'SeaLevel' parameter must be of numeric type.")}
  if (!is.character(Texture)){stop("The argument supplied to the 'Texture' parameter must be of character type.")}

  #check if texture argument is correct
  Texture <- stringr::str_to_lower(Texture)
  if (!Texture %in% c("imhof1", "imhof2", "imhof3", "imhof4", "desert", "bw", "unicorn")){
    stop("The Texture argument must be one of: 'imhof1', 'imhof2', 'imhof3', 'imhof4', 'desert', 'bw', 'unicorn'.")
  }

  #create full paths to where the matrix and array will be stored
  array_path <- glue::glue("{OutputPath}/{FileName}_{Resolution}m_array")
  matrix_path <- glue::glue("{OutputPath}/{FileName}_{Resolution}m_matrix")

  #reload files if requested and existing
  if (Reload & all(file.eixsts(c(array_path, matrix_path)))){

    #read in
    area_array <- readRDS(file = array_path)
    area_matrix <- readRDS(file = matrix_path)

    #store in a list
    base_map_objects <- list(area_array, area_matrix)

    #return and end
    return(base_map_objects)

  #if the files dont exist, or the user didnt request them. Build
  } else {

    #convert raster into a matrix
    area_matrix <- rayshader::raster_to_matrix(sr)

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
      rayshader::sphere_shade(texture = texture, zscale = 1) |> 
      rayshader::add_shadow(ray_matrix, max_darken = 0.3) |> 
      rayshader::add_shadow(lam_matrix) |> 
      rayshader::add_shadow(amb_matrix) |>
      rayshader::add_shadow(tex_matrix)
      
    print("Core array created.")
    
    if (!all(is.na(area_bathymetry))){#same logic as bathymetry section above
      area_array <- area_array |> 
        rayshader::add_overlay(
          rayshader::generate_altitude_overlay(bath_array, area_matrix, sea_level, sea_level))
      print("Bathymetry maxtrix added.")
    }

    #save the array and associated matrix so they don't have to be recalculated every time
    saveRDS(area_array, array_path)
    saveRDS(area_matrix, matrix_path)

    #store in a list
    base_map_objects <- list(area_array, area_matrix)

    #return and end
    return(base_map_objects)  
  } 
}

