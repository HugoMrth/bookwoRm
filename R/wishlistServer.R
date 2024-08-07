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


      #### renderUI ####
      output$wishlistGenreSelect <- renderUI({ # Genre list
        ns <- session$ns
        selectInput(ns("wishlistGenre"), "Genre :",
                    choices = c("All", names(sort(table(values$data$genre_niv1), decreasing = TRUE)), "Mythology"),
                    selected = values$genre)
      })


      #### Outputs ####

      #### __Datatable ####
      output$wishlistDataTable <- renderDT({
        ifelse(values$genre == "All",
               rowSel <- 1:nrow(values$wishlist),
               rowSel <- which(values$wishlist$Genre == values$genre))

        values$wishlist[rowSel, ]
      },
      options = list(
        pageLength = 20,
        initComplete = JS('function(setting, json) { alert("done"); }')
      )
      )
    })

}
