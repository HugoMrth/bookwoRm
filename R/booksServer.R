booksServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {


      #### ObserveEvents ####
      observeEvent(input$booksYearRange, {
          values$startYear <- input$booksYearRange[1]
          values$endYear <- input$booksYearRange[2]
      })
      observeEvent(input$booksBinSizeYear, {
        isolate(
          values$binSizeYear <- input$booksBinSizeYear
        )
      })
      observeEvent(input$booksBinSizePages, {
        isolate(
          values$binSizePages <- input$booksBinSizePages
        )
      })
      observeEvent(input$booksGenre, {
        isolate(
          values$genre <- input$booksGenre
        )
      })


      #### renderUI ####
      output$booksYearRangeSelect <- renderUI({ # whether to simply count the rows, or use the number of pages
        ns <- session$ns
        numericRangeInput(ns("booksYearRange"), "Period :",
                    value = c(values$startYear, values$endYear),
                    min = min(values$data$pubDate),# - (min(values$data$pubDate) %% 100),
                    max = max(values$data$pubDate),# + (100 - max(values$data$pubDate) %% 100),
                    step = 100)
      })
      output$booksBinSizeYearSelect <- renderUI({
        ns <- session$ns
        selectInput(ns("booksBinSizeYear"), "Time span :",
                    choices = c("5 years", "10 years", "50 years", "100 years", "500 years"),
                    selected = values$binSizeYear)
      })
      output$booksBinSizePagesSelect <- renderUI({
        ns <- session$ns
        selectInput(ns("booksBinSizePages"), "Page span :",
                    choices = c("10 pages", "50 pages", "100 pages", "250 pages"),
                    selected = values$binSizePages)
      })
      output$booksGenreSelect <- renderUI({ # Genre list
        ns <- session$ns
        selectInput(ns("booksGenre"), "Genre :",
                    choices = c("All", names(sort(table(values$data$genre_niv1), decreasing = TRUE))),
                    selected = values$genre)
      })


  #### Plots ####

  # Histogram of the publication date
  output$pubHistPlot <- renderPlot({
    ggplot(mapping = aes(x = values$data$pubDate)) +
      geom_histogram(breaks = seq(values$startYear,
                                  values$endYear,
                                  as.numeric(str_replace(values$binSizeYear, " years", ""))),
                     fill = "#69b3a2",
                     alpha = 0.9) +
      ggtitle("") +
      xlab("Publication Year") +
      ylab("Book Frequency") +
      theme_minimal()
  })

  # Histogram + Boxplot of the number of pages
  output$pagesHistPlot <- renderPlot({
    ifelse(values$genre == "All",
           val <- values$data$n_pages[values$data$pubDate >= values$startYear &
                                        values$data$pubDate <= values$endYear],
           val <- values$data$n_pages[values$data$genre_niv1 == values$genre &
                                        values$data$pubDate >= values$startYear &
                                        values$data$pubDate <= values$endYear])

    plot1 <- ggplot(mapping = aes(x = val)) +
      geom_histogram(breaks = seq(0,
                                  max(val) + (100 - max(val) %% 100),
                                  as.numeric(str_replace(values$binSizePages, " pages", ""))),
                     fill = "#69b3a2",
                     alpha = 0.9) +
      ggtitle("") +
      xlab("Number of pages") +
      ylab("Book Frequency") +
      theme_minimal()

    plot2 <- ggplot(mapping = aes(x = val)) +
      geom_boxplot(outlier.size = 0.5,) +
      coord_cartesian(xlim = c(0, max(val) + (100 - max(val) %% 100))) +
      ylab(" ") + xlab("") + ggtitle("")  +
      theme_minimal() +
      theme(
        axis.line.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()
      )

    grid.arrange(plot1, plot2, nrow = 2)
  })


  # Histogram of the genra
  output$genreHistPlot <- renderPlot({
    ifelse(values$genre == "All",
           val <- table(as.factor(values$data$genre_niv3[values$data$pubDate >= values$startYear &
                                        values$data$pubDate <= values$endYear])),
           val <- table(as.factor(values$data$genre_niv3[values$data$genre_niv1 == values$genre &
                                        values$data$pubDate >= values$startYear &
                                        values$data$pubDate <= values$endYear])))
    val <- val[names(val) %in% names(sort(val, decreasing = TRUE)[1:10])]

    ggplot(mapping = aes(x = fct_reorder(as.factor(names(val)), val), y = val)) +
      geom_bar(stat = "identity", fill = "#f68060", alpha = 0.6, width = 0.4) +
      coord_flip() +
      xlab("")+
      ylab('') +
      theme_minimal()
  })

  #### Boxplot ####
  output$boxplotRatings <- renderPlot({
    ifelse(values$genre == "All",
           val <- values$data$note[values$data$pubDate >= values$startYear &
                                        values$data$pubDate <= values$endYear],
           val <- values$data$note[values$data$genre_niv1 == values$genre &
                                        values$data$pubDate >= values$startYear &
                                        values$data$pubDate <= values$endYear])

    ggplot(mapping = aes(y = val)) +
      geom_boxplot(outlier.size = 0.5,) +
      ylab("Ratings") + xlab("") + ggtitle("") +
      theme_minimal() +
      theme(
        axis.line.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()
      )
  })


    }
)}
