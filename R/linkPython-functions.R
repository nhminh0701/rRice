library(PythonInR)

#' callExecutablePy
#'
#' This function calls test.py which will be allow to all python file to be
#' executable
#' 
#' @return nothing
#' @import PythonInR
#' @rdname callExecutablePy-function
callExecutablePy <- function () {
    path <- system.file("python",
                        "execfile.py",
                        package = "rRice")
    
    path2 <- system.file("python",
                        package = "rRice")

    PythonInR::pySet("path", path2, namespace = "__main__")
    PythonInR::pyExecfile(path)
}

#' dlPythonModules
#'
#' This function calls importModules.py in order to install all the python
#' modules we need if they have not yet been installed
#' 
#' @return nothing
#' @importFrom findpython find_python_cmd
#' @import utils
#' @rdname dlPythonModules-function
dlPythonModules <- function () {
    path <- system.file("python",
                        "importmodules.py",
                        package = "rRice")
    
    if (Sys.info()["sysname"] != "Windows"){
        ##call importModules.py to improt all the modules we need with python
        system2(command = path, args=c(), stdout = TRUE)
    }
    else {
        ##call importModules.py to improt all the modules we need with python
        path <- shortPathName(path)
        args = c(path)
        cmd <- findpython::find_python_cmd()
        system2(command = cmd, args=args)
    }
}

