#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
#devtools::install_github(repo = "zsmith27/BAP")
library(BAP)

function(input, output) {
  
  my_data <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) return(NULL)
    data <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                     quote=input$quote)
    data <- BAP::data_prep(data)
    data
  })
  
  
  
  input.react <- reactive(
    switch(input$method,
           "Riffle" = BAP::bap_riffle(my_data()),
           "Ponar" = BAP::bap_ponar(my_data()),
           "Jab" = BAP::bap_jab(my_data()),
           "MP Navigable Waters" = BAP::bap_mp_nav_waters(my_data()),
           "MP Non-Navigable Waters" = BAP::bap_mp_non_nav_water(my_data()))
  )
  
  
  output$contents <- renderTable({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    input.react()
    
  })
  
  output$value <- renderText({ input$caption })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$caption, '.csv', sep='') },
    content = function(file) {
      write.csv(input.react(), file, row.names = F)
    }
  )
}