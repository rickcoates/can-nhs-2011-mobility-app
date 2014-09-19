data <- read.csv("CDN-NHS-2011-Migration.csv", stringsAsFactors=FALSE)
data$Age.Group <- factor(data$Age.Group)
data$Mobility.Years <- factor(data$Mobility.Years)

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    
    output$myPlot <- renderPlot({
        selected.area <- data[data$Area == input$anArea,]
        p <- ggplot(selected.area, aes_string(x="Age.Group", y=input$aVariable, fill="Mobility.Years")) + 
            geom_bar(stat="identity", position="dodge") +
            xlab("Age Group") +
            ylab("Number of migrants") +
            ggtitle(paste(sub("-"," ", gsub("\\.","-",input$aVariable)), "for", input$anArea))
        print(p)  
    })
    
})
