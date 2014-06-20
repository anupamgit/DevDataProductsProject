---
title       : Developing Data Products
subtitle    : Project
author      : Anupam
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Details

- Shiny app name: DevDataProductsProject
- Link: https://anupam.shinyapps.io/DevDataProductsProject/
- Idea: Shows how training dataset size impacts a prediction model.

--- .class #id 

## App UI

- Sidebar has 3 components:-
    - Slider: Receive input from user
    - Table : Display % and number of rows in training/test data
    - Button: A button named "Run" is provided to start the prediction process
- Main panel:-
    - Plot: Shows age v/s wage in Wage dataset(IRIS)
    - Table: Shows Root mean squared error(RMSE) for the model

--- .class #id

## App Server

- Process input:-
    - Read %, partition data, train model and predict on test data
    - Generate plot: age v/s wage
- Generate table with RMSE information
- Generate table for train and test data split sizes (E.g. below)

```r
d <- data.frame(c(0.5, 0.5), c(1500, 1500))
colnames(d) <- c("Percentage(%)", "Number of rows(#)")
rownames(d) <- c("Training data", "Test data")
print(d)
```

```
##               Percentage(%) Number of rows(#)
## Training data           0.5              1500
## Test data               0.5              1500
```

--- .class #id

## Functionality

- When user changes the slider following gets updated:-
    - Train/test size split table
- When user clicks Run, following gets updated:- 
    - age v/s wage plot 
    - RMSE table
- Responsiveness
    - Adding of Run button was a conscious decision to maintain responsiveness
    - As RStudio server can be slow, user needs to know then an action is being taken
    - Other option was to reactively update plot when the slider is updated, but it was dropped.

--- .class #id

## Conclusion

- Need to have a good balance between training and test data sizes



