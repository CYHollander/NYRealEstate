dashboardPage( 
  dashboardHeader(title="N.Y.C. Housing Prices"), 
  dashboardSidebar(
    sidebarUserPanel("C. Y.", image = "Face.jpg"),
    selectizeInput(inputId="year",
                   label="Year",
                   choices=(2003:2015))),
  dashboardBody(leafletOutput("nyc"))
)