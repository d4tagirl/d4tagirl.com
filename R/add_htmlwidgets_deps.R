if(!exists("html_dependency_resolver", mode="function")) source("R/rmarkdown_internal_funs.R")

#' Configure htmlwidgets dependencies for a knitr-jekyll blog
#'
#' Unlike static image plots, the outputs of htmlwidgets dependencies also have
#' Javascript and CSS dependencies, which are not by default processed by knitr.
#' \code{htmlwdigets_deps} provides a system to add the dependencies to a Jekyll
#' blog. Further details are available in the following blog post:
#' \url{http://brendanrocks.com/htwmlwidgets-knitr-jekyll/}.
#'
#' @param a The file path for the input file being knit
#' @param knit_meta The dependencies object.
#' @param lib_dir The directory where the htmlwidgets dependency source code can
#'   be found (e.g. JavaScript and CSS files)
#' @param includes_dir The directory to add the HTML file to
#' @param always Should dependency files always be produced, even if htmlwidgets
#'   are not being used?
#'
#' @return Used for it's side effects.
#' @export
htmlwidgets_deps <- function(a, knit_meta = knitr::knit_meta(),
                             lib_dir      = "static/htmlwidgets_deps",
                             includes_dir = "layouts/partials/htmlwidgets/",
                             always       = FALSE) {
  
  # If the directories don't exist, create them
  dir.create(lib_dir, showWarnings = FALSE, recursive = TRUE)
  dir.create(includes_dir, showWarnings = FALSE, recursive = TRUE)
  
  # Copy the libraries from the R packages to the 'htmlwidgets_deps' dir, and
  # obtain the html code required to import them
  deps_str <- html_dependencies_to_string(knit_meta, lib_dir, ".")
  
  # Write the html dependency import code to a file, to be imported by the
  # liquid templates
  deps_file <- paste0(
    includes_dir,
    gsub(".Rmarkdown$", ".html", basename(a[1]))
  )
  
  # Write out the file if either, the dependencies string has anything to add,
  # or, if the always parameter has been set to TRUE (useful for those building
  # with GitHub pages)
  if(always | !grepl("^[[:space:]]*$", deps_str))
    writeLines(deps_str, deps_file)
}


#' @keywords internal
#' Adapted from rmarkdown:::html_dependencies_as_string
html_dependencies_to_string <- function (dependencies, lib_dir, output_dir) {
  
  # Flatten and resolve html deps
  dependencies <- html_dependency_resolver(
    flatten_html_dependencies(dependencies)
  )
  
  if (!is.null(lib_dir)) {
    dependencies <- lapply(
      dependencies, htmltools::copyDependencyToDir, lib_dir
    )
    
    dependencies <- lapply(
      dependencies, htmltools::makeDependencyRelative, output_dir
    )
  }
  
  # A function to add Jekyll boilerplate
  prepend_baseurl <- function(path){
    # If the url doesn't start "/", make sure that it does
    path <- ifelse(!grepl("^/", path), paste0("/", path), path)
    
    # remove /static
    path <- ifelse(startsWith(path, "/static"), substring(path, 8), path)
  }
  
  htmltools::renderDependencies(
    dependencies, "file",
    encodeFunc = identity,
    hrefFilter = prepend_baseurl
  )
}