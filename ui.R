
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rCharts)
library(googleCharts)

xlim <- list(
  min=100,
  max=3200
)
ylim <- list(
  min = -15,
  max = 80
)

shinyUI(
  fluidPage(
    # Application title
    titlePanel("Willys speed calculator"),
    withMathJax(),
    fluidRow(
      shiny::column(1,  
                    "Tire size:", textOutput("tireSize"),
                    "Axle gearing:", textOutput("axleGear"),
                    "Transfer case:", textOutput("transferCaseGear"),
                    "Transmission:", textOutput("transmission"),
                    "Gear:", textOutput("transmissionGear"),
                    "Overdrive", textOutput("odGear")
                    ),
      shiny::column(3,
                    sliderInput("tireSize",
                                "Tire size:",
                                min = 27,
                                max = 35,
                                value = 30
                    )
      ),
      shiny::column(1,
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
      shiny::column(1,
                    radioButtons("transferCaseGear",
                                 "Transfer Case",
                                 c("Dana/Spicer 18 Hi" = 1,
                                   "Dana/Spicer 18 Lo" = 2.46,
                                   "Dana 20 Hi" = 1,
                                   "Dana 20 Lo" = 2.03
                                 )
                    )
      ),
      shiny::column(1,
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
      shiny::column(1,
                    radioButtons("odGear",
                                 "Overdrive Gear",
                                 c("Normal" = 1,
                                   "Stock Overdrive" = .7,
                                   "Warn/Saturn Overdrive" = .75
                                 )
                    )
      )
    ),
    fluidRow(
      shiny::column(8,
                    tabsetPanel(
                      #tabPanel("Instructions", verbatimTextOutput("instructions")),
                      tabPanel("Instructions", 
                               p("This is a speed calculator for older Willys vehicles.  I largely just cloned the functionality of the ",tags$a("Willys Utility Vehicle Speed Calculator", href = "http://www.public.asu.edu/~grover/willys/speed.html"), "by Richarg Grover.  The equation used is the same as his:"),
                               p('$$\\frac{Engine RPM * Tire circumference in inches * 60 \\frac{minutes}{hour}}{Transmission Gear * OD Gear * Trasfer Case Gear * Axle Gear * 63360\\frac{inches}{mile}}$$'),
                               p("I often used this calculator when restoring my own 1952 Willys M38A1.  The numbers are identical to Mr Grover's.  The primary enhancement is a speed vs RPM graph for the selected configuration."),
                               p("Select the desired configuration.  The graph and reported information will update automatically.  Switch to the \"Output\" tab to see the graph.  Click a point on the graph to receive the specific RPM and speed at that point on the line."),
                               p("These are old vehicles with old engines.  My 1952 went up to about 50MPH.  While possible, that pushed the engine up to about 3000RPM.  The engine and transmission were both screaming to spin that fast.  Accordingly, it is higly discouraged from cruising above about 2800 RPM.  Note the amber section on the graph corresponds to the dangerous, but possible, RPMs.  The red section shows speeds that should be avoided for fear of destroying the engine.")
                               
                      ),
                      tabPanel("Output",plotOutput("plot",click = "plot_click"),textOutput("clickRPM"),textOutput("clickSpeed"))
                      
                      )#,
                    #showOutput("chart","morris")
      )
    )#,
#     googleLineChart("googleChart",
#                     width="100%", height = "475px",
#                     options = list(
#                       hAxis = list(
#                         title = "Speed (MPH)",
#                         viewWindow = xlim
#                       ),
#                       vAxis = list(
#                         title = "RPM",
#                         viewWindow = ylim
#                       ),
#                       chartArea = list(
#                         top = 50, left = 75,
#                         height = "75%", width = "75%"
#                       ),
#                       #explorer = list(),
#                       titleTextStyle = list(
#                         fontSize = 16
#                       ),
#                       tooltip = list(
#                         textStyle = list(
#                           fontSize = 12
#                         )
#                       )
#                     )
#     )
  )
)
