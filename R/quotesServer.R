quotesServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {

      #### ObserveEvents ####
      observeEvent(input$quotesTheme, {
        isolate(
          values$theme <- input$quotesTheme
        )
      })
      observeEvent(input$quotesRank, {
        isolate(
          values$rank <- input$quotesRank
        )
      })
      observeEvent(input$randomQuote, {
        isolate(
        # Show a modal when the button is pressed
        res <- values$quotes[sample(1:nrow(values$quotes), 1),]
        )
        shinyalert(title = res$Author, text = res$Quote,
                   closeOnEsc = TRUE,
                   closeOnClickOutside = TRUE)
      })


      #### renderUI ####
      output$quotesThemeSelect <- renderUI({ # Genre list
        ns <- session$ns
        selectInput(ns("quotesTheme"), "Theme :",
                    choices = c("All", names(sort(table(values$quotes$Theme), decreasing = TRUE))),
                    selected = values$theme)
      })
      output$quotesRankSelect <- renderUI({ # States list
        ns <- session$ns
        selectInput(ns("quotesRank"), "Rank :",
                    choices = c("All", "Good", "All time best"),
                    selected = values$rank)
      })


      #### Outputs ####
      output$GOATsText <- renderUI({
        # Placeholder calculation for the text
        placeHolder <- paste(names(sort(table(values$quotes$Author), decreasing = TRUE))[sort(table(values$quotes$Author), decreasing = TRUE) > 8],
                             collapse = ", ")

        # Text
        HTML(paste(
          paste("Authors I've cited the most are : "),
          placeHolder,
          sep = '<br/>'
        ))
      })
      #### __ Text ####

      #### __Datatable ####
      output$quotesDataTable <- renderDT({
        ifelse(values$theme == "All",
               rowSel <- 1:nrow(values$quotes),
               rowSel <- which(values$quotes$Theme == values$theme))
        res <- values$quotes[rowSel, ]

        ifelse(values$rank == "All",
               rowSel <- 1:nrow(res),
               ifelse(values$rank == "Good",
                      rowSel <- which(res$Ranking == "O" | res$Ranking == "X"),
                      rowSel <- which(res$Ranking == "O")))
        res <- res[rowSel, c("Author", "Quote")]

        res[nrow(res):1, ]
      },
      rownames = FALSE,
      options = list(
        pageLength = 20
      )
      )
    })

}
