
# Author: Washington S. da Silva
# Data: 2023-06-23
# Description: build a Shiny app that lets a user choose sex and year, 
# and will display the top 10 most popular names in that year as a column 
# plot of proportion of births (prop) by name (name).
# Inputs:
#   -
# Outputs:
#   - 


## packages
library(shiny)
library(dplyr)
library(ggplot2)
library(babynames)

# user interface
ui <- fluidPage(titlePanel("Most Popular Names"),
                sidebarLayout(
                  sidebarPanel(
                    selectInput('sex', 'Select Sex', c("M", "F")),
                    sliderInput(
                      'year',
                      'Select Year',
                      min = 1880,
                      max = 2017,
                      value = 1900
                    )
                  ),
                  mainPanel(plotOutput('plot'))
                ))


## server function
server <- function(input, output, session) {

 get_top_names <- function(sex, year) {
    babynames |>
      filter(sex == input$sex)  |>
      filter(year == input$year) |>
      slice_max(prop, n = 10) |>
      arrange(desc(prop), .by_group = TRUE)
  }

  output$plot <- renderPlot({
    top_names_by_sex_year <- get_top_names(input$sex, input$year)
    ggplot(top_names_by_sex_year, aes(x = name, y = prop)) +
      geom_col()
  })
}

shinyApp(ui = ui, server = server)

# Para executar o app no VS Code - no console R
# shiny::runApp("scripts/dashboard02.r", launch.browser = TRUE)