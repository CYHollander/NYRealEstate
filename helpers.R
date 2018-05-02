library(data.table)
library(readxl)

data_directory = './www/Annualized_20Rolling_20Sales_20Update/'
data_file_name = function(borough, year)
#borough is a number from 1 to 5
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