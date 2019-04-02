#'@import knitr 
set_hooks <- function() {
  default_hooks  <- knit_hooks$get()
  list(
    chunk = function(x, options) {
      x <- default_hooks$chunk(x, options)
      ifelse(!is.null(options$fontsize), paste0("\n", options$fontsize,"\n", x, "\\normalsize"), x)
    },
    cex = function(before, options, envir) {
      if (before) par(mar = c(3.5, 3.5, 1.67, 1.3), oma = c(0, 0, 0, 0), pch = 16,
                      mgp = c(1.75, .5, 0), tcl = -0.33, cex = options$cex, cex.axis=0.85, cex.lab=0.85, cex.main=0.87)
    },
    output = function(x, options) {
      x <- paste0("```\n", x,"```\n")
      x <- ifelse(is.null(options$shadeoutput),
                  x,
                  paste0("\\Shaded\n", x, "\\endShaded\n"))
      x
    },
    plot = function(x, options) {
      x <- hook_plot_tex(x, options)
      print(x)
      x <- gsub("^(?:[\t ]*(?:\r?\n|\r))+", "", x)
      x <- gsub("\n\n$", "\n", x)
      x
    }
  )
}


set_opt_hooks <- function() {
  list(
    fig.width = function(options) {
      if (!(options$fig.width <= 1 & options$fig.width > 0)) {
        stop("fig.width should be in (0, 1]")
      }
      options$cex <- magnify(options$fig.width)
      options$fig.width  <- options$fig.width * slide.width
      options$fig.height <- options$fig.asp * options$fig.width
      options
    }
  )
}
