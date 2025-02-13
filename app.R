

#### IMPORTS ####

# Shiny packages
if (!require("shiny")) install.packages("shiny")
if (!require("shinydashboard")) install.packages("shinydashboard")
if (!require("shinyFiles")) install.packages("shinyFiles")
if (!require("shinyWidgets")) install.packages("shinyWidgets")
if (!require("shinyjs")) install.packages("shinyjs")
if (!require("shinybusy")) install.packages("shinybusy")
if (!require("shinyBS")) install.packages("shinyBS")
if (!require("shinyalert")) install.packages("shinyalert")

# Word cloud
if (!require("polyglotr")) install.packages("polyglotr")
if (!require("tm")) install.packages("tm")
if (!require("SnowballC")) install.packages("SnowballC")
if (!require("wordcloud")) install.packages("wordcloud")
if (!require("RColorBrewer")) install.packages("RColorBrewer")

# Other packages
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("stringr")) install.packages("stringr")
if (!require("gridExtra")) install.packages("gridExtra")
if (!require("forcats")) install.packages("forcats")
if (!require("lazyMe")) install.packages("lazyMe")
if (!require("DT")) install.packages("DT")

# Sourcing R/ folder functions
# Not required if App is launched through to "Run App" button

# sapply(list.files("R/", full.names = TRUE), source)









#### SERVER ####

server <- function(input, output, session) {
  DATA <- tidyBooks(openxlsx::read.xlsx("data/Livres.xlsx"))
  WISHLIST <- tidyWishlist(openxlsx::read.xlsx("data/Livres.xlsx", sheet = 2))
  QUOTES <- tidyQuotes(openxlsx::read.xlsx("data/Citations.xlsx"))

  # Reactive values
  values <- reactiveValues(
    data = DATA,
    wishlist = WISHLIST,
    quotes = QUOTES,
    # Values common to several tabs
    genre = "All",
    # Dashboard values
    startDate = min(DATA$readDate),
    endDate = max(DATA$readDate),
    genreType = "Aggregated",
    unit = "Books",
    langFormat = "Language",
    # Books values
    startYear = min(DATA$pubDate),# - (min(DATA$pubDate) %% 100),
    endYear = max(DATA$pubDate),# + (100 - max(DATA$pubDate) %% 100),
    binSizeYear = "50 years",
    binSizePages = "50 pages",
    # Wishlist
    state = "All",
    # Quotes
    theme = "All",
    rank = "All"
  )

  # Server functions
  dashboardServer("dashboard", values)
  booksServer("books", values)
  authorsServer("authors", values)
  achievmentsServer("achievments", values)
  recordServer("record", values)
  wishlistServer("wishlist", values)
  quotesServer("quotes", values)
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
      menuItem(h2("Books"), tabName = "books",
               icon = icon("book", class = "fa")),
      menuItem(h2("Authors"), tabName = "authors",
               icon = icon("image-portrait", class = "fa")),
      menuItem(h2("Achievments"), tabName = "achievments",
               icon = icon("trophy", class = "fa")),
      menuItem(h2("Record"), tabName = "record",
               icon = icon("list-ul", class = "fa")),
      menuItem(h2("Wish List"), tabName = "wishlist",
               icon = icon("clipboard-list", class = "fa")),
      menuItem(h2("Quotes"), tabName = "quotes",
               icon = icon("quote-left", class = "fa"))
    )
  ),

  # Body
  dashboardBody(

    # Background color
    tags$head(tags$style(HTML('
      .content-wrapper {
        background-color: #fff;
      }'
    ))),

    # Loading spinner
    useShinyjs(),

    # CSS style sheet to use
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),

    # Tabs body
    tabItems(
      tabItem(tabName = "dashboard", fluidPage(dashboardUi("dashboard"))),
      tabItem(tabName = "books", fluidPage(booksUi("books"))),
      tabItem(tabName = "authors", fluidPage(authorsUi("authors"))),
      tabItem(tabName = "achievments", fluidPage(achievmentsUi("achievments"))),
      tabItem(tabName = "record", fluidPage(recordUi("record"))),
      tabItem(tabName = "wishlist", fluidPage(wishlistUi("wishlist"))),
      tabItem(tabName = "quotes", fluidPage(quotesUi("quotes")))
    )
  )
)



#### RUN APP ####

# Run the application
options(warn=0)
shinyApp(ui = ui, server = server)
