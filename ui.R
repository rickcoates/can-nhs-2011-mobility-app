## read in the data and create the input selector choices
data <- read.csv("CDN-NHS-2011-Migration.csv", header = TRUE, stringsAsFactors=FALSE)
## put the areas in alphabetical order
area.choices <- unique(data$Area[order(data$Area)])
names(area.choices) <- area.choices
## the first two variables are not selectable since they are always
## represented in the same way on the migration data plot
variable.choices <- colnames(data)[-c(1:3)]
names(variable.choices) <- sub("-"," ", gsub("\\.","-",variable.choices))

library(shiny)
## create the two tab Shiny User Interface 
## (the first tab is the app the second is the doc)
shinyUI(navbarPage("Canadian Young Person Migration",
    tabPanel("Application",
        pageWithSidebar(
            headerPanel("Canadian Young Person Migration Data Product"),
            sidebarPanel(
                selectInput("anArea", "Geography", 
                            area.choices, 
                            selected = "Canada"),      
                selectInput("aVariable", "Migration Variable", 
                            variable.choices, 
                            selected = "External.in.migrants"),
                div(
                    tagList(
                        tags$h4("Quick Reference:"),
                        tags$p(
                            tags$ol(
                                tags$li("Select the geography of interest."),
                                tags$li("Select a migration variable of interest.")
                            )
                        ),
                        tags$p(
                            tags$em("See the "),
                            tags$strong("Documentation tab"),
                            tags$em(" for a full explanation of each Migration Variable.")
                        )    
                    )
                )
            ),
            mainPanel(
                plotOutput("myPlot")
            )
        )
    ),
    tabPanel("Documentation",        
        div(
            tagList(
                tags$h3("Canadian Young Person Migration Data Product Documentation"),
                tags$p(
                        tags$strong("Source:"),
                        tags$span(" Statistics Canada - 2011 National Household Survey. Catalogue Number 99-013-X2011027 and 99-013-X2011029")
                ),
                tags$p(
                    tags$strong("Explanation of Migration Variables:"),
                    tags$ol(
                        tags$li("When the geography refers to a census metropolitan area (CMA) or a census agglomeration (CA), in-migrants represent persons who did not live in this CMA or CA one or five years ago but did live there on the reference day, May 10, 2011.   When the geography refers to Canada, a province or a territory, 'in-migrants' refers to migrants, which are persons who moved to a different city, town, township, village or Indian reserve within Canada or persons who lived outside Canada on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years)."),
                        tags$li("Intraprovincial in-migrants are those who lived, on May 10, 2011, in the same province or territory that they lived in, on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years).   When the geography refers to Canada, a province or a territory, 'intraprovincial in-migrants' refers to intraprovincial migrants, which are persons who moved to a different city, town, township, village or Indian reserve within Canada but stayed within the same province or territory."),
                        tags$li("Interprovincial in-migrants are those who lived in a different province or territory on May 10, 2011, from the one they lived in on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years).   When the geography refers to Canada, a province or a territory, 'interprovincial in-migrants' refers to interprovincial migrants, which are persons who moved to a different city, town, township, village or Indian reserve within Canada, and changed province or territory."),
                        tags$li("External migrants include persons who lived outside Canada on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years)."),
                        tags$li("When the geography refers to a census metropolitan area (CMA) or a census agglomeration (CA), out-migrants represent persons who lived in this CMA or CA one or five years ago but did not live there on the reference day, May 10, 2011.   When the geography refers to Canada, 'out-migrants' refers to internal migrants, who are persons who moved to a different city, town, township, village or Indian reserve within Canada on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years).   When the geography refers to a province or a territory, 'out-migrants' refers to internal migrants, who lived within this province or territory on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years)."),
                        tags$li("Intraprovincial out-migrants are those who lived in the same province or territory on May 10, 2011, as they did on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years).   When the geography refers to Canada, a province or a territory, 'intraprovincial out-migrants' refers to intraprovincial migrants, which are persons who moved to a different city, town, township, village or Indian reserve within Canada but stayed in the same province or territory."),
                        tags$li("Interprovincial out-migrants are those who lived in different province or territory on May 10, 2011, than the one they lived in on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years).   When the geography refers to Canada, 'interprovincial out-migrants' refers to interprovincial migrants, which are persons who moved to a different city, town, township, village or Indian reserve within Canada but in a different province or territory.   When the geography refers to a province or a territory, 'interprovincial out-migrants' refers to persons who lived in this province or territory on May 10, 2006 (5 mobility years) or on May 10, 2010 (1 mobility years), but did not live there on the reference day, May 10, 2011.")
                    )
                ),
                tags$p(
                    tags$strong("Notes:"),
                    tags$ol(
                        tags$li("All figures include individuals of any gender and any mother tongue."),
                        tags$li("Estimates of internal migration may be less accurate for small geographic areas, areas with a place name that is duplicated elsewhere, and for some census subdivisions (CSDs) where residents may have provided the name of the census metropolitan area or census agglomeration instead of the specific name of the component CSD from which they migrated."),
                        tags$li("Mobility status - 1 mobility years refers to the status of a person with regard to the place of residence on the reference day, May 10, 2011, in relation to the place of residence on the same date one year earlier. Persons who have not moved are referred to as non-movers and persons who have moved from one residence to another are referred to as movers. Movers include non-migrants and migrants. Non-migrants are persons who did move but remained in the same city, town, township, village or Indian Reserve. Migrants include internal migrants who moved to a different city, town, township, village or Indian Reserve within Canada. External migrants include persons who lived outside Canada at the earlier reference date."),
                        tags$li("Mobility status - 5 mobility years refers to the status of a person with regard to the place of residence on the reference day, May 10, 2011, in relation to the place of residence on the same date five years earlier. Persons who have not moved are referred to as non-movers and persons who have moved from one residence to another are referred to as movers. Movers include non-migrants and migrants. Non-migrants are persons who did move but remained in the same city, town, township, village or Indian Reserve. Migrants include internal migrants who moved to a different city, town, township, village or Indian Reserve within Canada. External migrants include persons who lived outside Canada at the earlier reference date.")
                    )
                )                
            )
        )
    )
))