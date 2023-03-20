#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(babynames)
library(gganimate)
ui <- fluidPage(
  tags$style(".container-fluid{
             background-color: #000000}"),
  textInput(
  inputId = "name",
  label = "Name",
  value = "",
  placeholder = "",),
selectInput(inputId = "sex",
            label = "Sex:",
            choices = list(Female = "F",
                           Male = "M")),
sliderInput(inputId = "year",
            label = "Year Range",
            min = min(babynames$year),
            max = max(babynames$year),
            value = c(min(babynames$year),
                      max(babynames$year)),
            sep = ""),
submitButton(text = "Create my plot"),
plotOutput(outputId = "nameplot")
)
server <- function(input, output){
  output$nameplot <- renderPlot(
  babynames %>%
    filter(sex == input$sex,
           name == input$name) %>% 
    ggplot(aes(x = year,
               y = n)) + 
    geom_line(color = "red") +
    scale_x_continuous(limits = input$year) + theme_bw() + geom_area(fill = "black")  
           
           )
}

shinyApp(ui = ui, server = server)
