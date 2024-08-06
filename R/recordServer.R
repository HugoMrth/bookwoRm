recordServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {

        #### Outputs ####

      #### __Datatable ####

      output$recordDataTable <- renderDT(
        values$data[nrow(values$data):1, c("readDate", "title", "author", "genre_niv1", "genre_niv2", "n_pages", "lang")],
        options = list(
          pageLength = 20,
          initComplete = JS('function(setting, json) { alert("done"); }')
        )
      )

    })

}
