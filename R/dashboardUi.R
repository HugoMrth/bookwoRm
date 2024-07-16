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
             uiOutput(ns("dashboardUnitSelect"))
      ),
      column(width = 2,
             uiOutput(ns("dashboardGenreSelect"))
      ),
      column(width = 2,
             uiOutput(ns("dashboardGenreTypeSelect"))
      ),
      column(width = 2,
             uiOutput(ns("dashboardLangFormatSelect"))
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
             h3(htmlOutput(ns("pieTitle1")))
             ),
      column(width = 6, align="center",
             h3(htmlOutput(ns("pieTitle2")))
             )
    ),
    fluidRow(
      column(width = 6,
             plotOutput(ns("pieGenre"))
      ),
      column(width = 6,
             plotOutput(ns("pieLangFormat"))
      )
    )
  )
}

