quotesUi <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 2,
             uiOutput(ns("quotesThemeSelect"))
      ),
      column(width = 2,
             uiOutput(ns("quotesRankSelect"))
      ),
      column(width = 5,
             h1(htmlOutput(ns("GOATsText")))
      ),
      actionButton(ns("randomQuote"), h1("Random Quote"), class = "btn-success")
    ),
    fluidRow(
      column(width = 12,
             DTOutput(ns("quotesDataTable"))
      )
    )
  )
}

