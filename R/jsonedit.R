#' View \code{Lists} with \code{'jsoneditor'}
#'
#' \code{jsonedit} provides a flexible and helpful interactive tree-like view of \code{lists}
#'   or really any R dataset that can be represented as \code{JSON}.
#'   Eventually, this could become a very nice way to not only view but also modify R data using
#'   Shiny.
#'
#' @param listdata \code{list} or \code{String} data to view.  Although designed for \code{lists}, \code{listdata} can
#'          be any data source that can be rendered into \code{JSON} with \code{jsonlite}.  Alternately,
#'          \code{listdata} could be a \code{String} of valid \code{JSON}.  This might be helpful
#'          when dealing with an API response.
#' @param mode \code{string} for the initial view from \code{modes}.  \code{'tree'} is the default.
#' @param modes \code{string} \code{c('tree', 'text', 'table')} will be the default, since
#'          these are all the modes currently supported by \code{jsoneditor}.
#' @param ... \code{list} of other options for \code{jsoneditor}.  This is a temporary way
#'          of trying other options in \code{jsoneditor}.  In the future, this will be eliminated
#'          in favor of specific, more self-documenting and helpful arguments.
#' @param width integer in pixels defining the width of the \code{div} container.
#' @param height integer in pixels defining the height of the \code{div} container.
#' @param elementId character to specify valid \code{CSS} id of the
#'          htmlwidget for special situations in which you want a non-random
#'          identifier.
#' @examples
#'    library(listviewer)
#'
#'    # using the data from the jsoneditor simple example
#'    #  in R list form
#'    jsonedit(
#'      list(
#'        array = c(1,2,3)
#'        ,boolean = TRUE
#'        ,null = NULL
#'        ,number = 123
#'        ,object = list( a="b", c="d" )
#'        ,string = "Hello World"
#'      )
#'    )
#'
#'    # jsonedit also works with a JSON string
#'    jsonedit(
#'      '{"array" : [1,2,3] , "boolean" : true, "null" : null, "number": 123}'
#'    )
#'
#'    # also works with most data.frames
#'    jsonedit( mtcars )
#'
#'    # helpful interactive view of par
#'    jsonedit( par() )
#'
#' @import htmlwidgets
#'
#' @export
jsonedit <- function(
    listdata = NULL
    , mode = 'tree'
    , modes = c('text', 'tree', 'table')
    , ...
    , width = NULL
    , height = NULL
    , elementId = NULL
) {

  listdata <- list_proper_form(listdata)

  # forward options using x
  x = list(
    data = listdata
    ,options = list(mode = mode, modes = modes, ...)
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'jsonedit',
    x,
    width = width,
    height = height,
    package = 'listviewer',
    elementId = elementId
  )
}

#' Shiny Bindings for `jsonedit`
#'
#' Output and render functions for using jsonedit within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a jsonedit
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name jsonedit-shiny
#'
#' @export
jsoneditOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'jsonedit', width, height, package = 'listviewer')
}

#' @rdname jsonedit-shiny
#' @export
renderJsonedit <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, jsoneditOutput, env, quoted = TRUE)
}
