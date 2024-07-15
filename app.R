


#### IMPORTS ####

# Shiny packages
library(shiny)
library(shinydashboard)
library(shinyFiles)
library(shinyWidgets)
library(shinyjs)
library(shinybusy)
library(shinyBS)

# Other packages
library(tidyverse)
library(lazyMe)



# Sourcing R/ folder functions
# Not required if App is launched through to "Run App" button

# sapply(list.files("R/", full.names = TRUE), source)









#### SERVER ####

server <- function(input, output, session) {
  # Reactive values
  values <- reactiveValues(
    data = data.frame(tidyBooks(openxlsx::read.xlsx("data/Livres.xlsx"))),
    selectedGenre1 = "All",
    selectedGenre2 = "Aggregated"
  )

  # Server functions
  dashboardServer("dashboard", values)
  genraServer("genra", values)
  authorsServer("authors", values)
  achievmentsServer("achievments", values)
  recordServer("record", values)
  wishlistServer("wishlist", values)
}




#### UI ####

# Define UI for application
ui <- dashboardPage(
  # Header
  dashboardHeader(
    title = "bookwoRm"
  ),

  # Sidebar
  dashboardSidebar(
    sidebarMenu(
      # tabs
      menuItem(h2("Dashboard"), tabName = "dashboard",
               icon = icon("dashboard", class = "fa")),
      menuItem(h2("Genra"), tabName = "genra",
               icon = icon("book", class = "fa")),
      menuItem(h2("Authors"), tabName = "authors",
               icon = icon("image-portrait", class = "fa")),
      menuItem(h2("Achievments"), tabName = "achievments",
               icon = icon("trophy", class = "fa")),
      menuItem(h2("Record"), tabName = "record",
               icon = icon("list-ul", class = "fa")),
      menuItem(h2("Wish List"), tabName = "wishlist",
               icon = icon("clipboard-list", class = "fa"))
    )
  ),

  # Body
  dashboardBody(
    # Loading spinner
    useShinyjs(),
    #add_busy_spinner(spin = "fading-circle"),

    # CSS style
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),

    # Tabs body
    tabItems(
      tabItem(tabName = "dashboard", fluidPage(dashboardUi("dashboard"))),
      tabItem(tabName = "genra", fluidPage(genraUi("genra"))),
      tabItem(tabName = "authors", fluidPage(authorsUi("authors"))),
      tabItem(tabName = "achievments", fluidPage(achievmentsUi("achievments"))),
      tabItem(tabName = "record", fluidPage(recordUi("record"))),
      tabItem(tabName = "wishlist", fluidPage(wishlistUi("wishlist")))
    )
  )
)



#### RUN APP ####

# Run the application
shinyApp(ui = ui, server = server)
