library(shiny)
library(shinydashboard)
library(leaflet)
library(readxl)
library(maps)
library(ggplot2)
library(googleVis)
library(ggmap)

#bronx=read_excel("/Users/c.y./Documents/NYCDSA/Shiny/Shiny apps/NYRealEstate/www/Annualized_20Rolling_20Sales_20Update/2015_bronx.xls")
#View(bronx)
#bronx1= bronx[5:nrow(bronx),]
#colnames(bronx1)= as.character(unlist(bronx[4,]))
#colnames(bronx1) = gsub('\\W','_',trimws(colnames(bronx1)))

#bronx1= filter(bronx1,SALE_PRICE > 10)
#bronx1= filter(bronx1,log10(as.integer(ZIP_CODE))>=4)
#bronx3=mutate(bronx1,"Unique ID" = (1:nrow(bronx1)),
#            City = 'New York',State="NY", 
#            ADDRESS = sub(',','',ADDRESS)) %>% 
#    select('Unique ID', 'Street address' = ADDRESS, City, State,
#           ZIP = ZIP_CODE)

#bronx2= mutate(bronx1,"Unique ID" = (1:nrow(bronx1)),
 #               City = NULL) %>% 
#       select('Unique ID', 'Street address' = ADDRESS)
       
#gvisBronx = gvisGeoMap(bronx1,'ADDRESS', 'SALE_PRICE', options=
  #                       list(region='us_metro'))


#draw(gvisBronx)
#bronxmap=fread('/Users/c.y./Documents/NYCDSA/Shiny/Shiny apps/NYRealEstate/Bronx2015geocoded.csv')
#colnames(bronxmap) = c('ID','Address','Match','Exact','Inferred','Latitude','Longitude','RL')
#bronx_map('county','new york,bronx',plot=T)
#View(filter(map_data("county"),region =="new york"))
bronx_points=filter(bronxmap, Match=='Match') %>% 
 mutate(Longitude = sub(',.*','',Latitude),Latitude= sub(".*,",'',Latitude))
bronx_unmatched = filter(bronxmap, Match=='No_Match')