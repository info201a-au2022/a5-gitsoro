library(dplyr)
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(shinythemes)

source("~/info201/server.R")
ddata <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


intropage <- tabPanel(
  h1("Introduction"), br(),
  p("The issue of climate change is one that must be analyzed and monitored. 
    Climate change only continues to grow as a problem that effects all of us 
    that live on Earth. This page takes a look into the Carbon Dioxide - CO2 
    Emission levels around the world. The goal of the page is to spread awareness 
    and promote proactivity in changing our lifestyles to combat climate change."),
  
  h2(strong("Analyzing the Data")),
  p("This project analyzes the CO2 emission levels around the world over the past 50 years.
    Over the past 50 years, the average CO2 emission level across all countries was 14810.
    We took this number and compared it to the CO2 emission level of the highest CO2 emitting
    country in the world, which was the United States at a level of 416899.53. This shows 
    a vast difference in CO2 emission levels in the US, especially if you compare it to the
    lowest CO2 emitting country, Tuvalu, which emitted only 0.28. We also took the average CO2 level
    from 1970, and compared it to the average of 2020. In this 50 year span, the difference in
    emission levels was 10394.27. To better digest and explore CO2 emission levels, we have
    provided visualizations.")
)

countryint <- selectInput(
  inputId = "country_var",
  label = "Country:",
  choices = unique(filters$country)
)
yearint <- sliderInput(
  inputId = "year",
  label = "Year: ",
  min = 1970,
  max = 2020,
  value = c(1970, 2020)
)

vizz <- fluidPage(
  titlePanel("Carbon Dioxide Emission by Year"),
  sidebarLayout(
    sidebarPanel(
      countryint,
      yearint,
      p("This visualization shows the relation between CO2 emissions and each year
        of the past 50 years. It is clear to see that CO2 emission levels have been on 
        the rise.")
    ),
    mainPanel(
      plotlyOutput("pplot")
    )
  )
)

ui <- navbarPage(
  "Analysis of Carbon Dioxide Emission Levels",
  theme = shinytheme("darkly"),
  intropage,
  vizz
)