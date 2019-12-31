if(!exists("htmlwidgets_deps", mode="function")) source("R/add_htmlwidgets_deps.R")

fix_widgets <- function() {
  rstudioapi::getSourceEditorContext()
  p <- rstudioapi::getSourceEditorContext()['path']
  p <- path.expand(unlist(p))
  out <- rmarkdown::render(p, run_pandoc = FALSE, clean = TRUE)
  knit_meta <- attr(out, 'knit_meta')
  htmlwidgets_deps(p, knit_meta)
}