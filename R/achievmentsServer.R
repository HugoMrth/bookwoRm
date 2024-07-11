achievmentsServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {

      #### Couting the checks ####

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


    })

}
