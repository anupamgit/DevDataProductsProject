library(shiny)

# Define UI for application that shows how accuracy of a prediction algorithm varies with training size.
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("IRIS/Wage dataset: Effect of training size on prediction outcome"),
    
    # Sidebar with a slider input to set the percentage of training data out of input data
    sidebarPanel(
        wellPanel(
            h4("Step1"),
            h5("Use slider below to change the percentage of training data to be used."),
            sliderInput("percentage", 
                        "", 
                        min = 10,
                        max = 95, 
                        value = 20,
                        step=5),
            br(),
            # Following displays the percentage split in a table format
            tableOutput('split')
        ),
        wellPanel(
            h4("Step2"),
            h5("Run to generate glm model with the above settings"),
            actionButton("submit", "Run")
        )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        # Display help text for the plot of age v/s wage in Wage dataset of IRIS library
        helpText("Plot below will show the wage outcome based on age predictor. The black dots are the real data and the red dots are the predicted outcome from glm(Linear Model) method in caret package"),
        plotOutput("prediction"),
        h5("Error rates of the model generated using the training data"),
        helpText("Notice how RMSE changes as you vary the percentage of training data"),
        tableOutput("accuracy")
    )
))