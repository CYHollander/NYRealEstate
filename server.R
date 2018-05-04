
maxwt=40
centermap=c((max(bronx3$Longitude)+min(bronx3$Longitude))/2,
            (max(bronx3$Latitude)+min(bronx3$Latitude))/2)
#sapply(bronx3,typeof)

nyc=leaflet() %>% 
  setView(lng=centermap[1], lat=centermap[2],zoom = 12) %>% 
  addTiles() %>% 
  addProviderTiles("Esri.WorldStreetMap") 

server <- function(input, output, session) {
  output$nyc <- renderLeaflet(nyc)
  
  observeEvent(c(input$dates, input$wt), {
    sales=filter(bronx3,SALE_DATE >= input$dates[1] & SALE_DATE <= input$dates[2])
    leafletProxy("nyc") %>% 
      clearShapes() %>% 
      addCircles(lng=as.numeric(sales$Longitude),
                 lat=as.numeric(sales$Latitude),
                 weight=case_when(input$wt=='Price' ~ sales$SALE_PRICE/max(sales$SALE_PRICE),
                   input$wt=='Square feet' ~ sales$GROSS_SQUARE_FEET/max(sales$GROSS_SQUARE_FEET),
                   input$wt=='Price per square foot' ~ sales$ppsqf/max(sales$ppsqf),
                   TRUE ~ 2/maxwt)*maxwt,
                 color=c('blue','red')[1+as.integer(substring(sales$TAX_CLASS_AT_PRESENT,1,1))%/%3]
      )
    })
}