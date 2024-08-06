authorsUi <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 12,
             plotOutput(ns("authorHistPlot"))
      )
    )

  )
}

