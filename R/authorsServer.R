authorsServer <- function(id, values) {

  moduleServer(
    id,
    function(input, output, session) {


      #### Outputs ####

      # __Histograms : Number of pages and books ####
      output$authorHistPlot <- renderPlot({
        val_b <- table(as.factor(values$data$author))
        val_b <- val_b[names(val_b) %in% names(sort(val_b, decreasing = TRUE)[1:15])]
        plot1 <- ggplot(mapping = aes(x = fct_reorder(as.factor(names(val_b)), val_b), y = val_b)) +
          geom_bar(stat = "identity", fill = "#f68060", alpha = 0.6, width = 0.4) +
          coord_flip() +
          xlab("")+
          ylab('') +
          theme_minimal() +
          labs(title = "Books")

        val_p <- by(values$data$n_pages, values$data$author, sum)
        val_p <- val_p[names(val_p) %in% names(sort(val_p, decreasing = TRUE)[1:15])]
        plot2 <- ggplot(mapping = aes(x = fct_reorder(as.factor(names(val_p)), val_p), y = val_p)) +
          geom_bar(stat = "identity", fill = "#f68060", alpha = 0.6, width = 0.4) +
          coord_flip() +
          xlab("")+
          ylab('') +
          theme_minimal() +
          labs(title = "Pages")

        grid.arrange(plot1, plot2, nrow = 1)
      })

      # __Histogram : Prices ####

      output$pricesHistPlot <- renderPlot({
        val <- values$data$prix
        val[str_detect(val, "Goncourt")] <- "Goncourt"
        val[str_detect(val, "Angoulême")] <- "Angoulême"
        val[str_detect(val, "Angoulème")] <- "Angoulême"
        val[str_detect(val, "Medicis")] <- "Medicis"
        val <- table(as.factor(val))
        val <- val[names(val) %in% names(sort(val, decreasing = TRUE)[1:15])]
        ggplot(mapping = aes(x = fct_reorder(as.factor(names(val)), val), y = val)) +
          geom_bar(stat = "identity", fill = "#f68060", alpha = 0.6, width = 0.4) +
          scale_x_discrete(limits=rev) +
          xlab("")+
          ylab('') +
          theme_minimal() +
          labs(title = "Prices and distinctions")
      })
    })

}
