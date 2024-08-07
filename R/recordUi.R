recordUi <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 4,
             uiOutput(ns("recordGenreSelect"))
      ),
      column(width = 4,
             uiOutput(ns("recordStateSelect"))
      )
    ),
    fluidRow(
      column(width = 12,
             DTOutput(ns("recordDataTable"))
      )
    )

  )
}

