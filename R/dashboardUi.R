dashboardUi <- function(id) {
  ns <- NS(id)
  tagList(
    # Inputs Row
    fluidRow(
      column(width = 4,
             uiOutput(ns("dashboardDateRangeSelect"))
             # ,bsTooltip(id = ns("dashboardDateRange"),
             #           title = "This affects every graphs.",
             #           "right", options = list(container = "body"))
      ),
      column(width = 2,
             uiOutput(ns("dashboardGenreSelect"))
      ),
      column(width = 2,
             uiOutput(ns("dashboardGenreTypeSelect"))
      ),
      column(width = 2,
             uiOutput(ns("dashboardUnitSelect"))
      )
    ),

    # Time serie display
    fluidRow(
      column(width = 12, align="center",
             h3("Monthly readings")
      )
    ),
    fluidRow(
      column(width = 12,
             plotOutput(ns("timeSeriePlot"))
      )
    ),

    # Pie Charts display
    fluidRow(
      column(width = 6, align="center",
             h3("Genre")
             ),
      column(width = 6, align="center",
             h3("Language")
             )
    ),
    fluidRow(
      column(width = 6,
             plotOutput(ns("pieGenre"))
      ),
      column(width = 6,
             plotOutput(ns("pieLang"))
      )
    )
  )
}

