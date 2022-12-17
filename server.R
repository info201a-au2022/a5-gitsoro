library(dplyr)
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

ddata <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


filters <- ddata %>%
  filter(country != "World" & country != "North America"
         & country != "Europe" 
         & country != "Asia" 
         & country != "High-income countries" 
         & country != "Upper-middle-income countries", year > 1969)

co2e_avg <- filters %>%
  filter(year == max(year, na.rm=T)) %>%
  summarise(cumulative_co2 = mean(cumulative_co2, na.rm = T)) %>%
  pull(cumulative_co2)

hicountry <- filters %>%
  filter(year == '2020') %>%
  filter(cumulative_co2 == max(cumulative_co2, na.rm = T)) %>%
  pull(country)

usnumber <- filters %>%
  filter(country == "United States") %>%
  filter(year == '2020') %>%
  filter(cumulative_co2 == max(cumulative_co2, na.rm = T)) %>%
  pull(cumulative_co2)

locountry <- filters %>%
  filter(year == '2020') %>%
  filter(cumulative_co2 == min(cumulative_co2, na.rm = T)) %>%
  pull(country)

tuvalunumber <- filters %>%
  filter(country == "Tuvalu") %>%
  filter(year == '2020') %>%
  filter(cumulative_co2 == min(cumulative_co2, na.rm = T)) %>%
  pull(cumulative_co2)

diffcum <- filters %>%
  filter(year == 1970 | year == 2020) %>%
  group_by(year) %>%
  summarise(cumulative_co2 = mean(cumulative_co2, na.rm = T)) %>%
  summarise(diffy = max(cumulative_co2) - min(cumulative_co2)) %>%
  pull(diffy)
  

server <- function(input, output) {
  output$linegraph <- renderPlotly ({
    gdata <- filters %>%
      filters(country %in% input$country)
    pplot <- ggplot(data = gdata, mapping = aes(x = year, y = co2)) +
      geom_line(aes(color = country)) + 
      labs(x = "Year", y = "Cumulative CO2 Emissions",
           title = "Carbon Dioxide Emissions of Countries Around the World (1970-2021)") +
      scale_color_manual(values = input$pickcolor)
  })
}