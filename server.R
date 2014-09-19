## read in the data and create the factors needed for ggplot
data <- read.csv("CDN-NHS-2011-Migration.csv", stringsAsFactors=FALSE)
data$Age.Group <- factor(data$Age.Group)
data$Mobility.Years <- factor(data$Mobility.Years)

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    
    ## create the reactive plot
    output$myPlot <- renderPlot({
        ## set the selected area based on a UI selectInput widget selection
        selected.area <- data[data$Area == input$anArea,]
        ## the specific migration variable to plot on the y-axis is
        ## set by a UI selectInput widget selection
        ## Note: the plot title is customized based on both the selected
        ## migration variable and the selected geographical area
        p <- ggplot(selected.area, aes_string(x="Age.Group", y=input$aVariable, fill="Mobility.Years")) + 
            geom_bar(stat="identity", position="dodge") +
            xlab("Age Group") +
            ylab("Number of migrants") +
            ggtitle(paste(sub("-"," ", gsub("\\.","-",input$aVariable)), "for", input$anArea))
        print(p)  
    })
    
})
