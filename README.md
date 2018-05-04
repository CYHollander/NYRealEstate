# NYRealEstate
Shiny App visualizing real estate sales in NYC

The most recent version of this app is accessible online at https://cyhollander.shinyapps.io/nyrealestate/ .

I intended this app as a visualization tool for examining real estate sales in New York City, drawing on data published
by the City of New York, which can be found at 
https://data.cityofnewyork.us/Housing-Development/Annualized-Rolling-Sales-Update/uzf5-f8n2 .

The data cover the years 2003-2015, and include a range of variables, including price, size, category of building, location,
and date of sale. The app is meant to display selections from this data on a map, to facilitate exploring the connections,
in particular, between time, location and price.

The logistics of handling the large amount of data present (~900,000 individual sales, with associated data points) were more
difficult for me to handle than I'd anticipated, so at present, the portion of the app that is complete only displays a small
portion of this data; specifically, sales that took place in the Bronx in 2015. These sales can be explored by location, as 
well as date, size (in gross square footage, which is to say total floor area), overall price, and price per square foot 
(again, in gross square footage).

As I update this app, I hope to make the rest of the data accessible the same way, as well as adding ways to explore
possible correlations among the data.
