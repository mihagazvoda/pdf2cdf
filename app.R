source("R/packages.R")
source("R/functions.R")


ui <- fluidPage(
  titlePanel("shinydrawr"),
  hr(),
  fluidRow(
    shinydrawr_UI("drawr_widget_1", height = "300px"),
    shinydrawr_UI("drawr_widget_2", height = "300px"),
    plotOutput("plot")
  )
)


server <- function(input, output) {
  data <- tibble(
    x = 1:50
  )

  drawr_widget_1 <- callModule(
    shinydrawr,
    "drawr_widget_1",
    data = data,
    x_col = x,
    y_col = y,
    free_draw = TRUE,
    y_range = c(0, 1),
    drawn_line_color = "red"
  )

  drawr_widget_2 <- callModule(
    shinydrawr,
    "drawr_widget_2",
    data = data,
    x_col = x,
    y_col = y,
    free_draw = TRUE,
    y_range = c(0, 1),
    y_lab = "Super cool",
    drawn_line_color = "blue"
  )

  output$plot <- renderPlot(plot_ecdf(drawr_widget_1(), drawr_widget_2()))
}

# Run the application
shinyApp(ui = ui, server = server)
