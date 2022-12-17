library(dplyr)
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(shinythemes)

source("~/info201/server.R")
source("~/info201/ui.R")

shinyApp(ui = ui, server = server)

