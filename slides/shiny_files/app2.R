library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)

data <- iris

# Specify the UI for the app
ui <- dashboardPage(
    dashboardHeader(title = "Interactive correlation plots"),
    dashboardSidebar(
        
        sidebarMenu(
            menuItem("Iris", tabName = "iris", icon = icon("tree")),
            menuItem("README", tabName = "readme", icon = icon("book"))
        )
    ),
    
    dashboardBody(
        tabItems(
            tabItem("iris", 
                    box(
                        plotOutput("correlation_plot"), 
                        width = 8),
                    box(
                        selectInput(inputId = "var_x", 
                                    label = "Select X:", 
                                    choices = colnames(iris)[-5]), 
                        width = 2
                    ),
                    box(
                        selectInput(inputId = "var_y", 
                                    label = "Select Y:", 
                                    choices = rev(colnames(iris)[-5])), 
                        width = 2
                    ),
                    box (
                        textOutput("correlation")
                    ), 
                    box (
                        tableOutput("data_head")
                    )
            ),
            tabItem("readme",
                    fluidPage(
                        h1("Information"),
                        textOutput("readme_info"))
                    )
    )
)
)

# Specify how R should run code / display output
server <- function(input, output) {
    
    output$correlation_plot <- renderPlot({
         
        ggplot(data=iris, aes(x = iris[[input$var_x]], y = iris[[input$var_y]], color = Species)) + geom_point() +
            labs(y = input$var_x, x = input$var_y) + theme_bw()
        
    }
                                          )
    
    output$correlation <- renderText({
        paste("Correlation coefficient:", round(cor(iris[[input$var_x]], iris[[input$var_y]])[1],2), sep=" ")
            }
        )
    
    output$data_head <- renderTable({iris %>% group_by(Species) %>% summarize_all(mean)}, spacing = "xs")
    
    output$readme_info <- renderText({
        "This app is used to visualize data from the iris dataset. Use the menu to select the X and Y variables. \n Points are colored according to the species."
    })
}


app <- shinyApp(ui, server)
