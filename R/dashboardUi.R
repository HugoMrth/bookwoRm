dashboardUi <- function(id) {
  ns <- NS(id)
  tagList(
    # Pie charts
    fluidRow(
      column(width = 2,
             uiOutput(ns("dashboardGenre1Select"))
      ),
      column(width = 2,
             uiOutput(ns("dashboardGenre2Select"))
      )
    ),
    fluidRow(
      column(width = 6,
             plotOutput(ns("pieBooks"))
      ),
      column(width = 6,
             plotOutput(ns("piePages"))
      )
    )

  )
}

