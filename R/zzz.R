#.onLoad <- function(libname, pkgname) {
#  # Carrega o pacote reticulate
#  if (!requireNamespace("reticulate", quietly = TRUE)) {
#    stop("Reticulate not Found.")
#  }
#  
#  # Verifica se o Python esta disponível
#  if (!reticulate::py_available(initialize = TRUE)) {
#    stop("Python not found.")
#  }
#  
#  if (!reticulate::virtualenv_exists("fibos_venv")) {
#    reticulate::virtualenv_create("fibos_venv")
#    reticulate::virtualenv_install("fibos_venv", packages = "fibos")
#  }
#  
#  # Configura o uso do ambiente virtual
#  reticulate::use_virtualenv("fibos_venv", required = TRUE)
#}

#.fibos_env <- new.env(parent = emptyenv())

.onLoad <- function(libname, pkgname) {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("Reticulate not found.")
  }
  sys_info = Sys.info()
  if(sys_info["sysname"] == "Windows"){
    if(!reticulate::virtualenv_exists("fibos_venv")){
      reticulate::virtualenv_create("fibos_venv")
    }
    reticulate::use_virtualenv("fibos_venv")
    if(!reticulate::py_module_available("fibos")){
      reticulate::py_install("fibos")
    }
  }
  else{
    reticulate::py_require("fibos")
    fibos <<- reticulate::import("fibos", delay_load = TRUE)
  }
}
