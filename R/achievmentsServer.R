achievmentsServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {


      #### ObserveEvents ####

      # Updates reactive values
      # For the text display
      # Whenever inpoutis changes
      observeEvent(input$achievmentsGenre, {
        isolate(
          values$selectedGenre1 <- input$achievmentsGenre
        )
      })

      #### renderUI ####

      # Select input
      # For the text display
      output$achievmentsGenreSelect <- renderUI({
        ns <- session$ns
        genreList <- c("All", names(sort(table(values$data$genre_niv1), decreasing = TRUE)))
        selectInput(ns("achievmentsGenre"), "Genre :",
                    choices = genreList,
                    selected = values$selectedGenre1)
      })

      #### Counting the checks ####

      # CNL
      output$nChecksCNL <- renderText({
        paste(sum(!is.na(values$data$CNL)), "out of 100")
      })

      # ML
      output$nChecksML <- renderText({
        paste(sum(!is.na(values$data$ML)), "out of 100")
      })

      # MF
      output$nChecksMF <- renderText({
        paste(sum(!is.na(values$data$MF)), "out of 100")
      })

      # GR
      output$nChecksGR <- renderText({
        paste(sum(!is.na(values$data$GR)), "out of 50")
      })

      # BR
      output$nChecksBR <- renderText({
        paste(sum(!is.na(values$data$BR)), "out of 200")
      })

      # BI
      output$nChecksBI <- renderText({
        paste(sum(!is.na(values$data$BI)), "out of 100")
      })


      #### Recap text ####
      output$recapText <- renderUI({
        # Placeholder calculation for the text
        placeHolder <- switch(values$selectedGenre1,
                              All = "writings",,
                              Letters = "epistolary writings",
                              Graphic = "comics",
                              `Non Fiction` = "non fiction writings",
                              Poetic = "poetic writings",
                              Novels = "novel like writings",
                              Theatre = "plays")

        nPages <- ifelse(values$selectedGenre1 == "All",
                         sum(values$data$nb_pages),
                         sum(values$data$nb_pages[values$data$genre_niv1 == values$selectedGenre1]))
        nRead <- ifelse(values$selectedGenre1 == "All",
                         nrow(values$data),
                         nrow(values$data[values$data$genre_niv1 == values$selectedGenre1, ]))
        nBooks <- ifelse(values$selectedGenre1 == "All",
                        length(unique(values$data$id)),
                        length(unique(values$data$id[values$data$genre_niv1 == values$selectedGenre1])))
        nMonths <- ifelse(values$selectedGenre1 == "All",
                          length(unique(values$data$date_lecture)),
                          length(unique(values$data$date_lecture[values$data$genre_niv1 == values$selectedGenre1])))
        nPagesMonth <- prettyNum(floor(nPages / nMonths), big.mark = ",")
        nPagesDay <- prettyNum(floor(nPages / nMonths / (365.25/12)), big.mark = ",")
        nPagesBook <- prettyNum(floor(nPages / nBooks), big.mark = ",")
        nPages <- prettyNum(nPages, big.mark = ",")

        # Text
        HTML(paste(
          paste("I've read", nRead, placeHolder, " (equivalent to", nBooks, "books)."),
          paste("This represents ", nPages, "pages (", nPagesMonth, "per month, ", nPagesDay, "per day)."),
          paste("That makes the average book", nPagesBook, "pages long."),
          sep = '<br/>'
        ))
      })


      #### Prices counting ####

      # Hugo
      output$nPriceHugo <- renderText({
        sum(!is.na(values$data$prix) & values$data$prix == "Hugo")
      })

      # Pulitzer
      output$nPricePulitzer <- renderText({
        sum(!is.na(values$data$prix) & values$data$prix == "Pulitzer")
      })

      # Goncourt
      output$nPriceGoncourt <- renderText({
        sum(!is.na(values$data$prix) & str_detect(values$data$prix, "Goncourt"))
      })

      # Whitbread
      output$nPriceWhitbread <- renderText({
        sum(!is.na(values$data$prix) & values$data$prix == "Whitbread")
      })

      # Booker
      output$nPriceBooker <- renderText({
        sum(!is.na(values$data$prix) & values$data$prix == "Booker")
      })

      # Medicis
      output$nPriceMedicis <- renderText({
        sum(!is.na(values$data$prix) &
              (str_detect(values$data$prix, "Medicis") | str_detect(values$data$prix, "Médicis")))
      })
    })

}
