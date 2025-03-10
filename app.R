
library(magrittr)
load('./data/reports.rda')


ui <- shiny::fluidPage(
  shiny::selectInput(
    inputId = 'selected_trader',
    label   = 'Select a Trader',
    choices = sort(reports$trader_name)
  ),
  DT::dataTableOutput("main_dt")
)

server <- function(input, output) {
  output$main_dt <- DT::renderDataTable({
    reports %>% 
      dplyr::filter(trader_name == input$selected_trader) %>% {
        .$statement[[1]]
      } %>%
      dplyr::arrange(dplyr::desc(date)) %>%
      dplyr::select(date, rank, dplyr::everything()) %>%
      DT::datatable(
        rownames = FALSE,
        extensions = c('Scroller', 'FixedColumns'),
        options  = list(
          dom          = 't',
          pageLength   = nrow(.),
          scrollY      = 500,
          scrollX      = TRUE,
          fixedColumns = TRUE
        )
      ) %>%
      DT::formatDate(1) %>%
      DT::formatCurrency(c(2,3)) %>%
      DT::formatPercentage(c(4,5,6,7,8,10), digits = 4) %>%
      DT::formatSignif(c(9, 11), digits = 4) 
  })
}

shiny::shinyApp(ui = ui, server = server)