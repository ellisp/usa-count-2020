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
      plotOutput("facet_line_plot", height = "600px")
    )
  )
)