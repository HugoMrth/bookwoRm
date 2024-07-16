booksUi <- function(id) {
  ns <- NS(id)
  tagList(
    # Inputs Row
    fluidRow(
      column(width = 4,
             uiOutput(ns("booksYearRangeSelect"))
      ),
      column(width = 2,
             uiOutput(ns("booksBinSizeYearSelect"))
      ),
      column(width = 2,
             uiOutput(ns("booksBinSizePagesSelect"))
      )
    ),
    fluidRow(
      column(width = 6,
             plotOutput(ns("pubHistPlot"))
      ),
      column(width = 6,
             plotOutput(ns("pagesHistPlot"))
      )
    )

  )
}

