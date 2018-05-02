library(shiny)
library(shinydashboard)
library(leaflet)
library(readxl)
library(maps)
library(ggplot2)
#library(googleVis)
library(ggmap)
library(data.table)
library(httr)
library(dplyr)

source("./helpers.R")

bronx1=read_xls(paste0(data_directory,"2015_bronx.xls"),skip=4)
#View(bronx)
colnames(bronx1) = gsub('\\W','_',trimws(colnames(bronx1)))

bronx1= filter(bronx1,SALE_PRICE > 10)
bronx1= filter(bronx1,log10(as.integer(ZIP_CODE))>=4) %>% 
  mutate("ID" = as.character((1:(nrow(bronx1)-1))))#as.character to help inner join below.
bronx2=mutate(bronx1, City = 'New York',State="NY") %>% 
  select('Unique ID'=ID, 'Street address' = ADDRESS, City, State,
         ZIP = ZIP_CODE)
fwrite(bronx2,"bronx_2015_addresses.csv")
#Here I obtained a geocoded list of addresses by uploading uploading bronx_2015_addresses.csv
#by hand to https://geocoding.geo.census.gov/geocoder/locations/addressbatch 
bronxmap=fread('/Users/c.y./Documents/NYCDSA/Shiny/Shiny apps/NYRealEstate/Bronx2015geocoded.csv',
               header=FALSE, fill=TRUE)
colnames(bronxmap) = c('ID','Address','Match','Exact','Inferred','Latitude','Longitude','RL')
bronxmap$ID=type.convert(bronxmap$ID, as.is = T)
bronx_points=filter(bronxmap, Match=='Match') %>% 
  mutate(Longitude = sub(',.*','',Latitude),Latitude= sub(".*,",'',Latitude))
bronx_unmatched = filter(bronxmap, Match=='No_Match')
bronx3=inner_join(bronx_points,bronx1)

load_data = function(boroughs, year)
  #boroughs is a vector containing a range of numbers between 1 and 5
{
  rows_to_skip = (year%/%2011)+3 #In 2011, a 4th row is added before table starts.
  for (borough in boroughs)
  {
    path= paste0(data_directory,data_file_name(borough,year))
    data = read_xls(path, skip=rows_to_skip)
    colnames(data) = gsub('\\W','_',trimws(colnames(data)))
    data1 = mutate(data,"Unique ID" = (1:nrow(data)),
                       City = 'New York',State="NY") %>% 
               select('Unique ID', 'Street address' = ADDRESS, City, State,
                      ZIP = ZIP_CODE)
    
    #POST(https://geocoding.geo.census.gov/geocoder/locations/addressbatch,
      #   body = upload_file(path)
     # {
       # addressFile: data1,
        #benchmark: DatasetType_Public_AR
    #    }
    #  )
     
  }
  
}


#draw(gvisBronx)

#bronx_map('county','new york,bronx',plot=T)
#View(filter(map_data("county"),region =="new york"))