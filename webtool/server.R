function(input, output, session) {
  
  nyt_data <- reactive({
    print("Loading data")
    x <- input$reload
    load_data()
    
  })

  the_data <- reactive({
    tmp <- data.frame()
    for(s in input$states){
      tmp <- rbind(tmp, subset(nyt_data(), grepl(s, state)))
    }
    return(tmp)
    }) 
  
  facet_line_plot <- reactive({
    p <- ggplot(the_data(), 
              aes(x = timestamp, 
                  y = vote_differential)) +
    facet_wrap(~state, scales = "free_y", nrow = 2) +
    geom_smooth(method = "gam", colour = "black") +
    geom_point(aes(colour = leading_candidate_name)) +
    geom_hline(yintercept = 0) +
    scale_y_continuous(label = comma_format(accuracy = 1)) +
    scale_x_datetime(labels = date_format("%a-%d\n%H:%M", tz = "America/New_York" )) +
    scale_colour_manual(values = us_pal) +
    labs(x = "Time data published (US Eastern Standard Time)",
         y = "Number of votes leading by",
         colour = "Currently leading candidate") 
    
    return(p)
    
    
  })
  
  output$facet_line_plot <- renderPlot(facet_line_plot(), res = 100)
}