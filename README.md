# bookwoRm

This App is a dashboard similar to the ones websites like GoodReads.com propose to visualize personnal readings data.

I'm maintaining my database myself and created my own dashboard :)


## 1) Required packages installation

```
### Installing packages from CRAN

# Shiny packages
install.packages("shiny")
install.packages("shinydashboard")
install.packages("shinyFiles")
install.packages("shinyWidgets")
install.packages("shinyjs")
install.packages("shinybusy")
install.packages("shinyBS")
# Other
install.packages("tidyverse")
install.packages("gridExtra")
install.packages("forcats")
install.packages("stringr")
install.packages("lazyMe")
install.packages("DT")


### Installing package from github
remotes::install_github("HugoMrth/lazyMe")
```

## 2) Lauching the app

Download and unzip the whole repository, open "app.R" and click the "Run App" button (top right corner).


## 3) Using the app with your data

As I am maintaining the dta file myself, using the app with your own reading data will require you to update the data file yourself. The easiest solution would be to respect the same data base template, but modifying the "R/dataTidying.R" file to fit the format can also work. 
