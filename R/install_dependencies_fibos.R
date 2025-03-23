#' Install the 'Python' 'fibos' Module
#'
#' This function creates a 'Python' virtual environment and installs the
#' 'Python' module 'fibos' required for the full functionality of this package.
#' It handles different system configurations and ensures that the correct
#' compiler paths are set.
#'
#'
#' @note This function will install external software (a 'Python' package) on your system.
#' Administrator/sudo privileges might be required on some systems.
#'
#' @return Invisible NULL. Called for its side effects.
#'
#' @examples
#' \donttest{
#' # Set up the 'Python' environment and install the required module
#' fibos_config()
#' }
#' @export
fibos_config <- function() {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("The 'reticulate' package is required. Please install it using 'install.packages('reticulate')'")
  }
  system_info = Sys.info()
  if(Sys.which("gfortran") == ""){
    if(system_info["sysname"] == "Darwin"){
      Sys.setenv(FC = "/opt/homebrew/bin/gfortran")
      message("'Gfortran' Path Updated.")
    }
  }
  if(reticulate::virtualenv_exists("fibos_venv")){
    reticulate::use_virtualenv("fibos_venv")
  } else {
    reticulate::virtualenv_create("fibos_venv")
    reticulate::use_virtualenv("fibos_venv")
  }
  message("Installing the 'Python' 'fibos' module...")
  reticulate::py_install("fibos", envname = "fibos_venv")
}