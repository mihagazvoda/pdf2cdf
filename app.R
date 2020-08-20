library(shiny)
library(shinysense)
library(tidyverse)
library(ggplot2)


ui <- fluidPage(
  titlePanel("shinydrawr"),
  hr(),
  fluidRow(
    column(
      width = 8,
      shinydrawr_UI("drawr_widget", height = '300px'),
      plotOutput("plot")
    ),
    column(
      width = 3,
      offset = 1,
      h2("Drawn values:"),
      tableOutput("displayDrawn")
    )
  )
)


server <- function(input, output) {
  data <- tibble(
    x = 1:50
  )
  
  drawr_widget <- callModule(
    shinydrawr,
    'drawr_widget',
    data = data,
    x_col = x,
    y_col = y,
    free_draw = TRUE,
    # draw_start = 0,
    y_range = c(0, 20),
    drawn_line_color = 'green',
    y_lab = 'Super cool'
  )
  
  output$displayDrawn <- renderTable(drawr_widget())
  
  output$plot <- renderPlot(plot(drawr_widget()$x, drawr_widget()$drawn)) 
  
}

# Run the application
shinyApp(ui = ui, server = server)