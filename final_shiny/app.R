# mapping Boston
# because it takes too long to display all the listings for four different regions. 
# here in Shiny App, I only display the airbnb listings in Boston area.
# text analysis (wordcloud)
#-----------------------------------------------------------------------------------------
pacman::p_load("ggplot2","tidyverse","dplyr","tidyr","tinytex","magrittr","DT","readxl",
               "shiny","shinydashboard","plotly","readxl","abind","gridExtra","scales", "leaflet", "RColorBrewer",
               "scales", "lattice", "leaflet.extras", "htmlwidgets", "maps","tidytext","wordcloud","stringr")

pal2 <- brewer.pal(3, "Dark2")
get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")
#-----------------------------------------------------------------------------------------
# Import Airbnb listing data
load("bos_data_list.RData")
# Import Airbnb review data
load("bos_data_review2.RData")
load("la_data_review2.RData")
load("ny_data_review2.RData")
load("hawa_data_review2.RData")

#com_list %<>% mutate(neighborcity = paste0(neighbourhood, " (", region,")"))
## ui ##----------------------------------------------------------------------------------
ui <- fluidPage(
    navbarPage("Airbnb listings",
        tabPanel("Airbnbs in Boston", 
                 mainPanel(
                     selectInput("neighbourhood","Select a neighbourhood",unique(bos_list$neighbourhood)),
                     #selectInput("neighbor","Select a neighborhood,",unique(com_list$neighborcity)),
                     leafletOutput(outputId = "mymap_bos")
                     )
                 ),
        tabPanel("Boston wordcloud", plotOutput("wordcloud_b")),
        tabPanel("New York wordcloud", plotOutput("wordcloud_n")),
        tabPanel("Los Angeles wordcloud", plotOutput("wordcloud_l")),
        tabPanel("Hawaii wordcloud", plotOutput("wordcloud_h"))
    )
)
## server ## -----------------------------------------------------------------------------
server <- function(input, output, session) {
    icons <- awesomeIcons(
        icon = 'bed',
        iconColor = 'black',
        library = 'glyphicon', # Options are 'glyphicon', 'fa', 'ion'.
        markerColor = 'lightred', 
        squareMarker = TRUE
    )
    
    # wordcloud from the reviews of listings in Boston
    output$wordcloud_b <- renderPlot({
        wordfreq_bos=tibble(bos_review$comments) %>%
            rename(comments=`bos_review$comments`) %>%
            sample_n(100) %>%
            unnest_tokens(word, comments) %>%
            anti_join(stop_words) %>%
            count(word, sort = TRUE)
        wordcloud(wordfreq_bos$word, freq = wordfreq_bos$n, scale=c(2, 0.9), max.words = 100,
                  rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))
    })
    # wordcloud from the reviews of listings in New York
    output$wordcloud_n <- renderPlot({
        wordfreq_ny=tibble(ny_review$comments) %>%
            rename(comments=`ny_review$comments`) %>%
            sample_n(100) %>%
            unnest_tokens(word, comments) %>%
            anti_join(stop_words) %>%
            count(word, sort = TRUE)
        wordcloud(wordfreq_ny$word, freq = wordfreq_ny$n, scale=c(2, 0.9), max.words = 100,
                  rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))
    })
    # wordcloud from the reviews of listings in Los Angeles
    output$wordcloud_l <- renderPlot({
        wordfreq_la=tibble(la_review$comments) %>%
            rename(comments=`la_review$comments`) %>%
            sample_n(100) %>%
            unnest_tokens(word, comments) %>%
            anti_join(stop_words) %>%
            count(word, sort = TRUE)
        wordcloud(wordfreq_la$word, freq = wordfreq_la$n, scale=c(2, 0.9), max.words = 100,
                  rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))
    })
    # wordcloud from the reviews of listings in Hawaii
    output$wordcloud_h <- renderPlot({
        wordfreq_hawa=tibble(hawa_review$comments) %>%
            rename(comments=`hawa_review$comments`) %>%
            sample_n(100) %>%
            unnest_tokens(word, comments) %>%
            anti_join(stop_words) %>%
            count(word, sort = TRUE)
        wordcloud(wordfreq_hawa$word, freq = wordfreq_hawa$n, scale=c(2, 0.9), max.words = 100,
                  rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))
    })
#-----------------------------------------------------------------------------------------
    neighbourdata_bos <- reactive({
        neighbourdata_bos <- bos_list %>% subset(neighbourhood == input$neighbourhood)
        return(neighbourdata_bos)
    })
    colorpal_bos <- reactive({
        colorNumeric(
            palette="Reds", neighbourdata_bos()$number_of_reviews
            )
        })
    # Draw map
    output$mymap_bos <- renderLeaflet({
        
        pal_bos <- colorpal_bos()
        
        leaflet(data = neighbourdata_bos()) %>% 
            setView(-71.060311,42.359087, zoom = 10) %>%
            addProviderTiles("CartoDB.Positron", group = "Map") %>%         
            addProviderTiles("Esri.WorldImagery", group = "Satellite") %>%      
            addProviderTiles("Esri.WorldStreetMap", group = "Street") %>%
            addProviderTiles("Stamen.Watercolor", group = "Watercolor") %>%
            addCircles(data = neighbourdata_bos(), lat = ~lat, lng = ~lon, weight = 1,
                       radius = 30, label = ~as.character(list_name),
                       color=~pal_bos(number_of_reviews)) %>%
            addAwesomeMarkers(~lon, ~lat, label = ~list_name, popup = ~as.character(list_name),
                             group = "Listings", icon=icons) %>%
            addScaleBar(position = "bottomleft") %>%   
            #addPolygons(data=bounds, group="States", weight=2, fillOpacity = 0) %>%
            addLayersControl(
                baseGroups = c("Map", "Satellite", "Street", "Watercolor"),
                overlayGroups = c("Listings"),
                options = layersControlOptions(collapsed = FALSE)
            )
    })
 
}

# Run the application 
shinyApp(ui = ui, server = server)


