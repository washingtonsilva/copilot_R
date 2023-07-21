
# Autor: Washington S. da Silva
# Data: 2023-06-23
# Description: This script creates a Shiny dashboard that allows the user
# to select a name from a list of top trendy names and plot its trends over
# the years using the babynames dataset.
# Packages: shiny, dplyr, plotly, babynames
# Inputs:
#   - name: a character string representing the name selected by the user
# Outputs:
#   - plot_trendy_names: a plotly output that shows the trends of the
#                        selected name over the years

library(shiny)
library(dplyr)
library(plotly)
library(babynames)

# criar a variável top_trendy_names
top_trendy_names <- babynames |>
  group_by(name) |>
  summarise(total = sum(n)) |>
  arrange(desc(total)) |>
  slice(1:10) |>
  pull(name)

# ui
ui <- fluidPage(
  selectInput('name', 'Select Name', top_trendy_names),
  # CODE BELOW: Add a plotly output named 'plot_trendy_names'
  plotly::plotlyOutput("plot_trendy_names")
)

# server
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames |>
      filter(name == input$name) |>
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  # CODE BELOW: Render a plotly output named 'plot_trendy_names'
  output$plot_trendy_names <- plotly::renderPlotly({
    ggplotly(plot_trends())
  })
}

shinyApp(ui = ui, server = server)


# Para executar o app no VS Code - no console R
# shiny::runApp("scripts/dashboard01.R", launch.browser = TRUE)