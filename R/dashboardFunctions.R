

# Separate file from the UI and Server
# Defining functions that are used several time in the server part



# Time serie period selection function
# Using starting and ending date from the inputs
periodSelection <- function(values) {
  values$data[values$data$readDate >= values$startDate & values$data$readDate <= values$endDate,]
}

# Simple pie chart plot
myPieChart <- function(val, group, values) {
  ggplot(mapping = aes(x = "", y = val, fill = group)) +
    geom_bar(stat = "identity", width = 1) +
    geom_text(aes(label = ifelse(val > 5, paste0(val, "%"), "")),
              position = position_stack(vjust = 0.5)) +
    coord_polar("y", start = 0) +
    scale_fill_brewer(palette = "Pastel1") +
    guides(fill = guide_legend(title = "Genre")) +
    theme_void()
}
