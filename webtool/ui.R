fluidPage(
  
  titlePanel("United States of America Presidential Election, 2020"),
  
  sidebarLayout(
    
    sidebarPanel(
      checkboxGroupInput("states", "Battleground states:",  
                  choices = c("Arizona", "Nevada",
                              "Georgia", "Pennsylvania",
                              "North Carolina", "Alaska"),
                  selected = c("Georgia", "Pennsylvania")),
      actionButton("reload", "Reload data")
    ),
    
    mainPanel(
     plotOutput("facet_line_plot", height = "600px"),
     dataTableOutput("table")
      
    )
  )
)