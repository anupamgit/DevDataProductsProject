library(shiny)
library(caret)
library(datasets)
library(xtable)
library(ISLR)
data(iris)
# values is used to store the model generated so that it can shared between different functions
values <- reactiveValues()

# Define server logic required to train, predict and plot the results
shinyServer(function(input, output) {
    
    # 1) Receive the value provided by slider input
    # 2) Split the data into 2 partitions: train and test
    # 3) Create a model by using the train method from carent package
    # 4) Predict using the model created by using the test data set
    # 5) Plot the prediction v/s read data
    output$prediction <- renderPlot({
        
        # 1. read input value
        p <- isolate(input$percentage)
        if(is.null(p) | input$submit == 0) {
            return(NULL)
        }
        
        ## 2. Split the data into 2 groups: train and test datasets
        set.seed(123123)
        inTrain <- createDataPartition(Wage$wage, p=p/100, list=FALSE)
        train <- Wage[inTrain,]
        test  <- Wage[-inTrain,]
        
        ## 3. Train the model by using Wage as outcome and age as predictor
        values$modFit <- train(wage ~ age, data=train, method="glm", preProcess=c("center", "scale"))
        
        ## 4. Predict on the test data
        pred <- predict(values$modFit, newdata=test)

        ## 5. Plot the output for test test age v/s test outcome
        plot(test$age, test$wage, main=paste("Prediction outcome with", p, "% training data"),
             xlab = "Age", ylab = "Wage")
        ## 5.1 Plot overlapping output for prediction from the model v/s the test outcome
        points(test$age, pred, col="red")
    })
    
    ## Following method udpates the percentage split in the siderbar
    output$split <- renderTable({
        # 1. read input value
        p <- input$percentage
        if(is.null(p)) {
            return(NULL)
        }
        p <- p/100
        splitInfo <- as.data.frame(c(round(p,2), round(1-p,2)))
        rownames(splitInfo) <- c("Training data", "Test data")
        t <- round(p * nrow(Wage),0)
        splitInfo$rows <- c(t, nrow(Wage)-t)
        colnames(splitInfo) <- c("% Split", "Number of Rows")
        return(xtable(splitInfo))
    })
    
    ## Following method returns the error rate for the model 
    output$accuracy <- renderTable({
        p <- isolate(input$percentage)
        if(is.null(values$modFit) | input$submit == 0) {
            return(NULL)
        }
        values$modFit$results[,-1]
    })
})