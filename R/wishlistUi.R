wishlistUi <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 4,
             uiOutput(ns("wishlistGenreSelect"))
      ),
      column(width = 4,
             uiOutput(ns("wishlistStateSelect"))
      )
    ),
    fluidRow(
      column(width = 12,
             DTOutput(ns("wishlistDataTable"))
      )
    )
  )
}

