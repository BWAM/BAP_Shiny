#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)



fluidPage(
  theme = shinytheme("spacelab"),
  titlePanel("NYSDEC: BAP"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio_data", "Data:",
                   c("Load CSV" = "csv",
                     "Example Data" = "example"),
                   inline = TRUE),
      conditionalPanel(condition = 'input.radio_data == "csv"',
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv'))),
      
     
      a("Example Format", target = "_blank", href = "Mosher_Request_1_6_17.pdf"),
      
      
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      tags$hr(),
      
      selectInput("method", "Method",
                  c("Riffle", "Ponar", "Jab",
                    "MP Navigable Waters",
                    "MP Non-Navigable Waters")
      ),
      
      tags$hr(),
      
      textInput("caption", "File Name", ""),
      
      downloadButton('downloadData', 'Download')
    ),
    mainPanel(
      tableOutput('contents')
    )
  )
)

