library(shiny)
library(tidyverse)

ui <- fluidPage(
  # Input Function
##  sliderInput(inputId = "num",label = "Choose a number",value = 5,min = 1,max=10),
##  sliderInput(inputId = "num2",label = "Choose a second number",value = 5,min = 1,max=10),
  h3("A shiny verions of Euclids",tags$a(href="https://github.com/danielruss/shinyEuclids", "source on github")),
  textInput(inputId = "url",label = "enter URL",value = "https://episphere.github.io/qaqc/iris.csv"),
  actionButton(inputId = "clicks", label = "calculate distance"),
  # Output Function
  p(style="padding:4px",
    textOutput(outputId = "distLabel",inline = T),
    textOutput(outputId = "meanValue",inline = T)
    ),
  plotOutput(outputId = "myPlot"),
  tags$script(HTML("if (location.search.length>3){ 
    document.querySelector('input').value=location.search.slice(1)
    document.querySelector('button').click()
  }"))
  );

server <- function(input, output){
  observeEvent(input$clicks,{ 
    output$distLabel = renderText("mean distance: ")
    data <- read_csv(isolate(input$url)) %>% select_if(is.numeric) %>% drop_na();
    d <- dist(as.matrix(data));
    output$meanValue <- renderText({mean(d)})
    output$myPlot <- renderPlot({heatmap(as.matrix(d))})
  });
 
}

shinyApp(ui=ui,server=server)