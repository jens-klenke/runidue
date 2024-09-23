# runidue package

It is a package in latex used for creating lecture slides. The package contains all codes necessary to knit slides. It has predefined environments for writing lemma, corollary, math formulas, etc. By specifying on the respective YAML header, at the start of the slides, some basic aspects such as font size, aspect ratio, etc, of the slides can be changed.

This readme documentation gives a detailed description, using code snippets and screenshots, on what can be achieved using the unidue package.

# Install the latest development version of *runidue* from GitHub:

```{r}
if (!require("devtools")) {
  install.packages("devtools")
}
devtools::install_github("jens-klenke/runidue", ref = "development")
```

The package can be loaded using:

```{r}
library(runidue)
```

Now the package is loaded and is ready to be used.

# YAML header

A YAML header, also known as YAML front matter, is a section at the beginning of a file written in YAML (YAML Ain't Markup Language) format. It's commonly used in Markdown files (.md) and other types of files to provide metadata or configuration information about the content of the file.

In Markdown files, the YAML header is typically enclosed between triple dashes `- - -` at the beginning and end. Within the YAML header, you can specify key-value pairs separated by colons `:`. These key-value pairs provide information such as title, author, date, tags, etc., depending on the purpose of the file.

A typical YAML header which uses this package looks like:

`````
---
title: "Title"
author: "Author"
date: "Term X"
output: runidue::lectureslides
---
`````

Several modifications to the lecture slides, can be done using the YAML header. To get more information about the specifications, the follwoing code can be used:

```{r}
?runidue::lectureslides
```

An example of a more elaborate YAML header is as follows:

````
---
title: "Title of Your Document"
author: "Author Name"
date: "February 27, 2024"
output: 
  runidue::lectureslides:
    lang: "en"
    theme: "default"
    highlight: "zenburn"
    slide_level: 2
    incremental: true
    colorlinks: true
natbib: true
natbiboptions:
    - "round"
    - "semicolon"
biblio-style: "plainnat"
csl-refs: true
urlcolor: "red"
citecolor: "green"
mainfont: "Times New Roman"
papersize: "a4paper"
fontenc: "T1"
linestretch: 1.2
fontfamily: "times"
toc: true
toc_depth: 2
fontsize: 8pt
classoption: aspectratio=169
---
````
In the above YAML header, `title`, `author`, `date`, `output`, `natbib`, `natbiboptions`, `biblio-style`, csl-refs, `urlcolor`, `citecolor`, `mainfont`, `papersize`, `fontenc`, `linestretch`, `fontfamily`, `toc`, `toc_depth`, `fontsize`, and `classoption` are keys specifying different properties of the document. These keys are aligned at the same level. A description of each of the keys are:

| Key | Use |
| ------- | ----------- |
| `title` |  Specifies the title of the document. |
| `author` | Specifies the author(s) of the document. |
| `date` | Specifies the date of the document. |
| `output` | Specifies the output format and options for the document. In our case, the format is specified in lectureslides.tex |
| `natbib` | Specifies whether to use the `natbib` citation package, which provides enhanced citation capabilities for LaTeX documents. |
| `natbiboptions` | Specifies additional options for the `natbib` citation package. |
| `biblio-style` | Specifies the bibliography style to be used. |
| `csl-refs` | Specifies whether to use CSL (Citation Style Language) references. |
| `urlcolor` |  Specifies the color for URLs in the document. |
| `citecolor` | Specifies the color for citations in the document. | 
| `mainfont` |  Specifies the main font to be used in the document. |
| `papersize` |  Specifies the size of the paper for the document. |
| `fontenc` | Specifies the font encoding to be used. |
| `linestretch` | Specifies the line spacing for the document. |
| `fontfamily` | Specifies the font family to be used in the document. |
| `toc` |  Specifies whether to include a table of contents in the document. |
| `toc_depth` | Specifies the depth of the table of contents. |
| `fontsize` | Specifies the font size to be used in the document. |
| `classoption` | Specifies additional options for the document class. |

In the `òutput` key, `runidue::lectureslides` as output option is specified, a further specification used in this YAML header is as follows:

| Sub Key | Use | Example |
| ------- | ----------- | --------------:|
| `lang` |  Specifies the language of the slides. | "en" |
| `theme` | Specifies the theme or style of the slides. | "default" |
| `highlight` | Specifies the syntax highlighting style to be used in code snippets within the slides.  | "zenburn"
| `slide_level` | Specifies the Markdown heading level that should be treated as a new slide. In Markdown, headings are denoted by `#` characters. | "2" |
| `incremental` | This setting enables incremental rendering of slide contents, meaning elements on the slide will appear incrementally, often one after another, as the presenter advances through the slides. This is useful for revealing content step by step during a presentation. | "true" |
| `colorlinks` |  This setting specifies whether links within the slides should be displayed in color. When set to true, links will be colored, providing visual differentiation from regular text. | "true" |




# Environments

Several environments which are predefined in the package, can be called during knitting the files. These environments are used for highlighting Lemma, corollary, proofs, examples, math functions, etc. A comprehensive lists of all such environments which the package offers is as follow:

| Command | Use | Color |
| ------- | ----------- | --------:|
| `thmn` | Theorem | Blue |
| `lem` | Lemma | Blue |
| `cor` | Corollary | Blue |
| `defn` | Definition | Green |
| `ass` | Annahme or Assumption | Blue |
| `rem` | Anmerkung or Remark | Blue |
| `prop` | Proposition | Blue |
| `xmpl` | Beispiel | Yellow |
| `que` | Frage or Question | Blue |
| `exe` | Aufgabe or Exercise | Blue |
| `mthmn` | Mathematical Theorem | Blue |

An example of implementation of an environment is as follows: 

```{r}
\xmpl[Heading of the example]
The example itself..
\endxmpl
```

The above environment looks like:

![](some_ss/example_ss.png)

### Long Environments

Sometimes, content of the environment can be enormous and can exceed the limits of slide. In such a case, an environment can be extend or continued over to the next slides. An example of how this can be achieved is as follows:

```{r}
## Example of a long environment
\xmpl[Example of something]
A very long example which may not fit the slide
\endxmpl


## Continuation of the previous example
\xmpl[*]
This is the continuation of the long example in the next slide.
\endxmpl
```

The output is as follows:

![](some_ss/example_continuation_ss.png)



By using `\xmpl[*]` the the previous environment can be continued. The usage of `\xmpl[*]` is important as it keeps the numbering of the current environment same as the previous one. 



### Kahoot boxes

Kahoot boxes can be implemented using following code:

```{r}
\kahoot {Kahoot Heading} Kahoot Contents \endkahoot
```

The above implemented Kahoot box looks like:


![](some_ss/kahoot_ss.png)



# An example

[Here](https://github.com/jens-klenke/runidue/blob/development/inst/rmarkdown/templates/lectureslides/skeleton/skeleton.Rmd) an example of implementation of slides using `runidue` package can be seen. The output is [here](https://cyan-conchita-58.tiiny.site). 









