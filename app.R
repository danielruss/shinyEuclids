library(shiny)
library(tidyverse)

ui <- fluidPage(
  # Input Function
##  sliderInput(inputId = "num",label = "Choose a number",value = 5,min = 1,max=10),
##  sliderInput(inputId = "num2",label = "Choose a second number",value = 5,min = 1,max=10),
  h3("A shiny verions of Euclids",tags$a(href="https://www.rstudio.com", "Click here!")),
  textInput(inputId = "url",label = "enter URL"),
  # Output Function
  tableOutput(outputId = "myTable"),
  textOutput(outputId = "meanValue",inline = F),
  actionButton(inputId = "clicks", label = "calculate distance")
  );

server <- function(input, output){
  observeEvent(input$clicks,{ 
    data <- read_csv(isolate(input$url)) %>% select_if(is.numeric) %>% drop_na()
    output$meanValue <- renderText({mean(dist(as.matrix(data)))}) ;
  });
 
}

shinyApp(ui=ui,server=server)