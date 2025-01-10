achievmentsUi <- function(id) {
  ns <- NS(id)
  tagList(
    # Counting the number of checks in the references lists
        fluidRow(
          column(width = 4,
                 box(title = h1("Norvegian Circle"), width = NULL, solidHeader = TRUE, status = "success",
                     h3(textOutput(ns("nChecksCNL"))))
          ),
          column(width = 4,
                 box(title = h1("Modern Library"), width = NULL, solidHeader = TRUE, status = "primary",
                     h3(textOutput(ns("nChecksML"))))
          ),
          column(width = 4,
                 box(title = h1("Monde/Fnac"), width = NULL, solidHeader = TRUE, status = "primary",
                     h3(textOutput(ns("nChecksMF"))))
          )
        ),
        fluidRow(
          column(width = 3,box(
            title = h1("GoodReads.com"), width = NULL, solidHeader = TRUE, status = "warning",
            h3(textOutput(ns("nChecksGR"))))
          ),
          column(width = 3,box(
            title = h1("Big Read"), width = NULL, solidHeader = TRUE, status = "warning",
            h3(textOutput(ns("nChecksBR"))))
          ),
          column(width = 3, box(
            title = h1("Bibliothèque Idéale"), width = NULL, solidHeader = TRUE, status = "success",
            h3(textOutput(ns("nChecksBI"))))
          ),
          column(width = 3, box(
            title = h1("BBC Non Fiction"), width = NULL, solidHeader = TRUE, status = "success",
            h3(textOutput(ns("nChecksNF"))))
          )
        ),
        # Recap text
        fluidRow(
          column(width = 2,
                 uiOutput(ns("achievmentsGenreSelect"))
          ),
          column(width = 10,
                 h1(htmlOutput(ns("recapText")))
          )
        ),
        # Counting the number of prices in the corresponding column
        fluidRow(br(),
          column(width = 4,
                 box(title = h1("Hugo"), width = NULL, solidHeader = TRUE, status = "success",
                     h3(textOutput(ns("nPriceHugo"))))
          ),
          column(width = 4,
                 box(title = h1("Pulitzer"), width = NULL, solidHeader = TRUE, status = "primary",
                     h3(textOutput(ns("nPricePulitzer"))))
          ),
          column(width = 4,
                 box(title = h1("Goncourt"), width = NULL, solidHeader = TRUE, status = "primary",
                     h3(textOutput(ns("nPriceGoncourt"))))
          )
        ),
        fluidRow(
          column(width = 4,box(
            title = h1("Whitbread"), width = NULL, solidHeader = TRUE, status = "warning",
            h3(textOutput(ns("nPriceWhitbread"))))
          ),
          column(width = 4,box(
            title = h1("Booker"), width = NULL, solidHeader = TRUE, status = "warning",
            h3(textOutput(ns("nPriceBooker"))))
          ),
          column(width = 4,
                 box(title = h1("Medicis"), width = NULL, solidHeader = TRUE, status = "success",
                     h3(textOutput(ns("nPriceMedicis"))))
          )
        )
  )
}

