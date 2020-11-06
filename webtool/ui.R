fluidPage(
  
  titlePanel("Hello Shiny!"),
  
  sidebarLayout(
    
    sidebarPanel(
      checkboxGroupInput("states", "Battleground states:",  
                  choices = c("Arizona", "Nevada",
                              "Georgia", "Pennsylvania"),
                  selected = c("Georgia", "Pennsylvania")),
      actionButton("reload", "Reload data")
    ),
    
    mainPanel(
      plotlyOutput("facet_line_plot")
    )
  )
)