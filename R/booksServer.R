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


  #### Histograms ####
  output$pubHistPlot <- renderPlot({

    ggplot(mapping = aes(x = values$data$pubDate)) +
      geom_histogram(breaks = seq(values$startYear,
                                  values$endYear,
                                  as.numeric(str_replace(values$binSizeYear, " years", ""))),
                     fill = "#69b3a2",
                     alpha = 0.9) +
      ggtitle("") +
      xlab("Publication Year") +
      ylab("Book Frequency")
  })
  output$pagesHistPlot <- renderPlot({

    ggplot(mapping = aes(x = values$data$n_pages)) +
      geom_histogram(breaks = seq(0,
                                  max(values$data$n_pages) + (100 - max(values$data$n_pages) %% 100),
                                  as.numeric(str_replace(values$binSizePages, " pages", ""))),
                     fill = "#69b3a2",
                     alpha = 0.9) +
      ggtitle("") +
      xlab("Number of pages") +
      ylab("Book Frequency")
  })
    }
)}
