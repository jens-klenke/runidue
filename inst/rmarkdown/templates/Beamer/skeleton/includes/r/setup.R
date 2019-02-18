require("knitr")

### Constants -----------------------------------------------------------------
slide.width  <- 5.04 # slide width in inches
slide.height <- 3.78

due.col <- list(blue = "#004c93",
                lightblue = "#dfe4f2",
                beige = "#efe4bf")

### Options -------------------------------------------------------------------
options(tikzDocumentDeclaration = '\\documentclass{beamer}')
opts_chunk$set(echo = T, fontsize = "\\footnotesize", dev = "tikz", cache = T, message = FALSE, warning = FALSE,
               fig.width = 0.9, fig.asp = 0.66, fig.align = "center", c.par = T,
               fig.path = "Plots/")
options(digits = 4)

### Default plotting parameters -----------------------------------------------
custom.par <- function(...) {
  par(mar = c(4.1, 3.1, 1.5, 1), oma = c(0, 0, 0, 0), pch = 16,
      mgp = c(1.7, 0.4, 0), tcl = -0.33, ...)
}

# Auto set cex parameter
fwidth  <- c(0.5, 0.6, 0.7, 0.8, 0.9, 1)
cex     <- c(0.6, 0.7, 0.75, 0.8, 0.85, 0.9)
magnify <- approxfun(fwidth, cex, yleft = 0.5, yright = 0.9)

### Use blue as the default plotting color
plot <- function(..., col = NULL, pch = NULL) {
  graphics::plot(..., bty = "o",
                 col = ifelse(is.null(col), "steelblue3", col),
                 pch = ifelse(is.null(pch), 16, pch))
}

### Hooks ---------------------------------------------------------------------
def.chunk.hook  <- knitr::knit_hooks$get("chunk")
knitr::knit_hooks$set(chunk = function(x, options) {
  x <- def.chunk.hook(x, options)
  ifelse(!is.null(options$fontsize), paste0("\n", options$fontsize,"\n\n", x, "\n\n \\normalsize"), x)
})

def.output.hook <- knitr::knit_hooks$get("output")
knitr::knit_hooks$set(output = function(x, options) {
  ifelse(is.null(options$shadeoutput),
         def.output.hook(x, options),
         paste0("\\begin{Shaded}\n\\begin{verbatim}\n", gsub(pattern = "```|^\\s*$", "", x, perl = T), "\\end{verbatim}\n\\end{Shaded}"))
})

opts_hooks$set(fig.width = function(options) {
  if (options$fig.width <= 1 & options$fig.width > 0) {
    options$cex <- magnify(options$fig.width)
    options$fig.width  <- options$fig.width * slide.width
    options$fig.height <- options$fig.asp * options$fig.width
    
  }
  options
})

knit_hooks$set(c.par = function(before, options, envir) {
  if (before) {
    custom.par(cex = options$cex)
  }
})




