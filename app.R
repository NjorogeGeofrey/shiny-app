#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#libraries required
library(shiny)
library(tidyverse)
#library containing the dataset
library(babynames)
library(gganimate)
#building the user interferce
ui <- fluidPage(
  #setting the background colours
  tags$style(".container-fluid{
             background-color: #000000}"),
 #creating both input method and type 
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
  #requesting R to output our plot
plotOutput(outputId = "nameplot")
)
#connecting the server
server <- function(input, output){
  #creation of the plot
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
#complition of the shiny app
shinyApp(ui = ui, server = server)
