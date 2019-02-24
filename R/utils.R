slide.width  <- 5.04 # slide width in inches
slide.height <- 3.78

# Auto set cex parameter
fwidth  <- c(0.5, 0.6, 0.7, 0.8, 0.9, 1)
cex     <- c(0.6, 0.7, 0.75, 0.8, 0.85, 0.9)
magnify <- approxfun(fwidth, cex, yleft = 0.6, yright = 0.9)

due.col <- list(blue = "#004c93",
                lightblue = "#dfe4f2",
                beige = "#efe4bf")

custom_par <- function(...) {
  par(mar = c(4.1, 3.1, 1.5, 1), oma = c(0, 0, 0, 0), pch = 16,
      mgp = c(1.7, 0.4, 0), tcl = -0.33, ...)
}

### Hooks ---------------------------------------------------------------------
def_hooks  <- knitr::knit_hooks$get()
chunk_hook <- function(x, options) {
  x <- def_hooks$chunk(x, options)
  ifelse(!is.null(options$fontsize), paste0("\n", options$fontsize,"\n\n", x, "\n\n \\normalsize"), x)
}

output_hook <- function(x, options) {
  ifelse(is.null(options$shadeoutput),
         def_hooks$output(x, options),
         paste0("\\begin{Shaded}\n\\begin{verbatim}\n", gsub(pattern = "```|^\\s*$", "", x, perl = T), "\\end{verbatim}\n\\end{Shaded}"))
}

 
fig_width_hook <- function(options) {
  if (options$fig.width <= 1 & options$fig.width > 0) {
    options$cex <- magnify(options$fig.width)
    options$fig.width  <- options$fig.width * slide.width
    options$fig.height <- options$fig.asp * options$fig.width
  }
  options
}

custom_par_hook <- function(before, options, envir) {
  if (before) {
    message(options$cex)
    custom_par(cex = options$cex)
  }
}


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