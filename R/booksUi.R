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
      ),
      column(width = 2,
             uiOutput(ns("booksGenreSelect"))
      )
    ),
    fluidRow(
      column(width = 4,
             plotOutput(ns("genreHistPlot"))
             ),
      column(width = 8,
             plotOutput(ns("pubHistPlot"))
      )
    ),
    fluidRow(
      column(width = 8,
             plotOutput(ns("pagesHistPlot"))
      ),
      column(width = 4,
             plotOutput(ns("boxplotRatings"))
      )
    )

  )
}

