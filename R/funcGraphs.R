# data(mtcars)
#
# mtcars <- mtcars %>%
#   mutate(
#     vs = ifelse(vs == 0, "V-shaped", "straight"),
#     am = ifelse(am == 0, "automatic", "manual"),
#     vs_am = paste(vs, am)
#   )
#
#
# pieChart <- function(input, main) {
#   pie(x = input,
#       col = RColorBrewer::brewer.pal(length(input), "Set1"),
#       main = "mpg per group"
#   )
# }
#
# pieChart(with(mtcars, by(mpg, vs_am, sum)))
#
#
#
