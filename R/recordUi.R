recordUi <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 12,
             DTOutput(ns("recordDataTable"))
      )
    )

  )
}

