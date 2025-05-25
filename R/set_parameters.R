#' @title Load Radii Values
#' 
#' @name get_radii
#'
#' @description The 'get_radii' function is responsible for loading the atomic 
#'              radii values used for surface-occlusion calculations. The values 
#'              it returns are those currently employed in those calculations.
#'
#' @return A data frame containing the radii values.
#' 
#' @seealso [set_radii()]
#' @seealso [reset_radii()]
#'
#' @author Carlos Henrique da Silveira (carlos.silveira@unifei.edu.br)
#' @author Herson Hebert Mendes Soares (hersonhebert@hotmail.com)
#' @author Joao Paulo Roquim Romanelli (joaoromanelli@unifei.edu.br)
#' @author Patrick Fleming (Pat.Fleming@jhu.edu)
#' 
#' @examples
#' library(fibos)
#' #If the environment has not yet been configured, you must execute 'fibos_config()' before proceeding.
#' 
#' #Loads the radius values that have been configured for code execution.
#' radii = get_radii()
#' #Displays the first three lines.
#' radii |> utils::head(3) |> print()
#' 
#' 
#' @export
get_radii = function(){
  if(reticulate::virtualenv_exists("fibos_venv")){
    reticulate::use_virtualenv("fibos_venv")
    if(!reticulate::py_module_available("fibos")){
      warning("Module 'python' 'fibos' not available. Use 'fibos_config()' to install the module.")
    }
    else{
        python = reticulate::import("fibos", delay_load = TRUE)
        radii = dplyr::as_tibble(python$get_radii())
        return(radii)
    }
  } else {
    warning("The virtual environment fibos_venv was not found. Please run 'fibos_config()' to configure it.")
  }
}

#' @title Change Radii Values
#' @name set_radii
#' 
#' @param radii_values A 'data.frame' containing atomic radii values.
#'
#' @description This function enables modification of the radius values by 
#'              passing a 'data.frame' as an argument.
#' @seealso [get_radii()]
#' @seealso [reset_radii()]
#'
#'
#' @author Carlos Henrique da Silveira (carlos.silveira@unifei.edu.br)
#' @author Herson Hebert Mendes Soares (hersonhebert@hotmail.com)
#' @author Joao Paulo Roquim Romanelli (joaoromanelli@unifei.edu.br)
#' @author Patrick Fleming (Pat.Fleming@jhu.edu)
#' @examples
#' library(fibos)
#' 
#' #If the environment has not yet been configured, you must execute 'fibos_config()' before proceeding.
#' 
#' #Loads the radius values that have been configured for code execution.
#' radii = get_radii()
#' #Displays the first three lines.
#' radii |> utils::head(3) |> print()
#' #Modifies the value of a specific radius.
#' radii$RAY[1] = 2.15
#' #Sets the radius value from a tibble.
#' set_radii(radii)
#' #Displays the first three lines.
#' get_radii() |> utils::head(3) |> print()

#' @export

set_radii = function(radii_values){
  if(reticulate::virtualenv_exists("fibos_venv")){
    reticulate::use_virtualenv("fibos_venv")
    if(!reticulate::py_module_available("fibos")){
      warning("Module 'python' 'fibos' not available. Use 'fibos_config()' to install the module.")
    }
    else{
        python = reticulate::import("fibos", delay_load = TRUE)
        python$set_radii(radii_values)
    }
  } else {
    warning("The virtual environment fibos_venv was not found. Please run 'fibos_config()' to configure it.")
  }
}


#' @title Reset Radii Values
#' @name reset_radii
#' 
#' @description This function reloads the 'OS' default atomic radii values.
#' 
#' @seealso [get_radii()]
#' @seealso [set_radii()]
#'
#'
#' @author Carlos Henrique da Silveira (carlos.silveira@unifei.edu.br)
#' @author Herson Hebert Mendes Soares (hersonhebert@hotmail.com)
#' @author Joao Paulo Roquim Romanelli (joaoromanelli@unifei.edu.br)
#' @author Patrick Fleming (Pat.Fleming@jhu.edu)
#' 
#' @examples
#' library(fibos)
#' #If the environment has not yet been configured, you must execute 'fibos_config()' before proceeding.
#' 
#' #Loads the radius values that have been configured for code execution.
#' radii = get_radii()
#' #Displays the first three lines.
#' radii |> utils::head(3) |> print()
#' #Modifies the value of a specific radius.
#' radii$RAY[1] = 2.15
#' #Sets the radius value from a tibble.
#' set_radii(radii)
#' #Displays the first three lines.
#' get_radii() |> utils::head(3) |> print()
#' #Loads the default radius values.
#' reset_radii()
#' #Displays the first three lines.
#' get_radii() |> utils::head(3) |> print()
#' 
#' @export

reset_radii = function(){
  if(reticulate::virtualenv_exists("fibos_venv")){
    reticulate::use_virtualenv("fibos_venv")
    if(!reticulate::py_module_available("fibos")){
      warning("Module 'python' 'fibos' not available. Use 'fibos_config()' to install the module.")
    }
    else{
        python = reticulate::import("fibos", delay_load = TRUE)
        python$reset_radii()
    }
  } else {
    warning("The virtual environment fibos_venv was not found. Please run 'fibos_config()' to configure it.")
  }
}