#' @title Surface Calc
#' @name execute
#' 
#' @param pdb 4-digit PDB id (will fetch it from the RCSB repository) or the path to a PDB local file.
#' @param method Method to be used: OS (classic) or FIBOS (default).The classic OS covers the surface radially with one of the axes as a reference when allocating the dots. In FIBOS, Fibonacci spirals were used to allocate the dots, which is known to produce lower axial anisotropy as well as more evenly spaced points on a sphere.
#'
#' @description The implemented function executes the implemented methods.
#'              Using this function, it is possible to calculate occluded areas
#'              through the traditional methodology, Occluded Surface, or by
#'              applying the Fibonacci OS methodology. At the end of the method
#'              execution, the "prot.srf" file is generated, and returned for
#'              the function. The data in this file refers to all contacts
#'              between atoms of molecules present in a protein's PDB.
#'
#'
#'
#' @importFrom stats rnorm
#'
#' @author Carlos Henrique da Silveira (carlos.silveira@unifei.edu.br)
#' @author Herson Hebert Mendes Soares (hersonhebert@hotmail.com)
#' @author Joao Paulo Roquim Romanelli (joaoromanelli@unifei.edu.br)
#' @author Patrick Fleming (Pat.Fleming@jhu.edu)

#'
execute = function(pdb, method){
  sys_info = Sys.info()
  if(sys_info["sysname"] == "Windows"){
    python_code = glue::glue("import fibos;fibos.occluded_surface('{pdb}','{method}')")
    reticulate::py_run_string(python_code)
  }else{
    python = reticulate::import("fibos", delay_load = TRUE)
    python$occluded_surface(pdb, method)
  }
  if (tolower(fs::path_ext(pdb)) == "pdb") {
    pdb = fs::path_ext_remove(pdb)
  }
  prot = fs::path_file(pdb)
  prot = paste("prot_", prot, sep = "")
  prot = fs::path_ext_set(prot, "srf")
  prot = fs::path("fibos_files", prot)
  
  return(read_prot(prot))
}

osp_windows = function(file){
  sys_info = Sys.info()
  if(sys_info["sysname"] == "Windows"){
    python_code = glue::glue("import fibos;fibos.osp('{file}')")
    reticulate::py_run_string(python_code)
  }else{
    python = reticulate::import("fibos", delay_load = TRUE)
    result = python$osp(file)
  }
  file = fs::path_ext_remove(file)
  file = fs::path_ext_set(file,"pak")
  return(read_osp(file))
}
