#
# This is a Shiny web application template.
# You can run the application by clicking the 'Run App' button above.
#




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
library(dplyr)




# Sourcing R/ folder functions
# Not required if App is launched through to "Run App" button

# sapply(list.files("R/", full.names = TRUE), source)









#### SERVER ####

server <- function(input, output, session) {
  # Reactive values
  values <- reactiveValues(
    x = faithful[, 2]
  )

  # Server functions
  dashboardServer("dashboard", values)
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
      menuItem("Dashboard", tabName = "dashboard",
               icon = icon("dashboard")),
      menuItem("Achievments", tabName = "achievments",
               icon = icon("th")),
      menuItem("Record", tabName = "record",
               icon = icon("th")),
      menuItem("Wish List", tabName = "wishlist",
               icon = icon("th"))
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
      tabItem(tabName = "achievments", fluidPage(achievmentsUi("achievments"))),
      tabItem(tabName = "record", fluidPage(recordUi("record"))),
      tabItem(tabName = "wishlist", fluidPage(wishlistUi("wishlist")))
    )
  )
)




#### RUN APP ####

# Run the application
shinyApp(ui = ui, server = server)
