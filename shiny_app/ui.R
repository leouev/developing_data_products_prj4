library(shiny)
library(shinyWidgets)
library(shinythemes)
library(plotly)
library(leaflet)
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
                ),
                ## tab3
                tabPanel("Documentation", br(),
                         p(h3("List map")),
                         br(),
                         helpText("In the tab 'list map', the map shows the distribution of 2019 New York City's Airbnb lists,
                                  The number in the map shows the list numbers in the area,
                                  By clicking the numbers, you will zoom into that area,
                                  When zoom to the 'Airbnb' logo, you can check the list name of the unit"),
                         
                         p(h3("Prices Insights")),
                         br(),
                         helpText("In the tab 'Price Insights', you will have a side panel to filter your choices.\n
                                  In the slider you will choose the price range you care about.
                                  In the five check boxes below, you can choose multiple neighbourhood area for comparison.
                                  The dashboar panel on the right will show the data you choose.
                                  "),
                         p(h3("About")),
                         br(),
                         helpText("This website is generated using data extracted from New York City Airbnb Open Data
                                   Airbnb listings and metrics in NYC, NY, USA (2019), more details could be find at
                                   https://www.kaggle.com/dgomonov/new-york-city-airbnb-open-data
                                  ")
                )
                
                
                
        )
        )
)
