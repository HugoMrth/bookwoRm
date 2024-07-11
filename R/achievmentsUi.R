achievmentsUi <- function(id) {
  ns <- NS(id)
  tagList(
    # First row of boxes
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
          column(width = 4,box(
            title = h1("GoodReads.com"), width = NULL, solidHeader = TRUE, status = "warning",
            h3(textOutput(ns("nChecksGR"))))
          ),
          column(width = 4,box(
            title = h1("Big Read"), width = NULL, solidHeader = TRUE, status = "warning",
            h3(textOutput(ns("nChecksBR"))))
          ),
          column(width = 4,
                 box(title = h1("Bibliothèque Idéale"), width = NULL, solidHeader = TRUE, status = "success",
                     h3(textOutput(ns("nChecksBI"))))
          )
        )
  )
}

