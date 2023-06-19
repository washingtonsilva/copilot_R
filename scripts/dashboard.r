# Autor: Washington S. da Silva
# Data: 2023-06-23

# criar dashboard interativo usando o pacote shinydashboard
# criar ui para o dashboard
ui <- dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Gráficos", tabName = "graficos", icon = icon("bar-chart-o")),
      menuItem("Tabelas", tabName = "tabelas", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "graficos",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                box(plotOutput("plot2", height = 250)),
                box(plotOutput("plot3", height = 250))
              )
      ),
      tabItem(tabName = "tabelas",
              fluidRow(
                box(tableOutput("tabela1"), height = 250),
                box(tableOutput("tabela2"), height = 250),
                box(tableOutput("tabela3"), height = 250)
              )
      )
    )
  )
)

# criar server para o dashboard
server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(dados, aes(x = x1, y = y)) +
      geom_point() +
      geom_smooth(method = "lm")
  })
  output$plot2 <- renderPlot({
    ggplot(dados, aes(x = x2, y = y)) +
      geom_point() +
      geom_smooth(method = "lm")
  })
  output$plot3 <- renderPlot({
    ggplot(dados, aes(x = x3, y = y)) +
      geom_point() +
      geom_smooth(method = "lm")
  })
  output$tabela1 <- renderTable({
    dados %>% 
      select(x1, y) %>% 
      head()
  })
  output$tabela2 <- renderTable({
    dados %>% 
      select(x2, y) %>% 
      head()
  })
  output$tabela3 <- renderTable({
    dados %>% 
      select(x3, y) %>% 
      head()
  })
}