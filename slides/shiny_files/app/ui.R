library(shiny)

ui <- fluidPage(
    
    titlePanel(title = "Interactive correlation plots"),
    
    sidebarLayout(
        
        sidebarPanel(
        
        selectInput(inputId = "var_x", 
                        label = "Select X:", 
                        choices = colnames(iris)[-5]),
        
        selectInput(inputId = "var_y", 
                        label = "Select Y:", 
                        choices = rev(colnames(iris)[-5]))
     ),
    
    mainPanel(
        
        plotOutput("correlation_plot"),
        
        tableOutput("data_head"),
        
        textOutput("correlation")
        
        
        )
    )
)