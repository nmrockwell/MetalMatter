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
                    HTML("<center><h3>Calculate Emissions Based off of Mining for Bauxite from Visayas Region Mines</h3></center>"),
                    br(),
                    p(style="text-indent: 40px;", "New aluminum production involves the mining of bauxite, the most frequently used ore of aluminum. Production of 1 metric ton of aluminum can use 4 to 5 metric tons of bauxite: "),
                    br(),
                    HTML("<center><strong><a href='https://www.grida.no/resources/5848'>Bauxite Tonnage Resource</a></strong></center>"),
                    br(),
                    p(style="text-indent: 40px;", "Furthermore, the production of 1 metric ton of aluminum outputs--according to the global average--11.7 tons of CO2."),
                    br(),
                    HTML("<center><strong><a href='https://www.wesa.fm/development-transportation/2017-08-31/aluminum-production-leaves-a-big-carbon-footprint-so-alcoa-is-adapting-with-sustainable-products'>CO2 Emissions for 1 Metric Ton of Aluminum</a></strong></center>"),
                    br(),
                    p(style="text-indent: 40px;", "As countries and industries look to greatly reduce their climate emissions, multiple considerations are made; metal-forming processes are no exception. Where large deposits of minerals / natural resources can be a windfall for a national economy, they can also present difficult considerations. In the case of the Philippines, for example, the Vasayas region is found to have a decent amount of bauxite that could be mined for aluminum production: "),
                    br(),
                    p(style="text-indent: 40px;", "The MetalMatter team reached out to the Philippines' Department of Environment and Natural Resources Mines and Geosciences Bureau regarding data about potential bauxite deposits--the following data was provided regarding the Vasayas region:"),
                    br(),
                    HTML('<center><img src="Bauxite_Resources.png", width="75%"></center>'),
                    br(),
                    p(style="text-indent: 40px;", "Using this data, the below sliders can be moved to estimate the CO2 produced for a given amount of bauxite mined and used for aluminum production. Once you have selected a tonnage of bauxite to hypothetically mine from the Vasayas region, use the next slider to select the amount of bauxite you would use for the production of a ton of aluminum (in that 4 to 5 tons range). Once you have made these selections, press the \"Calculate Emissions\" button; the resulting output will be shown below."),
                    br(),
                 
                    sliderInput("m_bauxite", # "m" standing for "mineable" (not sure that's a word)
                                label = "Bauxite Mined from Vasayas (in metric tons)",
                                value = 175,
                                min = 1,
                                max = 177881000,
                                width = "100%"),
                    br(),
                    sliderInput("u_bauxite", # "u" standing for "used"--takes 4-5 tons of bauxite for 1 ton of aluminum
                                label = "Amount of bauxite used (in metric tons)",
                                value = 4.5,
                                min = 4,
                                step = 0.5,
                                max = 5,
                                width = "100%"),
                    br(),
                    column(
                      12,
                    actionButton("submitbutton",
                                 "Calculate Emissions",
                                 class = "btn btn-primary"),
                    align = "center"
                    ),
                    br(),
                    tags$label(h3('Estimated Outcome')), # Status/Output Text Box
                    verbatimTextOutput('contents'),
                    tableOutput('tabledata'),
                   
                    br(),
                    HTML("<center><h3>Why is This of Interest to This Project?</h3></center>"),
                    br(),
                    p(style="text-indent: 40px", "Ideally, as this project develops, the third phase will look at applying to grants that would enable to purchase of a friction extrusion machine--such as the \"FE100\" and its associated tooling, offered by Bond Technologies--which could be used at a metals-focused MRF. The machine could be used with aluminum to produce uniform, high-quality extrudates (with better mechanical properties) that could be reused in the domestic economy."),
                    br(),
                    p(style="text-indent: 40px", "The friction extrusion machine can use powder, scrap, or billets to produce these aluminum extrudates, and since it uses severe plastic deformation in place of melting, the amount of emissions produced is negligble.")
)

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
                       HTML("<center><h2>A Look at the Koeppen-Geiger Climate Classification System in Relation to the Philippines</h2></center>"),
                    br(), 
                    p(style="text-indent: 40px;","The Koeppen-Geiger climate classification system allows climates to be separated into 5 separate 'major' groups; these groups are defined by the sorts of temperatures and varying types + amounts of precipitation these areas are subject to. The 5 parent groups are: "), 
                    br(),
                    
                      HTML("<center><strong><q>A</q></strong> = <q>Tropical</q></center>"),
                      HTML("<center><strong><q>B</q></strong> = <q>Arid</q></center>"),
                      HTML("<center><strong><q>C</q></strong> = <q>Temperate</q></center>"),
                      HTML("<center><strong><q>D</q></strong> = <q>Continental</q></center>"),
                      HTML("<center><strong><q>E</q></strong> = <q>Polar</q></center>"),
                    br(), 
                    p(style="text-indent: 40px;", "However, the classification goes further: the first 'parent' group letter is combined with another letter which indicates what kind of precipitation the region experiences, and the third letter indicates the intensity (or lack thereof) of heat. A complete table explaning each letter designation can be viewed on the following Wikipedia page: "), 
                    br(),
                    HTML("<center><strong><a href='https://en.wikipedia.org/wiki/K%C3%B6ppen_climate_classification#Overview'>Wikipedia Table of Koeppen-Geiger Classification Scheme</a></strong></center>"),
                    br(),
                    br(),
                    p(style="text-indent: 40px;", "The map below shows that there are 3 dominant climates that the islands comprising the Philippines experience, from most prevalent to least: "),
                    br(), 
                    HTML("<center><strong><q>Af</q></strong> = <q>Tropical Rainforest Climate</q></center>"),
                    HTML("<center><strong><q>Am</q></strong> = <q>Tropical Monsoon Climate</q></center>"),
                    HTML("<center><strong><q>Aw</q></strong> = <q>Tropical Wet Climate</q></center>"),
                    br(), 
                    p(style="text-indent: 40px;", "This map was generated with climate data from 1986 - 2010; it was made using a raster file and some slight modifications to a provided R Script available on the 'World Maps of Koeppen-Geiger Climate Classification' website: "), 
                    br(), 
                    HTML("<center><strong><a href='https://koeppen-geiger.vu-wien.ac.at/present.htm'>Koeppen-Geiger High Resolution Map and Data Webpage</a></strong></center>"),
                    br(),
                    br(),
                    HTML('<center><img src="Koeppen_Geiger_Classification_Philippines.jpg", width="75%"></center>'),
                    br(),
                    br(), 
                    HTML("<center><h2>Why Is This of Interest?</h2></center>"),
                    p(style="text-indent: 40px;", "A variety of metals are used for different architectural needs--whether they act as functional facades, serve some purely decorative function, or are used as integral structural building components."), 
                    p(style="text-indent: 40px;", "As this project develops, we hope to see the recycled aluminum used to create higher-value products (such as functional facades for building envelopes or living / green walls). Therefore, an understanding of the environment in which these components would be used is integral."), 
                    br(),

                    
                    
            ),
            
            tabItem(tabName = "RecycleStats",
                    
            ),
            
            tabItem(tabName = "P1Costs",
     HTML("<center><h3><q>Phase 1</q> BOM (Labor Costs To Be Determined)</h3></center>"), 
                    br(), 
                    tags$img(src = "BOM_(Updated_5-5-2024).JPG", width = "100%"),
                    br(),
            ),
            
            tabItem(tabName = "Process",
       HTML("<center><h3>Phase 1 Process Diagram</h3></center>"), 
                    br(), 
                    tags$img(src = "Metal_Matter-Phase_1_Process_Diagram.png", width = "100%"),
                    br(),
            ),
            
            tabItem(tabName = "Stakeholders",
        HTML("<center><h3>Customers & Stakeholders for This Project</h3></center>"), 
                    br(), 
                    tags$img(src = "Metal Matter - Stakeholders.png", width = "100%"),
                    br(),
            ),
            
            tabItem(tabName = "Visit"),
            tabItem(tabName = "About",
  HTML("<center><h2>About This R Shiny Web App</h2></center>"),
                    br(), 
                    
                      HTML("<center><h4>This R Shiny web application was developed over the spring 2024 semester to help outline the basis for the GSIF Philippines MetalMatter's fieldwork approach for summer 2024.</h4></center>"), 
                      HTML("<center><h4>Advisors of the 2024 MetalMatter team include:</h4></center>"),
                      br(), 
                      br(), 
                      HTML("<center><li>Dr. Wojciech Z. Misiolek, Director of The Loewy Institute and Loewy Professor, MSE</li></center>"),
                      br(), 
                      HTML("<center><li>Dr. Charles Chemale Yurgel, Loewy Post-Doctoral Research Associate, MSE</li></center>"),
                      br(), 
                      HTML("<center><li>Nick Rockwell, Loewy Research Scientist, MSE</li></center>")
                    
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
    
  datasetInput_1 <- reactive({  
   
    # Info. on aluminum which can be created:
    tons_of_AL_possible <- (input$m_bauxite) / (input$u_bauxite)
   
    associated_emissions <- tons_of_AL_possible * 11.7
    associated_emissions <- data.frame(associated_emissions)
    names(associated_emissions)<- "Associated emissions (in metric tons): "
    print(associated_emissions)
   
  })
 
 

 
  #  Outputting results when button clicked:
  output$tabledata <- renderTable({
    if (input$submitbutton>0) {
      isolate(datasetInput_1())
    }
  })
    
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
    

  # Import the treemap spreadsheet:    
  tm_df <-as.data.frame(read.csv(file="D://MetalMatterApp//Treemap_OEC_Data//tm_df.csv", header=TRUE, sep=","))
  
  
  # Manually build treemap layout:
  treemap <- treemapify(tm_df, area = "Scrap_Aluminum_Value")
  treemap <- left_join(treemap, tm_df)
  
  # Adding a title for the treemap:
  treemap_title <- "Scrap Aluminum Exports from The Philippines to Other Countries, in $MM (USD) for 2022"


  # Build ggplot2 treemap object
  plot <- ggplot(treemap, aes(
    area = Scrap_Aluminum_Value,
    fill = Countries,
    xmin = xmin,
    xmax = xmax,
    ymin = ymin,
    ymax = ymax,
    tooltip = Scrap_Aluminum_Value,
    label = Countries
  )) +
    labs(title = str_wrap(treemap_title, 50)) +
    theme(text = element_text(family = "Kinnari"), 
          plot.title = element_text(hjust = 0.5, colour = "gray48", face = "bold", family = "Kinnari", size = 10), 
          panel.background = element_rect(fill = "seashell2")) +
    geom_treemap() +
    geom_treemap_text(aes(family ="Kinnari"), color="white") +
    geom_rect_interactive(alpha = 0.1) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme(axis.text = element_blank(), axis.ticks = element_blank())


  # Draw with ggiraph
  output$scrap_treemap <- renderGirafe(girafe(code = print(plot)))


    
    
    
    # *********************************************************************************************************

  sp_df <- as.data.frame(read.csv("D://MetalMatterApp//Scatterplot_OEC_Data//export_aggregate_cleaned.csv", header=TRUE, sep=","))

   output$al_exports_scatterplot <- renderPlotly({
      p <- ggplot(data = sp_df, 
                          mapping = aes(x = sp_df$Year, 
                                        y = sp_df$Export.Trade.Value..in.MMs.of.dollars., 
                                        group = 1, 
                                        text = paste('</br>Country: ', sp_df$Country, 
                                                     '</br>Year: ', sp_df$Year, 
                                                     '</br>Export Value in $MM (USD): ', sp_df$Export.Trade.Value..in.MMs.of.dollars.))) + 
        geom_point(alpha = 0.8, size = 1, aes(color = sp_df$Country)) +
        geom_line(alpha = 0.2, size = 0.5, aes(color = sp_df$Country)) + 
        theme(text = element_text(family = "Kinnari"), 
              plot.title = element_text(colour = "gray48", face = "bold", family = "Kinnari", size = 18),
              axis.title = element_text(colour = "grey50", face = "bold", family = "Kinnari"), 
              panel.background = element_rect(fill = "seashell2")) + 
        xlab('Export Year') +
        ylab('Export Value in $MM (USD)') +
        labs(color = "Countries Importing Aluminum Scrap from The Philippines") + 
        ggtitle('Value of Scrap Aluminum Exports from The Philippines, 1995-2022') 
      
      p <- ggplotly(, tooltip = c("text"))
      p
 
    

    
    
    
    
    #=================== Treemap + Scatterplot Visualization -- END =========================================
    #========================================================================================================
    
    # *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
    
    #========================================================================================================
    
}

shinyApp(ui, server)

