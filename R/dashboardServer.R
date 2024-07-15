dashboardServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {


      #### ObserveEvents ####

      # Updates reactive values
      # For the text display
      # Whenever inpoutis changes
      observeEvent(input$dashboardGenre1, {
        isolate(
          values$selectedGenre1 <- input$dashboardGenre1
        )
      })
      observeEvent(input$dashboardGenre2, {
        isolate(
          values$selectedGenre2 <- input$dashboardGenre2
        )
      })


      #### renderUI ####

      # Select input
      # For the pie chart
      output$dashboardGenre1Select <- renderUI({
        ns <- session$ns
        genreList <- c("All", names(sort(table(values$data$genre_niv1), decreasing = TRUE)))
        selectInput(ns("dashboardGenre1"), "Genre :",
                    choices = genreList,
                    selected = values$selectedGenre1)
      })
      output$dashboardGenre2Select <- renderUI({
        ns <- session$ns
        genreList <- c("Aggregated", "Detailed")

        selectInput(ns("dashboardGenre2"), "Sub-genre :",
                    choices = genreList,
                    selected = values$selectedGenre2)
      })




      #### Pie Charts ####

      # Number of books
      output$pieBooks <- renderPlot({
        # Variable selection
        if(values$selectedGenre1 == "All" & values$selectedGenre2 == "Aggregated") plotData <- values$data$genre_niv1
        if(values$selectedGenre1 == "All" & values$selectedGenre2 != "Aggregated") plotData <- values$data$genre_niv2
        if(values$selectedGenre1 != "All" & values$selectedGenre2 == "Aggregated") plotData <- values$data$genre_niv2_group[values$data$genre_niv1 == values$selectedGenre1]
        if(values$selectedGenre1 != "All" & values$selectedGenre2 != "Aggregated") plotData <- values$data$genre_niv2[values$data$genre_niv1 == values$selectedGenre1]


        # Data
        group <- names(sort(table(plotData), decreasing = TRUE))
        val <- round(sort(table(plotData), decreasing = TRUE)/length(plotData)*100, 0)
        label <- paste0(val, "%")
        label[val < 5] <- ""


        ggplot(mapping = aes(x = "", y = val, fill = group)) +
          geom_bar(stat = "identity", width = 1) +
          geom_text(aes(label = label),
                    position = position_stack(vjust = 0.5)) +
          coord_polar("y", start = 0) +

          scale_fill_brewer(palette = "Pastel1") +
          guides(fill = guide_legend(title = "Genre")) +

          theme_void() +
          ggtitle("Books")
      })



      # Number of pages
      output$piePages <- renderPlot({
        # Variable selection
        if(values$selectedGenre1 == "All" & values$selectedGenre2 == "Aggregated") plotData <- values$data[, c("genre_niv1", "nb_pages")]
        if(values$selectedGenre1 == "All" & values$selectedGenre2 != "Aggregated") plotData <- values$data[, c("genre_niv2", "nb_pages")]
        if(values$selectedGenre1 != "All" & values$selectedGenre2 == "Aggregated") plotData <- values$data[values$data$genre_niv1 == values$selectedGenre1,
                                                                                                           c("genre_niv2_group", "nb_pages")]
        if(values$selectedGenre1 != "All" & values$selectedGenre2 != "Aggregated") plotData <- values$data[values$data$genre_niv1 == values$selectedGenre1,
                                                                                                           c("genre_niv2", "nb_pages")]

        # Data
        group <- names(table(plotData[, 1]))
        val <- round(by(plotData$nb_pages, plotData[, 1], sum)/sum(plotData$nb_pages)*100, 0)
        label <- paste0(val, "%")
        label[val < 5] <- ""


        ggplot(mapping = aes(x = "", y = val, fill = group)) +
          geom_bar(stat = "identity", width = 1) +
          geom_text(aes(label = label),
                    position = position_stack(vjust = 0.5)) +
          coord_polar("y", start = 0) +

          scale_fill_brewer(palette = "Pastel1") +
          guides(fill = guide_legend(title = "Genre")) +

          theme_void() +
          ggtitle("Pages")
      })


    })

}
