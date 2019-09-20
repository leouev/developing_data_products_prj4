library(shiny)
library(googleVis)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(leaflet)

shinyServer(function(input, output) {
        ## download the file
        if(!file.exists("AB_NYC_2019.csv")){
                unzip("AB_NYC_2019.csv.zip")
        }
        ## read the csv file
        airbnbny <- read.csv("AB_NYC_2019.csv")
        airbnbny$location <- paste(airbnbny$latitude, ":", airbnbny$longitude)
        airbnbny$last_review <- as.Date(airbnbny$last_review)
        
        ## percent function
        percent <- function(x, digits = 2, format = "f", ...) {
                paste0(formatC(100 * x, format = format, digits = digits, ...), "%")
        }
        
        
        ## output

        
        output$out1 <- renderPlot({
                airbnbny1 <- airbnbny %>%
                        filter( price >= min(input$price_range) & price <= max(input$price_range)) %>%
                        filter( (neighbourhood_group == if_else(input$Brooklyn,"Brooklyn",""))
                                 | (neighbourhood_group == if_else(input$Bronx,"Bronx", ""))
                                 | (neighbourhood_group == if_else(input$Manhattan,"Manhattan",""))
                                 | (neighbourhood_group == if_else(input$Queens,"Queens",""))
                                 | (neighbourhood_group == if_else(input$`Staten Island`,"Staten Island",""))
                                )
                
                plot1 <- ggplot(data = airbnbny1, aes(x = room_type, y = price, fill = room_type)) +
                                geom_boxplot(color = "grey40") +
                                theme_minimal() +
                                scale_fill_brewer() +
                                ggtitle("Room Type vs Prices")
                plot1
        }, bg = "transparent")
        
        output$out2 <- renderPlot({
                airbnbny2 <- airbnbny %>%
                        filter( price >= min(input$price_range) & price <= max(input$price_range)) %>%
                        filter( (neighbourhood_group == if_else(input$Brooklyn,"Brooklyn",""))
                                | (neighbourhood_group == if_else(input$Bronx,"Bronx", ""))
                                | (neighbourhood_group == if_else(input$Manhattan,"Manhattan",""))
                                | (neighbourhood_group == if_else(input$Queens,"Queens",""))
                                | (neighbourhood_group == if_else(input$`Staten Island`,"Staten Island",""))
                        )
                
                plot2 <- ggplot(data = airbnbny2, aes(x = price, fill = room_type)) + 
                                geom_histogram() + 
                                xlim(input$price_range) +
                                theme_minimal() +
                                scale_fill_brewer() +
                                ggtitle("Price Distribution")
                plot2
        },bg = "transparent")
        
        output$out3 <- renderPlot({
                airbnbny3 <- airbnbny %>%
                        filter( price >= min(input$price_range) & price <= max(input$price_range)) %>%
                        filter( (neighbourhood_group == if_else(input$Brooklyn,"Brooklyn",""))
                                | (neighbourhood_group == if_else(input$Bronx,"Bronx", ""))
                                | (neighbourhood_group == if_else(input$Manhattan,"Manhattan",""))
                                | (neighbourhood_group == if_else(input$Queens,"Queens",""))
                                | (neighbourhood_group == if_else(input$`Staten Island`,"Staten Island",""))
                        )
                airbnb3 <- airbnbny3 %>%
                                group_by(room_type) %>%
                                summarise(count = n()/nrow(airbnbny3))
                
                plot3 <- ggplot(data = airbnb3, aes(x = "", y = count, fill = room_type)) + 
                                geom_bar(width = 1, stat = "identity") +
                                coord_polar("y", start = 0) +
                                geom_text(aes(label = percent(count)), position = position_stack(vjust = 0.5), color = "black", size = 5) +
                                theme_void()+
                                scale_fill_brewer() +
                                ggtitle("Room Type Ratio")
                plot3
        }, bg = "transparent")
        
        output$leaflet_map <- renderLeaflet({
                
                ## leaflet map
                
                        airbnbicon <- makeIcon(
                                iconUrl = "https://www.stickpng.com/assets/images/580b57fcd9996e24bc43c513.png",
                                iconWidth = 31*2000/625, iconHeight = 31,
                                iconAnchorX = 31*2000/625/2, iconAnchorY = 16
                        )
                        airbnbny %>%
                        leaflet() %>%
                        addTiles() %>%
                        addMarkers(icon = airbnbicon, 
                                   popup = airbnbny$name, clusterOptions = markerClusterOptions())
                
                
        })
}) 
