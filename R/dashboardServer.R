dashboardServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {


      #### ObserveEvents ####

      # Updates reactive values whenever inpout is changed
      # Those only update the reactive values, no other function
      observeEvent(input$dashboardDateRange, {
        values$startDate <- as.Date(input$dashboardDateRange[1])
        values$endDate <- as.Date(input$dashboardDateRange[2])
      })
      observeEvent(input$dashboardUnit, {
        isolate(
          values$unit <- input$dashboardUnit
        )
      })
      observeEvent(input$dashboardGenre, {
        isolate(
          values$genre <- input$dashboardGenre
        )
      })
      observeEvent(input$dashboardGenreType, {
        isolate(
          values$genreType <- input$dashboardGenreType
        )
      })
      observeEvent(input$dashboardLangFormat, {
        isolate(
          values$langFormat <- input$dashboardLangFormat
        )
      })


      #### renderUI ####

      # Date inputs
      output$dashboardDateRangeSelect <- renderUI({ # double time input to set the time serie selection
        ns <- session$ns
        dateRangeInput(ns("dashboardDateRange"), "Time period :",
                       start = values$startDate,
                       end = values$endDate,
                       min = min(values$data$readDate),
                       max = max(values$data$readDate),
                       format = "yyyy-mm", # only interested in a monthly time span
                       startview = "year")
      })

      output$dashboardUnitSelect <- renderUI({ # whether to simply count the rows, or use the number of pages
        ns <- session$ns
        selectInput(ns("dashboardUnit"), "Unit :",
                    choices = c("Books", "Pages"),
                    selected = values$unit)
      })
      # Select inputs for the pie chart
      output$dashboardGenreSelect <- renderUI({ # Genre list
        ns <- session$ns
        selectInput(ns("dashboardGenre"), "Genre :",
                    choices = c("All", names(sort(table(values$data$genre_niv1), decreasing = TRUE))),
                    selected = values$genre)
      })
      output$dashboardGenreTypeSelect <- renderUI({ # which genre columns to use
        ns <- session$ns
        selectInput(ns("dashboardGenreType"), "Sub-genre :",
                    choices = c("Aggregated", "Detailed"),
                    selected = values$genreType)
      })
      output$dashboardLangFormatSelect <- renderUI({ # whether to simply count the rows, or use the number of pages
        ns <- session$ns
        selectInput(ns("dashboardLangFormat"), "Unit :",
                    choices = c("Language", "Format"),
                    selected = values$langFormat)
      })




      #### Time serie ####
      output$timeSeriePlot <- renderPlot({
        # Time period trimming
        plotData <- periodSelection(values)

        x <- unique(values$data$readDate)
        y1 <- by(values$data$n_pages, values$data$readDate, length)
        y2 <- by(values$data$n_pages, values$data$readDate, sum)
        ratio <- max(y1) / max(y2)

        # plot
        ggplot(mapping = aes(x = x)) +
          geom_line(aes(y = y1/ratio),
                    color = "steelblue2", size = 1) +
          geom_line(aes(y = y2),
                    color = "indianred1", size = 1) +

          geom_text(mapping = aes(x = x, y = y1/ratio,
                                  label = y1)) +

          geom_text(mapping = aes(x = x, y = y2,
                                  label = y2)) +

          ggtitle("Monthly readings") +

          scale_y_continuous(
            name = "Number of pages",
            sec.axis = sec_axis(trans = ~ . * ratio,
                                name = "Number of books")
          ) +
          scale_x_date( name = " ")  +
          theme_minimal() +
          theme(
            axis.title.y = element_text(color = "indianred1"),
            axis.title.y.right = element_text(color = "steelblue2"),
          )
      })




      #### Pie Charts ####

      # Title placeholder for the genre pie chart
      output$pieTitle1 <- renderUI({
        HTML(ifelse(values$genre == "All", "Genre", "Sub-Genre"))
      })

      # Number of books/pages per genre
      output$pieGenre <- renderPlot({
        # Time period trimming
        plotData <- periodSelection(values)

        # Variable selection depending on the unit
        if (values$unit == "Books") {
          if(values$genre == "All" & values$genreType == "Aggregated") plotData <- plotData$genre_niv1 # genre selection
          if(values$genre == "All" & values$genreType != "Aggregated") plotData <- plotData$genre_niv2 # sub-genre selection
          # aggregated sub-genre selection with according genre
          if(values$genre != "All" & values$genreType == "Aggregated") plotData <- plotData$genre_niv2_group[plotData$genre_niv1 == values$genre]
          # detailed sub-genre selection with according genre
          if(values$genre != "All" & values$genreType != "Aggregated") plotData <- plotData$genre_niv2[plotData$genre_niv1 == values$genre]

          # Data
          group <- names(sort(table(plotData), decreasing = TRUE))
          val <- round(sort(table(plotData), decreasing = TRUE)/length(plotData)*100, 0)
        } else {
          # Variable selection
          # Same as above, but adding number of pages
          if(values$genre == "All" & values$genreType == "Aggregated") plotData <- plotData[, c("genre_niv1", "n_pages")]
          if(values$genre == "All" & values$genreType != "Aggregated") plotData <- plotData[, c("genre_niv2", "n_pages")]
          if(values$genre != "All" & values$genreType == "Aggregated") plotData <- plotData[plotData$genre_niv1 == values$genre,
                                                                                            c("genre_niv2_group", "n_pages")]
          if(values$genre != "All" & values$genreType != "Aggregated") plotData <- plotData[plotData$genre_niv1 == values$genre,
                                                                                            c("genre_niv2", "n_pages")]

          # Data
          group <- names(table(plotData[, 1]))
          val <- round(by(plotData$n_pages, plotData[, 1], sum)/sum(plotData$n_pages)*100, 0) # sum of the pages instead of only counting the rows
        }

        # plot
        myPieChart(val, group, values)
      })



      # Title placeholder for the language/format pie chart
      output$pieTitle2 <- renderUI({
        HTML(ifelse(values$langFormat == "Language", "Language", "Format"))
      })

      # Number of books/pages per language or format
      output$pieLangFormat <- renderPlot({
        # Time period trimming
        plotData <- periodSelection(values)

        # Variable selection
        var <- ifelse(values$langFormat == "Language", "lang", "formatl")

        # Variable selection depending on the unit
        switch(values$unit,
               Books = {
                 ifelse(values$genre == "All", # filtering if a specific genre is selected
                        plotData <- plotData[, var],
                        plotData <- plotData[, var][plotData$genre_niv1 == values$genre])
                 group <- names(sort(table(plotData), decreasing = TRUE))
                 val <- round(sort(table(plotData), decreasing = TRUE)/length(plotData)*100, 0)
               },
               Pages = {
                 ifelse(values$genre == "All", # same as above, but adding de number of pages
                        plotData <- plotData[, c(var, "n_pages")],
                        plotData <- plotData[, c(var, "n_pages")][plotData$genre_niv1 == values$genre, ])
                 group <- names(table(plotData[, var]))
                 val <- round(by(plotData$n_pages, plotData[, var], sum)/sum(plotData$n_pages)*100, 0) # sum of the pages instead of only counting the rows
               }
               )

        # plot
        myPieChart(val, group, values)
      })
    }
)}
