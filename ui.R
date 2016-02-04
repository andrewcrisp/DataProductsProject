
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rCharts)
shinyUI(fluidPage(

  # Application title
  titlePanel("Willys speed calculator"),

  #sidebarLayout(
  #  sidebarPanel(
  fluidRow(
    column(4,  
      sliderInput("tireSize",
                  "Tire size:",
                  min = 27,
                  max = 35,
                  value = 30
                  )
      ),
    column(2,
      radioButtons("axleGear",
                   "Axle Gears", 
                   c("5.38:1"=5.38,
                     "4.88:1"=4.88,
                     "4.56:1"=4.56,
                     "4.27:1"=4.27,
                     "4.10:1"=4.1,
                     "3.90:1"=3.9,
                     "3.73:1"=3.73,
                     "3.27:1"=3.27
                     )
                   )
      ),
    column(2,
      radioButtons("transferCaseGear",
                   "Transfer Case",
                   c("Dana/Spicer 18 Hi" = 1,
                     "Dana/Spicer 18 Lo" = 2.46,
                     "Dana 20 Hi" = 1,
                     "Dana 20 Lo" = 2.03
                     )
                   )
      ),
    column(2,
      radioButtons("transmission",
                  "Transmission",
                  c("T90" = "T90",
                    "ASI-T90E" = "ASI-T90E",
                    "T86" = "T86",
                    "T96" = "T96"
                    )
                  ),
      radioButtons("gear",
                   "Gear",
                   c("Reverse" = "R",
                     "1st" = "1",
                     "2nd" = "2",
                     "3rd" = "3"
                   )
                  )
      ),
    column(2,
      radioButtons("odGear",
                   "Overdrive Gear",
                   c("Normal" = 1,
                     "Stock Overdrive" = .7,
                     "Warn/Saturn Overdrive" = .75
                     )
                   )
      )
    ),

    # Show a plot of the generated distribution
    #mainPanel(
    fluidRow(
      column(4,
        "Tire size:", textOutput("tireSize"),
        "Axle gearing:", textOutput("axleGear"),
        "Transfer case:", textOutput("transferCaseGear"),
        "Transmission:", textOutput("transmission"),
        "Gear:", textOutput("transmissionGear"),
        "Overdrive", textOutput("odGear")
      ),
      column(8,
             textOutput("debug"),
             #plotOutput("plot"),
             showOutput("chart","morris")
             )
    )
  )
)
