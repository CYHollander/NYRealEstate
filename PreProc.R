#For commands (like data importing) that are meant to be run only once.

library(RSQLite)
library(data.table)
library(readxl)



#Given a year and a borough, returns the name of the 
#corresponding .xls file in the data folder
#borough is a number from 1 to 5
data_file_name = function (borough, year)
{
  boroughs1 =c('manhattan','bronx','brooklyn','queens','si')
  boroughs2 = append(boroughs1[1:4],'statenisland')

  return
  case_when(
    year >= 2003 & year <=2006 ~ 
      paste0('sales_',boroughs1[borough],'_0',year-2000,'.xls'),
    year == 2007 | year == 2008 ~
      paste0('sales_',year,'_',boroughs2[borough],'.xls'),
    year >= 2009 & year <= 2015 ~
      paste0(year,'_',boroughs2[borough],'.xls')
  )
}

load_data = function (boroughs

file_names=vector()
for (year in (3:6))
  for (name in boroughs1)
    file_names=c(file_names,paste0('sales_',name,'_0',year,'.xls'))

for (year in (2007:2008))
  for (name in boroughs2)
    file_names=c(file_names,paste0('sales_',year,'_',name,'.xls'))

for (year in (2009:2015))
  for (name in boroughs2)
    file_names=c(file_names,paste0(year,'_',name,'.xls'))

data_directory = './www/Annualized_20Rolling_20Sales_20Update/'
dbname = "./www/NYRealEstate.sqlite"
tblname = "NYRealEstate"

setwd("/Users/c.y./Documents/NYCDSA/Shiny/Shiny apps/NYRealEstate")
#2011 lead column added

## connect to database
conn <- dbConnect(drv = SQLite(), 
                  dbname = dbname)

for (i in (1:65))
{
#read data from xls file
rows_to_skip = (i%/%41)+3 #In 2011, a 4th row is added before table starts.
data=read_xls(paste0(data_directory,file_names[i]),skip=rows_to_skip)

## write data into table
#dbWriteTable(conn = conn,
             name = tblname,
             value = data,
             overwrite = FALSE,
             append = TRUE
             )
}

## list tables
dbListTables(conn)
## disconnect
dbDisconnect(conn)


