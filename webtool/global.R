library(shiny)
library(ggplot2)
library(readr)
library(scales)
library(plotly)

my_theme <- theme_light() + 
  theme(legend.position = "bottom") +
  theme(plot.caption = element_text(colour = "grey50"),
        strip.text = element_text(size = rel(1), face = "bold"))

theme_set(my_theme)     


lapply(list.files("R", pattern = "\\.R$", full.names = TRUE),
       source)

us_pal = c(Biden = "#1405bd", Trump = "#de0100")

