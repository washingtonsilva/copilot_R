# Autor: Washington S. da Silva
# Data: 2023-06-23

# criar dashboard interativo usando o pacote shinydashboard
# criar ui para o dashboard

# packages
library(shiny)
library(dplyr)
library(plotly)
library(babynames)

# criar a variável top_trendy_names
top_trendy_names <- babynames %>%
  group_by(name) %>%
  summarise(total = sum(n)) %>%
  arrange(desc(total)) %>%
  slice(1:10) %>%
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
    babynames %>% 
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