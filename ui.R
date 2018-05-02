mindate=min(bronx3$SALE_DATE)
maxdate=max(bronx3$SALE_DATE)
dashboardPage( 
  dashboardHeader(title="N.Y.C. Housing Prices"), 
  dashboardSidebar(
    sidebarUserPanel("C. Y.", image = "Face.jpg"),
    selectizeInput(inputId="year",
                   label="Year",
                   choices=(2015)),
    selectizeInput("wt",
                   label="Weight by",
                   choices=c('Constant','Price','Square feet','Price per square foot')
                    )
    ),
  dashboardBody(leafletOutput("nyc"),
                sliderInput("dates",
                            "Months:",
                            min = mindate,
                            max = maxdate,
                            value = c(mindate,maxdate))
                )
)