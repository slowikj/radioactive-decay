library(shiny)
library(plotly)
library(shinycssloaders)

source("plot.R")

isotopes <- read.csv(file="./isotopes.csv")
rownames(isotopes) <- isotopes$name
print(isotopes)

ui <- fluidPage(
    titlePanel("Radioactive decay Monte Carlo simulation"),

    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "isotope",
                        label = "Isotope",
                        choices = isotopes$name),
            numericInput(inputId = "objects_number",
                        label = "Objects number",
                        min = 1,
                        value = 1000,
                        max=1000000000),
            numericInput(inputId = "steps_number",
                        label = "Number of steps",
                        min = 1,
                        value = 5,
                        max=500),
            numericInput(inputId = "step_length",
                        label = "Step length [years]",
                        min = 1,
                        value = 1000,
                        max=1000000000000)
        ),

        mainPanel(
            withSpinner(plotlyOutput("plot"))
        )
    )
)

server <- function(input, output) {

    output$plot <- renderPlotly({
        ggplotly(get_plot(start_objects_number=input$objects_number,
                          half_life=isotopes[input$isotope,]$half_life,
                          time_step_number=input$steps_number,
                          time_step_length=input$step_length))
    })
}

shinyApp(ui = ui, server = server)
