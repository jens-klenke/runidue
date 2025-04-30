# runidue package

It is a package in latex used for creating lecture slides. The package contains all codes necessary to knit slides. It has predefined environments for writing lemma, corollary, math formulas, etc. By specifying on the respective YAML header, at the start of the slides, some basic aspects such as font size, aspect ratio, etc, of the slides can be changed.

This readme documentation gives a detailed description, using code snippets and screenshots, on what can be achieved using the unidue package.

# Install the latest development version of *runidue* from GitHub:

```{r}
if (!require("devtools")) {
  install.packages("devtools")
}
devtools::install_github("jens-klenke/runidue", ref = "dev")
```
# ToDo

&check; Logo logic &mdash; old logic introduces empty line which breaks the code
- Set color parameter
- Solve warnings in Pandoc, e.g. `self_contained`
- Make a new class for quizzes, were the logo can be set
- Keep intermediate files like `aux` &mdash; maybe it already is solved in branch `dev` &mdash; please check 
- Yannicks Comments
- Envoirmnets in German and English; use same logic as for [institute](https://github.com/jens-klenke/runidue/blob/dev/inst/rmarkdown/templates/lectureslides/resources/lectureslides.tex#L475).

# Workflow 

`devtools::install()`