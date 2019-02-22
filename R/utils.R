find_file <- function(template, file) {
  path <- system.file("rmarkdown", "templates", template, file,
                          package = "runidue")
  if (path == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }
  
 path
}

find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

find_res_path <- function(template) {
  system.file("rmarkdown", "templates", template, "resources", package = "runidue")  
}
