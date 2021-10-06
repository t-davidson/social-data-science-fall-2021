library(shiny)
library(tidyverse)
library(ggplot2 )

server <- function(input, output) {
    
    files <- reactiveValues()
    
    observe(files$data <- iris)
    
    output$correlation_plot <- renderPlot({
        
        ggplot(data=iris, aes(x = files$data[[input$var_x]], y = files$data[[input$var_y]], color = Species)) + geom_point() +
            labs(y = input$var_x, x = input$var_y) + theme_bw()
        
    }
                                          )
    
    output$correlation <- renderText({
        paste("Correlation coefficient:", round(cor(iris[[input$var_x]], iris[[input$var_y]])[1],2), sep=" ")
            }
        )
    output$data_head <- renderTable({iris %>% group_by(Species) %>% summarize_all(mean)}, spacing = "xs")
}
