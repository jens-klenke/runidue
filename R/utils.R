slide.width  <- 5.04 # slide width in inches
slide.height <- 3.78

# Auto set cex parameter
fwidth  <- c(0.5, 0.6, 0.7, 0.8, 0.9)
cex     <- c(0.6, 0.7, 0.75, 0.8, 0.85)
magnify <- approxfun(fwidth, cex, yleft = 0.6, yright = 0.85)

due.col <- list(blue      = "#004c93",
                lightblue = "#dfe4f2",
                beige     = "#efe4bf")



# utility functions for the rendering process -----------------------------
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

highlighters <- function() {
  c("default",
    "tango",
    "pygments",
    "kate",
    "monochrome",
    "espresso",
    "zenburn",
    "haddock")
}


# used to copy tex files into project dir
# provide_latex_pkg <- function(template, files) {
#   f <- sapply(files, find_resource, template = template)
#   invisible(file.copy(f, to = 'Resources/', overwrite = T))
# }

