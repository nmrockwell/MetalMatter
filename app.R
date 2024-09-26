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
                  box(
                        title = "A note on the above MRF map: ", width = NULL, status = "primary",
                        p(style="text-indent: 40px;", "The data for this map was collected from the '2020 Regional State of Brown Environment National Capital Region' report, viewable here: "),
 
                        HTML("<center><strong><a href='https://ncr.emb.gov.ph/rsober/'>Republic of the Philippines National Capital Region Environmental Management Bureau Website</a></strong></center>"),
                        p(),
                        p(style="text-indent: 40px;", "This report was published in 2021 by the Department of Environmental and Natural Resources Environmental Management bureau National Capital Region (NCR)."),
                        p(style="text-indent: 40px;", "This facility is located in the National Ecology Center Compound of East Avenue, Diliman, Quezon City."),
                        p(style="text-indent: 40px;", "Where available, coordinates for MRFs are provided--simply hover over the orange circles after clicking on the larger green or yellow cluster circles--MRFs for which exact coordinates could not be found are mapped by an approximation, using the city or municipality in which they were listed in the report, alongside the coordinates for the barangay in which they are located."),
                        p(style="text-indent: 40px;", "These barangay coordinates were obtained by using the following resource: "),
                        HTML("<center><strong><a href='https://www.philatlas.com'>PhilAtlas</a></strong></center>"),
                        p(),
                        p(style="text-indent: 40px;", "The dark blue polygons cover Quezon City, with the lighter blue section covering some additional boundaries we hope to address in a future iteration of this map. The base shapefiles used for this map were from the WGS84 ESRI Shapefile 'Level 3: Municipalities and Cities' from the following GitHub repository: "),
                        HTML("<center><strong><a href='https://github.com/altcoder/philippines-psgc-shapefiles/tree/main'>Philippines PSGC Shapefiles Repo</a></strong></center>"),
                        p(),
                        p(style="text-indent: 40px;", "The shapefiles are from the OCHA Services website; the Level 3 shapefile was imported into QGIS and the 'QuickOSM' plugin was used to run an OMS query with the 'Key' = 'boundary' and the 'Value' = 'administrative'; the 'In' field was then specified as 'Quezon'. The resulting shapefile was then reimported into R and worked with using the Leaflet library.")
                       
                    ),
                    
            ),
            
            tabItem(tabName = "Emissions",
                   
            ),
            
            tabItem(tabName = "Calendar",
                           HTML("<center><h3>An Overview of <q>Phase 1</q> Plans</h3></center>"), 
                    br(), 
                    tags$img(src = "Gantt_Screenshot_(Updated_05-05-2024).JPG", width = "100%"),
                    br(), 
            ),
            
            
            tabItem(tabName = "Dashboard",
                    fluidPage(
                        br(), 
                        HTML("<center><h3>Beginning Spring 2024, the <a href='https://creativeinquiry.lehigh.edu/philippines-transforming-metal-recycling-landscape'>GSIF Philippines Metals Recycling team</a>, <em>MetalMatter</em>, has joined The Loewy Institute to Transform the Metal Recycling Landscape in Metro Manila</h3></center>"), 
                        tags$img(src = "GSIF_MetalMatter_Team_Loewy_Blog_Intro_Banner_Image.PNG", width = "100%"), 
                        br(), 
                        br(), 
                        p(style="text-indent: 40px;", "As of the spring 2024 semester, four Lehigh University undergraduate student researchers--Priya Blaise ('27, Mechanical Engineering), Ayushka Dhakal ('27, IDEAS), Cherrie Ruan ('27, Civil Engineering), and Kat Van Buskirk ('27, Architecture)--have joined The Loewy Institute as Global Social Impact Fellow (GSIF) to form the MetalMatter team."), 
                        br(), 
                        p(style="text-indent: 40px;", "These students have been actively researching various metal-forming techniques in the context of energy usage and carbon emissions, and working with a group of students at University of the Philippines Diliman enrolled in the HEED (Humanitatian, Engineering, Entrepreneurship, and Design) course to identify potential improvements for metals recycling in Metro Manila."), 
                        br(), 
                        p(style="text-indent: 40px;", "Currently, the students are looking into the possibility of using the friction extrusion technology ShAPE™ (developed at Pacific Northwest National Laboratory) to develop green (also known as \"living\" walls and functional building facades from recycled 6000 series aluminum alloys."), 
                        br(), 
                        p(style="text-indent: 40px;", "Over summer 2024, the students will conduct fieldwork in Metro Manila, during which they will collect scrap 6000 series aluminum. This scrap aluminum will be cast into small billets which will then be run through the ShAPE™ machine at PNNL to produce thin-walled cylindrical tubing. This tubing will then undergo metallography performed at Lehigh University to examine the mechanical properties of the material and further assess its use case as a material for living walls and functional facades in Metro Manila."),
                        br(), 
                        br(), 
                        br(), 
                        HTML("<center><h4>Partners:</h4></center>"), 
                        HTML("<center><li><a href='https://www.lehighloewyinstitute.org/'>The Loewy Institute at Lehigh University</a></li></center>"),
                        br(), 
                        HTML('<center><img src="Loewy_Institute_Logo.jpg"</center>'),
                        br(),
                        br(),
                        HTML("<center><li><a href='https://www.pnnl.gov/shape/'>Pacific Northwest National Laboratory's ShAPE™ Team</a></li></center>"), 
                        br(),
                        HTML('<center><img src="PNNL_Logo.jpg"</center>'),
                        br(),
                        br(),
                        HTML("<center><li><a href='https://upd.edu.ph/'>University of Philippines Diliman</a></li></center>"),
                        br(),
                        HTML('<center><img src="UDP_Logo.jpg"</center>')                         
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

    # First, we'll import our materials--that is, the shapefiles and the map "pop-up" information"
    MRF_datapoints <-as.data.frame(read.csv(file="file path to MRF_Points.csv", header=TRUE, sep=","))
    
        MRF_datapoints_selected <- MRF_datapoints[1:133,]
       
    # Import shapefile as SF object:
    shp <- st_read("file path to Quezon_Shapefile.shp")
        
    # Convert from WGS 84/UTM zone 51N to Long/Lat:
    shp_wgs84 <- st_transform(shp, crs = 4326)

    # Adding labels to points of interest:
    MRF_datapoints_selected$label <- paste("<p>", "<u>City or Municipality</u> = ", MRF_datapoints_selected$"City.or.Municipality","</p>",
                                           "<p>", "<u>Barangay</u> = ", MRF_datapoints_selected$"Barangay", "</p>",
                                           "<p>", "<u>Status</u> = ", MRF_datapoints_selected$"Status", "</p>",
                                           "<p>", "<u>Latitude</u> = ", MRF_datapoints_selected$"lat", "</p>",
                                           "<p>", "<u>Longitude</u> = ", MRF_datapoints_selected$"lon", "</p>",
                                           "<p>", "<u>Address</u> = ", MRF_datapoints_selected$"Address", "</p>",
                                           "<p>", "<u>Confirmed MRF coordinates?</u> = ", MRF_datapoints_selected$"Confirmed.MRF.Coordinates", "</p>",
                                           sep="")
        
        # Generating CSS for map title:
        tag.map.title <- tags$style(HTML("
            .leaflet-control.map-title {
            transform: translate(-50%,20%);
            position: fixed !important;
            left: 50%;
            text-align: center;
            color: rgb(175, 225, 175);
            padding-left: 10px;
            padding-right: 10px;
            background: rgba(255,255,255);
            font-weight: bold;
            font-size: 26px;
            }
        "))

    #Map creation
    output$MRF_leaflet_map <- renderLeaflet({  
        leaflet(shp_wgs84) |>
            setView(lng = 121.043861, lat = 14.676208, zoom = 11) |>
            addTiles() |>
            addPolygons(color = "darkturquoise") |>
            #addControl(title, position = "topleft", className="map-title") |>
            addCircleMarkers(lng = MRF_datapoints_selected$"lon",
                            lat = MRF_datapoints_selected$"lat",
                            color = "darkorange",
                            weight = 5,
                            radius = 3,
                            opacity = .90,
                            label = lapply(MRF_datapoints_selected$label, HTML),
                            clusterOptions = markerClusterOptions()) |>
            addLogo("Mapping_Logo_GrayBG_4.svg", src=c("remote"), position = c("topright"), offset.x = -1, offset.y = -72, width = 300, height = 300)
      })

    
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

