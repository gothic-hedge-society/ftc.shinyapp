

load('./data/reports.rda')

ui <- shiny::fluidPage(
  shiny::selectInput(
    inputId = 'selected-trader',
    label   = 'Select a Trader',
    choices = reports$trader_name
  ),
  shiny::tags$p(getwd())
)

server <- function(input, output) {
 
}

shiny::shinyApp(ui = ui, server = server)