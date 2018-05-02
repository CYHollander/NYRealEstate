
maxwt=10

nyc=leaflet() %>% 
  addTiles() %>% 
  addProviderTiles("Esri.WorldStreetMap") 

server <- function(input, output, session) {
  output$nyc <- renderLeaflet({
    sales=filter(bronx3,SALE_DATE >= input$dates[1] & SALE_DATE <= input$dates[2])
    nyc %>% 
      addCircles(lng=as.numeric(sales$Longitude),
                 lat=as.numeric(sales$Latitude),
                 weight=case_when(input$wt=='Price' ~ sales$SALE_PRICE/max(sales$SALE_PRICE),
                   input$wt=='Square feet' ~ sales$GROSS_SQUARE_FEET/max(sales$GROSS_SQUARE_FEET),
                   input$wt=='Price per square foot' ~ sales$ppsqf/max(sales$ppsqf),
                   TRUE ~ 1/maxwt)*maxwt
      )
    })
}