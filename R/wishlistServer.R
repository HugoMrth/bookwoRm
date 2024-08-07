wishlistServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {

      #### ObserveEvents ####
      observeEvent(input$wishlistGenre, {
        isolate(
          values$genre <- input$wishlistGenre
        )
      })
      observeEvent(input$wishlistState, {
        isolate(
          values$state <- input$wishlistState
        )
      })


      #### renderUI ####
      output$wishlistGenreSelect <- renderUI({ # Genre list
        ns <- session$ns
        selectInput(ns("wishlistGenre"), "Genre :",
                    choices = c("All", names(sort(table(values$data$genre_niv1), decreasing = TRUE)), "Mythology"),
                    selected = values$genre)
      })
      output$wishlistStateSelect <- renderUI({ # States list
        ns <- session$ns
        selectInput(ns("wishlistState"), "State :",
                    choices = c("All", names(sort(table(values$wishlist$State), decreasing = TRUE))),
                    selected = values$state)
      })


      #### Outputs ####

      #### __Datatable ####
      output$wishlistDataTable <- renderDT({
        ifelse(values$genre == "All",
               rowSel <- 1:nrow(values$wishlist),
               rowSel <- which(values$wishlist$Genre == values$genre))
        res <- values$wishlist[rowSel, ]

        ifelse(values$state == "All",
               rowSel <- 1:nrow(res),
               rowSel <- which(res$State == values$state))
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
