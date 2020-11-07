function(input, output, session) {
  
  #------------------Data----------------
  
  nyt_data <- reactive({
    print("Loading data")
    x <- input$reload
    load_data()
    
  })

  the_data <- reactive({
    if(is.null(input$states)){
     tmp <- nyt_data() 
    } else {
      tmp <- data.frame()
      for(s in input$states){
        tmp <- rbind(tmp, subset(nyt_data(), grepl(s, state)))
      }
    }
    return(tmp)
    }) 
  
  #-------------------Chart---------------------
  
  facet_line_plot <- reactive({
    latest_data <-  date_format("%A %d %B %H:%M", tz = "America/New_York" )(
      max(the_data()$timestamp)
    )
    
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
         y = "Number of votes Biden leading by",
         colour = "Currently leading candidate",
         caption = glue("Latest data = {latest_data}, US Eastern Standard Time")) 
    
    return(p)
    
    
  })
  
  output$facet_line_plot <- renderPlot(facet_line_plot(), res = 100)
  
  #-------------Table---------------
  the_table <- reactive({
    tt <- the_data() %>%
      group_by(state) %>%
      arrange(desc(timestamp)) %>%
      slice(1:3) %>%
      select(State = state, 
             `Time of update` = timestamp, 
             `Biden's lead` = vote_differential) %>%
      ungroup() 
    return(tt)
  })
  
  output$table <- renderDataTable(the_table(), 
                                  filter = "none",
                                  options = list(
                                    paging = FALSE,
                                    searching = FALSE,
                                    info = FALSE,
                                    ordering = FALSE
                                  ))
}