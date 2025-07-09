#' Beamer Lecture Slides
#'
#' @param template \code{character}. The template to be used. Defaults to
#'   \code{default}
#' @param lang \code{character}. Language of the presentation. One of
#'   \code{"de"} or \code{"en"}. Defaults to \code{"en"}.
#' @param towers \code{logical}. Should the title page include a gradient logo
#'   of the university buildings.
#' @param institute \code{logical} or \code{character}. Should the name of the
#'   institution be included on the title page. Defaults to \code{T} and
#'   includes the name of the University Duisburg-Essen in the language
#'   specified by \code{lang}. If a \code{character} object is provided, this
#'   string is shown underneath the title.
#' @param blockstyle \code{character}. The style of the beamer block
#'   environments (theorems, examples, etc.). One of \code{"box"} or
#'   \code{"blank"}. Defaults to \code{"box"}.
#' @param footerstyle \code{character} One of "default" or "colored".
#' @param shadecolor \code{numeric}. The shade of grey used as the background
#'   color for code chunks. A number between 0 and 1.
#' @param tables \code{logical} Should the latex packages "longtables" and "bookstabs" be included.
#' @param colorlinks \code{logical} Should links be colored.
#' @param logo \code{character} Path to a logo for the slides. If not set otherwise, a UDE logo is used.
#' @param quiz_logo \code{character} Path to a logo for the slides. If not set otherwise, a quiz academy logo is used.
#' @param slide_level \code{numeric} Depth of slide numbering. Defaults to 2.
#' @param incremental \code{logical} Should the slides render incrementally. Defaults to \code{FALSE}.
#' @param fig_width \code{numeric} Default width of figures in inches. Defaults to 10.
#' @param fig_height \code{numeric} Default height of figures in inches. Defaults to 7.
#' @param fig_crop \code{logical} Should white space be cropped from figures.
#' @param fig_caption \code{logical} Should figure captions be used. Defaults to \code{TRUE}.
#' @param dev \code{character} The graphic device to be used. Defaults to "tikz".
#' @param df_print See \link[rmarkdown]{output_format}.
#' @param theme \code{character} The theme for the slides.
#' @param colortheme \code{character} The color theme for the slides.
#' @param fonttheme \code{character} The font theme for the slides.
#' @param highlight \code{character} One of \code{rmarkdown:::highlighters()}.
#' @param pandoc_args Further arguments passed on to pandoc.
#' @param citation_package The citation package to be used. One of c("none", "natbib", "biblatex")
#' @param md_extensions Markdown extensions for pandoc. Default to \code{+fancy_lists}.
#' 
#' @section Available Environment for Box:
#' \tabular{ll}{
#'   \strong{Command} \tab \strong{Purpose} \cr
#'   \code{thmn}  \tab Theorem                    \cr
#'   \code{lem}   \tab Lemma                      \cr
#'   \code{cor}   \tab Corollary                  \cr
#'   \code{defn}  \tab Definition                 \cr
#'   \code{ass}   \tab Assumption (Annahme)       \cr
#'   \code{rem}   \tab Remark (Anmerkung)         \cr
#'   \code{prop}  \tab Proposition                \cr
#'   \code{xmpl}  \tab Example (Beispiel)         \cr
#'   \code{que}   \tab Question (Frage)           \cr
#'   \code{exe}   \tab Exercise (Aufgabe)         \cr
#'   \code{mthmn} \tab Mathematical Theorem block \cr
#' }
#' 
#' \preformatted{
#' 
#' ```{Example}
#' \xmpl[Heading of the example]
#'   The example itself …
#' \endxmpl
#' ```
#' 
#' ```{=latex}
#' # Example of a long environment
#' \xmpl[Long Environments]
#' A very long example which may not fit the slide
#' \endxmpl
#' # Continuation of the previous example
#' \xmpl[*]
#' This is the continuation of the long example in the next slide.
#' \endxmpl
#' ```
#' 
#' ```{=latex}
#' # Example of kahoot box
#' \kahoot {Kahoot Heading} Kahoot Contents \endkahoot
#' ```
#' }
#' 
#' @section Box‐color variables:
#' \tabular{lll}{
#'   \strong{Variable}                \tab \strong{Use}                       \tab \strong{Default Color} \cr
#'   \code{theorem_box_color}         \tab Theorem                             \tab blue   \cr
#'   \code{lemma_box_color}           \tab Lemma                               \tab blue   \cr
#'   \code{corollary_box_color}       \tab Corollary                           \tab blue   \cr
#'   \code{definition_box_color}      \tab Definition                          \tab green  \cr
#'   \code{assumption_box_color}      \tab Assumption (Annahme)                \tab blue   \cr
#'   \code{remark_box_color}          \tab Remark (Anmerkung)                  \tab blue   \cr
#'   \code{proposition_box_color}     \tab Proposition                         \tab blue   \cr
#'   \code{beispiel_box_color}        \tab Example (Beispiel)                  \tab yellow \cr
#'   \code{frage_box_color}           \tab Question (Frage)                    \tab blue   \cr
#'   \code{exercise_box_color}        \tab Exercise (Aufgabe)                  \tab blue   \cr
#'   \code{math_theorem_box_color}    \tab Mathematical Theorem                \tab blue   \cr
#' }
#' 
#' \preformatted{
#' 
#' ```{Example}
#' title: "Induktive Statistik"
#' author: "Prof. Dr. Christoph Hanck"
#' date: "Sommersemester 2025"
#' output: 
#'   runidue::lectureslides:
#'   lang: "en" 
#' keep_tex: true
#' exercise_box_color: yellow
#' ```
#' }
#' 
#' @param self_contained Produce stand-alone intermediate files.
#' @param includes Files that should be included via pandoc. See pandoc arguments.
#' @inheritParams rmarkdown::output_format
#' @inheritParams rmarkdown::pandoc_options
#' @return R Markdown output format to pass to
#'   \code{\link[rmarkdown:render]{render}}
#' @examples
#' \dontrun{ library(rmarkdown) draft("MyLecture.Rmd", template = "lectureslides",
#' package = "runidue") }
#' @import rmarkdown knitr
#' @export
lectureslides <- function(lang = "en",
                          footerstyle = c("default", "colored"),
                          towers = T,
                          template = "default",
                          colorlinks = T,
                          tables = T,
                          institute = T,
                          blockstyle = c("box", "blank"),
                          shadecolor = "default",
                          logo = "default",
                          quiz_logo = "default",
                          slide_level = 2,
                          incremental = FALSE,
                          fig_width = 10,
                          fig_height = 7,
                          fig_crop = TRUE,
                          fig_caption = TRUE,
                          dev = "tikz",
                          df_print = "default",
                          theme = "default",
                          colortheme = "default",
                          fonttheme = "default",
                          highlight = "default",
                          keep_tex = TRUE,
                          keep_md = TRUE,
                          keep_aux  = TRUE,
                          latex_engine = "pdflatex",
                          citation_package = c("none", "biblatex"),
                          self_contained = TRUE,
                          includes = NULL,
                          md_extensions = "+fancy_lists",
                          pandoc_args = NULL) {
  
  # base pandoc options for all beamer output
  args <- c()
  
  # template path and assets
  if (!is.null(template)) {
    if (identical(template, "default")) template <- find_resource("lectureslides", "lectureslides.tex")
    if (!is.null(template))
      args <- c(args, "--template", pandoc_path_arg(template))
  }
  
  
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
  if (self_contained) args <- c(args, "--embed-resources")
  
  # content includes
  args <- c(args, includes_to_pandoc_args(includes))
  
  # make sure the graphics package is always loaded
  if (identical(template, "default")) args <- c(args, "--variable", "graphics=yes")
  
  # custom args
  args <- c(args, pandoc_args)
  
  # initialize saved files dir
  saved_files_dir <- NULL
  
  # resource path
  res_path <- find_res_path("lectureslides")
  args <- c(args, c(args, pandoc_variable_arg("resources", res_path)))
  
  # lang
  lang <- match.arg(lang, c("de", "en"))
  args <- c(args, pandoc_variable_arg("lang", lang))
  
  # footerstyle
  footerstyle <- match.arg(footerstyle)
  args <- c(args, pandoc_variable_arg("footerstyle", footerstyle))
  
  # colorlinks
  args <- c(args, pandoc_variable_arg("colorlinks", colorlinks))
  
  # tables
  args <- c(args, pandoc_variable_arg("tables", tables))
  
  # tower logo
  if(is.logical(towers))
    if(towers) args <- c(args, pandoc_variable_arg("towers", towers))
    
  # institute
  if (is.logical(institute)) {
    if (institute) args <- c(args, pandoc_variable_arg("institute", "default"))
  } else {
    if(is.character(institute)) args <- c(args, pandoc_variable_arg("institute", institute))
  }
  
  # block style
  blockstyle <- match.arg(blockstyle)
  args <- c(args, pandoc_variable_arg("blockstyle", blockstyle))
  
  # shadecolor
  if(!identical(shadecolor, "default")) {
    if(!is.numeric(shadecolor)) {
      warning("shadecolor should be a numeric value in [0, 1] (shades of grey)")
      shadecolor <- "default"
    } else if (shadecolor < 0 | shadecolor > 1) {
      warning("shadecolor should be a numeric value in [0, 1] (shades of grey)")
      shadecolor <- "default"
    } else {
      args <- c(args, pandoc_variable_arg("shadecolor", shadecolor))
    }
  }
  
  # logo
  if (!identical(logo, "default"))
    args <- c(args, pandoc_variable_arg("logo", logo))

  
  # quiz_logo--------------
  if (!identical(quiz_logo, "default"))
    args <- c(args, pandoc_variable_arg("quiz_logo",quiz_logo))
  
  
  
  pre_knit <- function(input, ...) {
    options(tikzDocumentDeclaration = "\\documentclass{beamer}")
    options(tikzMetricsDictionary="Resources/tikzDictionary")
    options(tikzLatexPackages = c("\\usepackage{tikz}",
                                  "\\usepackage[active,tightpage]{preview}",
                                  "\\PreviewEnvironment{pgfpicture}",
                                  "\\setlength\\PreviewBorder{-5pt}"),
            tikzXelatexPackages = c("\\usepackage{tikz}\n",
                                    "\\usepackage[active,tightpage,xetex]{preview}\n",
                                    "\\usepackage{fontspec,xunicode}\n",
                                    "\\PreviewEnvironment{pgfpicture}\n",
                                    "\\setlength\\PreviewBorder{-5pt}\n"),
            tikzLualatexPackages =c("\\usepackage{tikz}\n",
                                    "\\usepackage[active,tightpage,psfixbb]{preview}\n",
                                    "\\usepackage{fontspec,xunicode}\n",
                                    "\\PreviewEnvironment{pgfpicture}\n",
                                    "\\setlength\\PreviewBorder{-5pt}\n"))
    
    
    options(digits = 4)
    library(runidue)
  }
  

  # ----------------changes---------------------------------------------
  pre_processor <- function(metadata, input_file, runtime,
                            knit_meta, files_dir, output_dir) {
    if (keep_aux) {
      options(tinytex.clean = FALSE)                  # ②  NO on.exit() here!
      saved_files_dir <<- files_dir                  # ③  remember where aux land
    }
    invisible(NULL)
  }
  
  intermediates_generator <- if (keep_aux) {
    function(original_input, encoding) {
      list.files(
        saved_files_dir,
        pattern = "\\.(aux|log|out|nav|snm|toc|vrb)$",  # what to keep
        full.names = TRUE
      )
    }
  } else NULL
  
  
  
  # default knitr options
  default_chunk_opts <- list(echo = T, 
                             fontsize = "\\footnotesize", 
                             dev = dev, 
                             # out.extra = "trim=0 0 0 0, clip",
                             cache = T, 
                             message = FALSE, 
                             warning = FALSE,
                             shadeoutput = NULL,
                             fig.width = 0.85,
                             fig.asp = 0.65, 
                             fig.align = "center", 
                             cpar = T,
                             fig.path = "Resources/Plots/",
                             cache.path = "Resources/Cache/")
  
  
  
  # return format
  output_format(
    knitr  = knitr_options(opts_chunk = default_chunk_opts,
                           knit_hooks = set_hooks(),
                           opts_hooks = set_opt_hooks()),
    pandoc = pandoc_options(to = "beamer",
                            from = from_rmarkdown(fig_caption, md_extensions),
                            args = args,
                            latex_engine = latex_engine,
                            keep_tex = keep_tex),
    pre_knit = pre_knit,
    # post_processor = post_processor,
    pre_processor = pre_processor,
    intermediates_generator = intermediates_generator,
    clean_supporting = FALSE,
    keep_md = keep_md,
    df_print = df_print
  )
}


#  ←–– BLANK LINE that is *not* "#'"  separates the blocks  -----------------






