source("setup.R")

d <- load_data()

latest_data <-  date_format("%A %d %B %H:%M", tz = "America/New_York" )(
  max(d$timestamp)
)

p <-  d %>%
  filter(!grepl("Alaska", state) & !grepl("North Carolina", state)) %>%
  ggplot(aes(
           x = timestamp, 
           y = vote_differential )) +
  facet_wrap(~state, scales = "free_y", nrow = 2) +
  geom_smooth(method = "gam", fullrange = TRUE, colour = "black") +
  geom_point(aes(colour = leading_candidate_name)) +
  geom_hline(yintercept = 0) +
  scale_y_continuous(label = comma_format(accuracy = 1)) +
  scale_x_datetime(
      #limits = as.POSIXct(c("2020/11/05", "2020/11/08")),
       labels = date_format("%a-%d\n%H:%M", tz = "America/New_York" )) +
  scale_colour_manual(values = us_pal) +
  labs(x = "Time data published (US Eastern Standard Time)",
       y = "Number of votes Biden leading by",
       colour = "Currently leading candidate",
       title = "Biden lead in four critical states",
       subtitle = "US Presidential election, 2020",
       caption = glue("Latest data = {latest_data}, US Eastern Standard Time")) +
  theme(legend.position = "bottom")

svg_png(p, "output/latest", 11, 8)
