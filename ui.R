#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


fluidPage(
  titlePanel("NYSDEC: BAP"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      selectInput("method", "Method",
                  c("Riffle", "Ponar", "Jab",
                    "MP Navigable Waters",
                    "MP Non-Navigable Waters")
      ),
      
      textInput("caption", "File Name", ""),
      
      downloadButton('downloadData', 'Download')
    ),
    mainPanel(
      tableOutput('contents')
    )
  )
)

