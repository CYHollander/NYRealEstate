dashboardPage( 
  dashboardHeader(title="N.Y.C. Housing Prices"), 
  dashboardSidebar(
    sidebarUserPanel("C. Y.", image = "Face.jpg")),
  dashboardBody(leafletOutput("nyc"))
)