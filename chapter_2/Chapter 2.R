# 2.1 Introduction

## install Shiny
#install.packages("shiny")

## load in current R session
library(shiny)


# 2.2 Create app directory and file

library(shiny) # load shiny package

## define user interface, the HTML webpage that humans interact with
ui <- fluidPage( 
  "Hello, world!" # the page contains the words "Hello, world!"
)

## specifies the behavior of our app by defining a server function
server <- function(input, output, session) { 
} # Currently empty, so our app doesn't do anything

## executes to construct and start a Shiny application from UI and server
shinyApp(ui, server)


# 2.4 Adding UI controls

## define user interface, the HTML webpage that humans interact with
ui <- 
  # a layout function that sets up the basic visual structure of the page
  fluidPage( 
    # an input control that lets the user interact with the app by previding a value
    selectInput(
      # in this case, it's a select box with the label "Dataset" 
      # and lets you choose one of the built-in datasets that come with R.
      "dataset", label = "Dataset", choices = ls("package:datasets")),
    # output controls that tell Shiny where to put rendered output
    verbatimTextOutput("summary"), # displays code
    tableOutput("table") # displays tables
)
## specifies the behavior of our app by defining a server function
server <- function(input, output, session) { 
} # Currently empty, so our app doesn't do anything

## executes to construct and start a Shiny application from UI and server
shinyApp(ui, server)


# 2.5 Adding behaviour

## define user interface, the HTML webpage that humans interact with
ui <- 
  # a layout function that sets up the basic visual structure of the page
  fluidPage( 
    # an input control that lets the user interact with the app by previding a value
    selectInput(
      # in this case, it's a select box with the label "Dataset" 
      # and lets you choose one of the built-in datasets that come with R.
      "dataset", label = "Dataset", choices = ls("package:datasets")),
    # output controls that tell Shiny where to put rendered output
    verbatimTextOutput("summary"), # displays code
    tableOutput("table") # displays tables
  )
## specifies the behavior of our app by defining a server function
server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })
  
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}

## executes to construct and start a Shiny application from UI and server
shinyApp(ui, server)


# 2.6 Reducing duplication with reactive expressions

## define user interface, the HTML webpage that humans interact with
ui <- 
  # a layout function that sets up the basic visual structure of the page
  fluidPage( 
    # an input control that lets the user interact with the app by previding a value
    selectInput(
      # in this case, it's a select box with the label "Dataset" 
      # and lets you choose one of the built-in datasets that come with R.
      "dataset", label = "Dataset", choices = ls("package:datasets")),
    # output controls that tell Shiny where to put rendered output
    verbatimTextOutput("summary"), # displays code
    tableOutput("table") # displays tables
  )
## specifies the behavior of our app by defining a server function
server <- function(input, output, session) {
  # Create a reactive expression
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    # Use a reactive expression by calling it like a function
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}

## executes to construct and start a Shiny application from UI and server
shinyApp(ui, server)


# 2.8 Exercises

## 1. Create an app that greets the user by name. 
### You don’t know all the functions you need to do this yet, 
### so I’ve included some lines of code below. 
### Figure out which lines you’ll use and then copy 
### and paste them into the right place in a Shiny app.
ui <- fluidPage( 
  textInput("name", "What's your name?")
)
server <- function(input, output, session) { 
}
shinyApp(ui, server)

tableOutput("mortgage")
output$greeting <- renderText({
  paste0("Hello ", input$name)
})
numericInput("age", "How old are you?", value = NA)

textOutput("greeting")
output$histogram <- renderPlot({
  hist(rnorm(1000))
}, res = 96)
