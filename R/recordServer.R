recordServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {

      #### ObserveEvents ####
      observeEvent(input$recordGenre, {
        isolate(
          values$genre <- input$recordGenre
        )
      })


      #### renderUI ####
      output$recordGenreSelect <- renderUI({ # Genre list
        ns <- session$ns
        selectInput(ns("recordGenre"), "Genre :",
                    choices = c("All", names(sort(table(values$data$genre_niv1), decreasing = TRUE))),
                    selected = values$genre)
      })



      #### Outputs ####
      #### __Datatable ####
      output$recordDataTable <- renderDT({
        res <- values$data[nrow(values$data):1, c("readDate", "title", "author", "genre_niv1", "genre_niv2", "n_pages", "lang")]
        colnames(res) <- c("Date", "Title", "Author", "Genre", "Sub-Genre", "Pages", "Language")

        ifelse(values$genre == "All",
               rowSel <- 1:nrow(res),
               rowSel <- which(res$Genre == values$genre))
        res <- res[rowSel, ]

        res
      },
      rownames = FALSE,
        options = list(
          pageLength = 20
        )
      )

    })

}
