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
#' @importFrom rmarkdown pdf_document pandoc_path_arg
#' @export
lectureslides = function(...) {
  template <- pandoc_path_arg(system.file("rmarkdown", "templates", "lectureslides", "resources", "template.tex",
                                          package = "runidue"))
  fmt <- pdf_document(..., template = template)
  return(fmt)
}





