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
  
  p <- reactive({
    ggplot(the_data(), 
              aes(x = timestamp, 
                  y = vote_differential, 
                  colour = leading_candidate_name)) +
    facet_wrap(~state, scales = "free_y", nrow = 2) +
    geom_smooth(method = "gam", fullrange = TRUE) +
    geom_point() +
    geom_hline(yintercept = 0) +
    scale_y_continuous(label = comma_format(accuracy = 1)) +
    scale_x_datetime(limits = as.POSIXct(c("2020/11/05", "2020/11/07")),
                     labels = date_format("%a-%d\n%H:%M", tz = "America/New_York" )) +
    scale_colour_manual(values = us_pal) +
    labs(x = "Time data published (US Eastern Standard Time)",
         y = "Number of votes leading by",
         colour = "Currently leading candidate") +
    theme(legend.position = "bottom")
  })
  
  output$facet_line_plot <- renderPlotly(p())
}