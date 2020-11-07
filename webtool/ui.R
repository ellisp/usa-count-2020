fluidPage(
  
  titlePanel("United States of America Presidential Election, 2020"),
  
  sidebarLayout(
    
    sidebarPanel(
      checkboxGroupInput("states", "Battleground states:",  
                  choices = c("Arizona", "Nevada",
                              "Georgia", "Pennsylvania",
                              "North Carolina", "Alaska"),
                  selected = c("Georgia", "Pennsylvania")),
      actionButton("reload", "Reload data"),
      hr(),
      div(
        HTML(
          "<p>Data from the New York Times, as collected by <a href='https://alex.github.io/nyt-2020-election-scraper/battleground-state-changes.html'>
          this unofficial open source app</a> by 'Alex' and friends.</p>"
        )
      )
    ),
    
    mainPanel(
     plotOutput("facet_line_plot", height = "600px"),
     dataTableOutput("table")
      
    )
  )
)