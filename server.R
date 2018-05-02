
avgprice=mean(bronx1$SALE_PRICE)

nyc=leaflet() %>% 
  addTiles() %>% 
  addProviderTiles("Esri.WorldStreetMap") %>% 
  setView(lng = -73.9, lat = 40.8, zoom = 10) %>% 
  #addMarkers(lng=-74.0059, lat=40.7128, popup="New York City") %>% 
# Add default OpenStreetMap map tiles
  addCircles(lng=as.numeric(bronx3$Longitude),
           lat=as.numeric(bronx3$Latitude),
           weight=bronx3$SALE_PRICE/(avgprice*10)) 
  #setView(lng = -74.0059, lat = 40.7128, zoom = 12) 
#

server <- function(input, output, session) {
  output$nyc <- renderLeaflet({
    nyc
    })
}