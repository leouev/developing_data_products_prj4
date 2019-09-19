library(shiny)
library(shinyWidgets)
library(shinythemes)
library(plotly)

shinyUI(fluidPage(
        ## change the appearance of the shiny page
        theme = shinytheme("cerulean"),
        titlePanel("DashBoard -- Aibnb New York 2019 Listing Activity (Until July)"),
        tabsetPanel(
                type = "pills",
                ## tab1
                tabPanel("List map", br(),
                         leafletOutput("leaflet_map")
                ),
                ## tab2
                tabPanel("Prices Insights", br(), 
                        sidebarPanel(
                                sliderInput("price_range", "Price US$",
                                            0, 10000, value = c(0, 1000)),
                                checkboxInput("Brooklyn", "Brooklyn", value = TRUE),
                                checkboxInput("Bronx", "Bronx", value = TRUE),
                                checkboxInput("Manhattan", "Manhattan", value = TRUE),
                                checkboxInput("Queens", "Queens", value = TRUE),
                                checkboxInput("Staten Island", "Staten Island", value = TRUE)
                        ),
                        mainPanel(
                                splitLayout(
                                        plotOutput("out3"), plotOutput("out2")),
                                hr(),plotOutput("out1")
                        )
                )
                
        )
        )
)
