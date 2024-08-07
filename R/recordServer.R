recordServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {

      #### Outputs ####

      #### __Datatable ####
      output$recordDataTable <- renderDT({
        res <- values$data[nrow(values$data):1, c("readDate", "title", "author", "genre_niv1", "genre_niv2", "n_pages", "lang")]
        colnames(res) <- c("Date", "Title", "Author", "Genre", "Sub-Genre", "Pages", "Language")
        res
      },
        options = list(
          pageLength = 20,
          initComplete = JS('function(setting, json) { alert("done"); }')
        )
      )

    })

}
