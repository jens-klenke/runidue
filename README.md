# runidue package

It is a package in latex used for creating lecture slides. The package contains all codes necessary to knit slides. It has predefined environments for writing lemma, corollary, math formulas, etc. By specifying on the respective YAML header, at the start of the slides, some basic aspects such as font size, aspect ratio, etc, of the slides can be changed.

This readme documentation gives a detailed description, using code snippets and screenshots, on what can be achieved using the unidue package.

# Install the latest development version of *runidue* from GitHub:

```{r}
if (!require("devtools")) {
  install.packages("devtools")
}
devtools::install_github("jens-klenke/runidue", ref = "vineet")
```
# ToDo

&check; Logo logic &mdash; old logic introduces empty line which breaks the code
- Set color parameter (Note - Document all the predefined function for easy use) (Done) 
- Solve warnings in Pandoc, e.g. `self_contained` (Done)
- Make a new class for quizzes, were the logo can be set (Done)
- Keep intermediate files like `aux` &mdash; maybe it already is solved in branch `dev` &mdash; please check (Done)
- Yannicks Comments
- Envoirmnets in German and English; use same logic as for [institute](https://github.com/jens-klenke/runidue/blob/dev/inst/rmarkdown/templates/lectureslides/resources/lectureslides.tex#L475).

# Workflow 

`devtools::install()`

# Environments

Several environments which are predefined in the package, can be called during knitting the files. These environments are used for highlighting Lemma, corollary, proofs, examples, math functions, etc. A comprehensive lists of all such environments which the package offers is as follow:

| Command | Use | Default Color |
| ------- | ----------- | --------:|
| `theorem_box_color` | Theorem | Blue |
| `lemma_box_color` | Lemma | Blue |
| `corollary_box_color` | Corollary | Blue |
| `definition_box_color` | Definition | Green |
| `assumption_box_color` | Annahme or Assumption | Blue |
| `remark_box_color` | Anmerkung or Remark | Blue |
| `proposition_box_color` | Proposition | Blue |
| `beispiel_box_color` | Beispiel | Yellow |
| `frage_box_color` | Frage or Question | Blue |
| `exercise_box_color` | Aufgabe or Exercise | Blue |
| `math_theorem_box_color` | Mathematical Theorem | Blue |

An example of implementation of an environment is as follows: 

```
--- 
title: "Induktive Statistik"
author: "Prof. Dr. Christoph Hanck"
date: "Sommersemester 2025"
output: 
  runidue::lectureslides:
    lang: "en" 
    keep_tex: true
    
exercise_box_color: yellow
---
```
