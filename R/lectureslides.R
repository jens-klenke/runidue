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
#' @importFrom rmarkdown pdf_document pandoc_path_arg pandoc_variable_arg
#' @export
lectureslides <- function(..., 
                          lang = "en",
                          towers = TRUE) {
  res_path <- find_res_path("lectureslides")
  
  # handle arguments
  args <- c()
  args <- c(args, c(args, pandoc_variable_arg("resources", res_path)))
  
  
  args <- c(args, pandoc_variable_arg("lang", lang))
  args <- c(args, pandoc_variable_arg("towers", towers))
  
  
  
  rmarkdown::beamer_presentation(...,
                                 template = find_resource("lectureslides", "template.tex"), 
                                 pandoc_args = args,
                                 dev = "tikz",
                                 fig_crop = T)
}










