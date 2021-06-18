#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(kableExtra)
library(dplyr)
library(ggplot2)

data <- read.csv("Inventors.csv")

ui <- dashboardPage(
    skin = "black",
    dashboardHeader(
        title = "Group Homework",
        titleWidth = 350
    ),
    
    dashboardSidebar(
        width = 350,
        tags$img(src = "InventorsandInventionsPack.jpg", height="100%", width="100%", align="bottom"),
        
        sidebarMenu(
            menuItem(h3(strong("Inventors Table")), tabName = "inventors"),
            menuItem(h3(strong("Top Inventors")), tabName = "topins"),
            menuItem(h3(strong("Age Vs Invention")), tabName = "agevinv"),
            menuItem(h3(strong("Countries vs Inventions")), tabName = "covsin"))
    ),
    
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(
                tabName = "inventors",
                h4(strong("The following table shows the Name, Country, Born Year,Age and Inventions of the inventors from our database.")),
                h4(strong("The data is filtered such that the result includes either the selected country or the given name.")),
                fluidRow(
                    column(4, textInput("name", "Inventor Name", value = "Ivan Knunyants")),
                    column(4,selectInput("country", "Country", choices =  unique(as.character(data$Country)), selected = "Armenia")),
                ),
                htmlOutput("invntrstbl")
            ),
            
            # Second tab content
            tabItem(tabName = "topins",
                    h4(strong("The following graph shows the number of Top inventors with given count by the user.")),
                    h4(strong("Please, select the number of countries to see. The default is 10.")),
                    sliderInput("topn", "Top countries by number of inventors", min = 1, max = 20, value = 10, step = 1),
                    plotOutput("barplt")
            ),
            
            # Third tab content
            tabItem(tabName = "agevinv",
                    h4(strong("The following graph shows the relationship between life span and the invention numbers of inventors.")),
                    h4(strong("Please, select the limits for X and Y axes.")),
                    fluidRow(
                        column(5, sliderInput("xlim", "X coordinate limits", min = 1, max = 110, value = c(10, 130))),
                        column(5 ,sliderInput("ylim", "X coordinate limits", min = 0, max = 10, value = c(1, 3))),
                    ),
                    plotOutput("scttr")
                    
            ),
            
            # Forth tab content
            tabItem(tabName = "covsin",
                    h4(strong("The following graph shows the countries having the highest number of inventions.")),
                    h4(strong("Please, select the number of countries to see. The default is 10.")),
                    column(4, numericInput("cnum", "Top countries by number of inventions", 10, min = 1, max = 20)),
                    plotOutput("covsinplot")
                    
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
   output$invntrstbl <- renderText({ 
      
       inventors <- data %>%
           select(Name, Country, BornYear, Age, Invention) %>%
           filter((Country %in% input$country) | (Name %in% input$name)) 
       
       kable(inventors) %>%
           kable_styling(latex_options = "striped") %>%
           column_spec(1, bold = TRUE, italic = TRUE)
   })
   
   output$barplt <- renderPlot({
       data%>%
           select(Name,Country)%>%
           filter(complete.cases(Country))%>%
           group_by(Country) %>%
           summarise(Count = n()) %>%
           arrange(desc(Count))%>%
           head(n= input$topn)%>%
           ggplot(aes(x=reorder(Country,Count),y=Count, fill=Count))+
           geom_histogram(stat="identity")+
           labs(title=paste("The top", input$topn, "countries by number of inventors"), 
                x="Country", y="Number of inventors")+
           scale_y_continuous(n.breaks = 10)+
           coord_flip()+
           theme_minimal()
   })
   
   output$scttr <- renderPlot({
       data%>%
           filter(complete.cases(Age) & complete.cases(InventonNumber))%>%
           ggplot(aes(x=Age, y=InventonNumber)) + 
           geom_point() +
           geom_smooth(method="loess", se=F) + 
           xlim(input$xlim)+ylim(input$ylim)+
           labs(title ="Age Vs Invention Number", 
                y="Invention number", 
                x="Age")
   })
   
   output$covsinplot <- renderPlot({
       data%>%
           select(InventonNumber,Country)%>%
           filter(complete.cases(Country) & complete.cases(InventonNumber))%>%
           group_by(Country) %>%
           summarise(avg_num_of_inv = mean(InventonNumber))%>%
           arrange(desc(avg_num_of_inv))%>%
           head(n= input$cnum)%>%
           ggplot(aes(x=reorder(Country,-avg_num_of_inv), y=avg_num_of_inv, fill = cut(avg_num_of_inv, 100)))+
           geom_histogram(stat="identity", show.legend = F)+
           scale_fill_discrete(h = c(240, 10), c = 120, l = 70)+
           theme_minimal()+
           theme(axis.text.x =element_text(angle=90,hjust = 1))+
           labs(title=paste("The top", input$cnum,"countries by number of inventions"), 
                x="Country", y="Number of inventions")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)
