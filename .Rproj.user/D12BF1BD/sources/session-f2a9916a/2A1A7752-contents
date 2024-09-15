#
# First, the necessary libraries:
library(janitor)
library(digest)
library(shiny)
require(shinydashboard)
require(shinydashboardPlus)
library(ggplot2)
library(dplyr)
library(data.table)
library(DT)
library(feather)
library(dygraphs)
library(xts)
library(corrplot)
library(plotly)
library(tidyverse)
library(sf)
library(leaflet)
library(htmltools)
library(htmlwidgets)
library(excelR)
library(treemapify)
library(ggiraph)
library(ggfittext)
library(tidyverse)
library(stringr)
library(leafem)
library(sp)


#===========================================
#  U  S  E  R --  I  N  T  E  R  F  A  C  E
#===========================================
#completing the ui part with dashboardPage

ui <- dashboardPage(
    skin = "midnight",
    header <- dashboardHeader(
        title = span(tagList(tags$img(src = "Loewy_NotepadPlusPlus_Logo_1_Grey_BG.svg", width = "50", height = "50"), "GSIF 2024"
        ))),
    
    
    sidebar <- dashboardSidebar(
        
        sidebarMenu(
            tags$img(src = "MetalMatter_Logo.svg", width = "100%"),
            menuItem("Dashboard Home", tabName = "Dashboard", icon = icon("dashboard")),
            menuItem("Material Recycling Facilities (MRF) Map", tabName = "MRF_Map", icon = icon("map", lib='font-awesome')),
            menuItem("A Look at CO2 and Aluminum Production", tabName="Emissions", icon = icon("exclamation-triangle", lib = 'font-awesome')),
            menuItem("Koeppen-Geiger Classification", tabName = "Koeppen-Geiger", icon = icon("thermometer", lib='font-awesome')),
            menuItem("Stats:  Aluminum Scrap Exports from The Philippines", tabName = "RecycleStats", icon = icon("percent", lib = 'font-awesome')),
            menuItem("Phase 1 Pilot Program Costs", tabName = "P1Costs", icon = icon("dollar-sign", lib="font-awesome")),
            menuItem("Phase 1 Summer '24 + Fall '24 Gantt Chart", tabName = "Calendar", icon=icon("calendar", lib = "font-awesome")),
            menuItem("Phase 1 Process Diagram", tabName = "Process", icon = icon ("project-diagram", lib = "font-awesome")),
            menuItem("Customers & Stakeholders", tabName = "Stakeholders", icon=icon("user-group", lib="font-awesome")),
            menuItem("Visit the MetalMatter Website", icon = icon("plane",lib='font-awesome'), href = "https://wordpress.lehigh.edu/inmetals/"),
            menuItem("About", tabName = "About", icon = icon("info-circle", lib = 'font-awesome'))
        ), width="350"),
    
    body <- dashboardBody(
        
        
        
        tabItems(
            
            tabItem(tabName = "MRF_Map",
                    HTML("<center><h2>Explore MRFs in & around Quezon City</h2></center>"),
                    br(),
                    leafletOutput("MRF_leaflet_map", height = 800),
                    
                    fluidRow(
                        
                    ),
                  
                    
            ),
            
            tabItem(tabName = "Emissions",
                   
            ),
            
            tabItem(tabName = "Calendar",
        
            ),
            
            
            tabItem(tabName = "Dashboard",
                    fluidPage(
                        
                        
                    )
                    
      
                    
            ),
            
            tabItem(tabName = "Koeppen-Geiger",
                    
                    
                    
            ),
            
            tabItem(tabName = "RecycleStats",
                    
            ),
            
            tabItem(tabName = "P1Costs",

            ),
            
            tabItem(tabName = "Process",

            ),
            
            tabItem(tabName = "Stakeholders",

            ),
            
            tabItem(tabName = "Visit"),
            tabItem(tabName = "About",

                    
            )
            
        )
    )
)



#==========================================
#    S      E      R      V      E        R
#==========================================

server <- function(input, output, session) {
    
    # Setting the max allowable uploaded file size:
    options(shiny.maxRequestSize=3000*1024^2)
    
    
    
    #========================================================================================================
    #=================== CO2 Calculations Section -- START ==================================================
    

    
    
    #=================== CO2 Calculations Section Section -- END ============================================
    #========================================================================================================
    
    # *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
    
    #========================================================================================================
    #=================== MRF Leaflet Map Output  -- START ===============================================
    
    # Preview of first 15 entries on starting page:

    
    
    
    #=================== MRF Leaflet Map Output -- END =================================================
    #========================================================================================================
    
    # *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
    
    #========================================================================================================
    #=================== Treemap + Scatterplot Visualization -- START =======================================
    

    
    
    
    # *********************************************************************************************************
    

    

    
    
    
    
    #=================== Treemap + Scatterplot Visualization -- END =========================================
    #========================================================================================================
    
    # *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
    
    #========================================================================================================
    
}

shinyApp(ui, server)

