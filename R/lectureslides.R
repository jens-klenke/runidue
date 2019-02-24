#' Beamer Lecture Slides
#'
#' @inheritParams rmarkdown::pdf_document
#' @param ... Arguments to \code{rmarkdown::pdf_document}
#'
#' Format for creating basic memos.
#' @return R Markdown output format to pass to
#'   \code{\link[rmarkdown:render]{render}}
#'
#' @details Include a logo using the YAML option \code{logo}.
#'
#'
#' @examples
#' \dontrun{ library(rmarkdown) draft("MyLecture.Rmd", template = "lectureslides",
#' package = "rmemo") }
#' @import rmarkdown
#' @export
lectureslides <- function(lang = "en",
                          towers = T,
                          template = "default",
                          toc = TRUE,
                          slide_level = 2,
                          incremental = FALSE,
                          fig_width = 10,
                          fig_height = 7,
                          fig_crop = TRUE,
                          fig_caption = TRUE,
                          dev = 'pdf',
                          df_print = "default",
                          theme = "default",
                          colortheme = "default",
                          fonttheme = "default",
                          highlight = "default",
                          keep_tex = FALSE,
                          latex_engine = "pdflatex",
                          citation_package = c("none", "natbib", "biblatex"),
                          self_contained = TRUE,
                          includes = NULL,
                          md_extensions = NULL,
                          pandoc_args = NULL) {
  
  # base pandoc options for all beamer output
  args <- c()
  
  # template path and assets
  if (!is.null(template)) {
    if (identical(template, "default")) template <- find_resource("lectureslides", "template.tex")
    if (!is.null(template))
      args <- c(args, "--template", pandoc_path_arg(template))
  }
  
  # table of contents
  if (toc)
    args <- c(args, "--table-of-contents")
  
  # slide level
  if (!is.null(slide_level))
    args <- c(args, "--slide-level", as.character(slide_level))
  
  # incremental
  if (incremental)
    args <- c(args, "--incremental")
  
  # themes
  if (!identical(theme, "default"))
    args <- c(args, pandoc_variable_arg("theme", theme))
  if (!identical(colortheme, "default"))
    args <- c(args, pandoc_variable_arg("colortheme", colortheme))
  if (!identical(fonttheme, "default"))
    args <- c(args, pandoc_variable_arg("fonttheme", fonttheme))
  
  # highlighting
  if (!is.null(highlight))
    highlight <- match.arg(highlight, highlighters())
  args <- c(args, pandoc_highlight_args(highlight))
  
  # latex engine
  latex_engine = match.arg(latex_engine, c("pdflatex", "lualatex", "xelatex"))
  args <- c(args, pandoc_latex_engine_args(latex_engine))
  
  # citation package
  citation_package <- match.arg(citation_package)
  if (citation_package != "none") args <- c(args, paste0("--", citation_package))
  
  # generate a self-contained LaTeX document (including preamble)
  if (self_contained) args <- c(args, "--self-contained")
  
  # content includes
  args <- c(args, includes_to_pandoc_args(includes))
  
  # make sure the graphics package is always loaded
  if (identical(template, "default")) args <- c(args, "--variable", "graphics=yes")
  
  # custom args
  args <- c(args, pandoc_args)
  
  # initialize saved files dir
  saved_files_dir <- NULL
  
  ######
  res_path <- find_res_path("lectureslides")
  
  args <- c(args, c(args, pandoc_variable_arg("resources", res_path)))
  
  args <- c(args, pandoc_variable_arg("lang", lang))
  args <- c(args, pandoc_variable_arg("towers", towers))
  
  
  pre_knit <- function(input, ...) {
    options(tikzDocumentDeclaration = "\\documentclass{beamer}")
    options(tikzMetricsDictionary="Resources/tikzDictionary")
    options(digits = 4)
    ### Use blue as the default plotting color
    plot <- function(..., col = NULL, pch = NULL) {
      graphics::plot(..., bty = "o",
                     col = ifelse(is.null(col), "steelblue3", col),
                     pch = ifelse(is.null(pch), 16, pch))
    }
  }
  
  pre_processor <- function(metadata, input_file, runtime, knit_meta,
                            files_dir, output_dir) {
    # save files dir (for generating intermediates)
    saved_files_dir <<- files_dir
    base_path <<- paste0(input_file, "_resources/")

    # no-op other than caching dir location
    invisible(NULL)
  }
  
  # generate intermediates (required to make resources available for publish)
  intermediates_generator <- function(...) {
    general_intermediates_generator(saved_files_dir, ...)
  }
  
  # default knitr options
  default_chunk_opts <- list(echo = T, 
                             fontsize = "\\footnotesize", 
                             dev = "tikz", 
                             cache = T, 
                             message = FALSE, 
                             warning = FALSE,
                             fig.width = 0.9,
                             fig.asp = 0.66, 
                             fig.align = "center", 
                             cpar = T,
                             fig.path = "Resources/Plots/",
                             cache.path = "Resources/Cache/")
  
  # return format
  output_format(
    knitr = knitr_options(opts_chunk = default_chunk_opts,
                          knit_hooks = list(chunk = chunk_hook,
                                            output = output_hook,
                                            cpar = custom_par_hook),
                          opts_hooks = list(fig.width = fig_width_hook)),
    pandoc = pandoc_options(to = "beamer",
                            from = from_rmarkdown(fig_caption, md_extensions),
                            args = args,
                            latex_engine = latex_engine,
                            keep_tex = keep_tex),
    pre_knit = pre_knit,
    pre_processor = pre_processor,
    intermediates_generator = intermediates_generator,
    clean_supporting = !keep_tex,
    df_print = df_print
  )
}



