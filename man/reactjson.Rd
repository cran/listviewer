% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reactjson.R
\name{reactjson}
\alias{reactjson}
\title{Edit R Data with 'react-json'}
\usage{
reactjson(
  listdata = list(),
  name = "root",
  theme = "rjv-default",
  iconStyle = c("circle", "triangle", "square"),
  indentWidth = 4,
  collapsed = FALSE,
  collapseStringsAfterLength = FALSE,
  groupArraysAfterLength = 100,
  enableClipboard = TRUE,
  displayObjectSize = TRUE,
  displayDataTypes = TRUE,
  onEdit = TRUE,
  onAdd = TRUE,
  onDelete = TRUE,
  onSelect = TRUE,
  sortKeys = FALSE,
  width = NULL,
  height = NULL,
  elementId = NULL
)
}
\arguments{
\item{listdata}{\code{list} or \code{String} data to view.  Although designed for \code{lists}, \code{listdata} can
be any data source that can be rendered into \code{JSON} with \code{jsonlite}.  Alternately,
\code{listdata} could be a \code{String} of valid \code{JSON}.  This might be helpful
when dealing with an API response.}

\item{name}{\code{string} name of the root node.  Default is \code{"root"}.}

\item{theme}{\code{string} name of the theme.  Default is \code{"rjv-default"}.}

\item{iconStyle}{\code{string} shape for the expand/collapse icon. Options are circle,
triangle, and square with the default as \code{"circle"}.}

\item{indentWidth}{\code{integer} for the indent width for nested objects. Default is \code{4}.}

\item{collapsed}{\code{logical} or \code{integer}.  Use \code{logical} to expand/collapse all nodes.
Use \code{integer} to specify the depth at which to collapse.}

\item{collapseStringsAfterLength}{\code{integer} for the length at which strings will be cut off
Collapsed strings are followed by an ellipsis. String content can be expanded and
collapsed by clicking on the string value.}

\item{groupArraysAfterLength}{\code{integer} for the count at which arrays will be displayed in groups.
Groups are displayed with bracket notation and can be expanded and collapsed.
by clicking on the brackets.}

\item{enableClipboard}{\code{logical} whether the user can copy objects and arrays
clicking on the clipboard icon. Copy callbacks are supported. Default is \code{TRUE}.}

\item{displayObjectSize}{\code{logical} whether or not objects and arrays are labeled with size.
Default is \code{TRUE}.}

\item{displayDataTypes}{\code{logical} whether or not data type labels prefix values.
Default is \code{TRUE}.}

\item{onEdit, onAdd, onDelete, onSelect}{\code{htmlwidgets::JS} or \code{logical}
to control behavior on edit, add, delete, and select.  If \code{htmlwidgets::JS}
function is provided, then the function will be performed on each event.  If
\code{logical} then \code{TRUE} means that the event will be passed to Shiny and
\code{FALSE} will disable the behavior.  The default is \code{TRUE}.}

\item{sortKeys}{\code{logical} whether or not to sort object keys.  Default is \code{FALSE}.}

\item{width}{integer in pixels defining the width of the \code{div} container.}

\item{height}{integer in pixels defining the height of the \code{div} container.}

\item{elementId}{character to specify valid \code{CSS} id of the
htmlwidget for special situations in which you want a non-random
identifier.}
}
\description{
Edit R Data with 'react-json'
}
\examples{
\dontrun{

library(listviewer)

# use reactR for React dependencies
# devtools::install_github("timelyportfolio/reactR")
library(reactR)

reactjson()

reactjson(head(mtcars,4))
reactjson(I(jsonlite::toJSON(head(mtcars,5))))

library(shiny)

shinyApp(
  ui = reactjson(
    list(x=1,msg="react+r+shiny",opts=list(use_react=FALSE)),
    elementId = "json1"
  ),
  server = function(input, output, session){
    observeEvent(
      input$json1_change,
      str(input$json1_change)
    )
  }
)


# gadget to use as editor
library(miniUI)
ui <- miniUI::miniPage(
  miniUI::miniContentPanel(
    reactjson(
      list(x=1,msg="react+r+shiny",opts=list(use_react=FALSE)),
      elementId = "rjeditor"
    )
  ),
  miniUI::gadgetTitleBar(
    "Edit",
    right = miniUI::miniTitleBarButton("done", "Done", primary = TRUE)
  )
)

server <- function(input, output, session) {
  shiny::observeEvent(input$done, {
    shiny::stopApp(
      input$rjeditor_change
    )
  })

  shiny::observeEvent(input$cancel, { shiny::stopApp (NULL) })
}

runGadget(
  ui,
  server,
  viewer = shiny::paneViewer()
)

}
}
