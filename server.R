
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(rCharts)

rpmRange <- seq(100,3200,100)

getSpeed <- function(engineRPM,tireSize,transmissionGear,odGear,transferCaseGear,axleGear){
  speed <- (engineRPM * (tireSize *pi) * 60) / (transmissionGear * odGear * transferCaseGear * axleGear * 63360)
  return(as.numeric(speed))
}


parseTransmission <- function(transmission,gear){
  switch(transmission,
         "T90" = switch(gear,
                        "R"=-3.798,
                        "1"=2.798,
                        "2"=1.551,
                        "3"=1),
         "ASI-T90E" = switch(gear,
                             "R"=-4.53,
                             "1"=3.34,
                             "2"=1.85,
                             "3"=1),
         "T86" = switch(gear,
                        "R"=-3.489,
                        "1"=2.571,
                        "2"=1.551,
                        "3"=1),
         "T96" = switch(gear,
                        "R"=-3.535,
                        "1"=2.605,
                        "2"=1.63,
                        "3"=1)
  )
}

shinyServer(function(input, output) {
  output$tireSize <- renderText({as.numeric(input$tireSize)})
  output$axleGear <- renderText({as.numeric(input$axleGear)})
  output$transferCaseGear <- renderText({input$transferCaseGear})
  output$transmission <- renderText({input$transmission})
  output$transmissionGear <- renderText({parseTransmission(input$transmission,input$gear)})
  output$odGear <- renderText({input$odGear})
#   output$plot <- renderPlot({
#     speedData <- data.frame(
#       speed = getSpeed(
#         engineRPM = rpmRange,
#         tireSize = as.numeric(input$tireSize),
#         parseTransmission(input$transmission,input$gear),
#         #transmissionGear = 1,
#         odGear = as.numeric(input$odGear),
#         #transferCaseGear = as.numeric(input$transferCaseGear),
#         transferCaseGear = 1,
#         axleGear = as.numeric(input$axleGear)
#       ),
#       RPM = rpmRange
#       )
#     g <- ggplot(speedData, aes(RPM,speed)) +
#       geom_line() + ylim(c(-20,60))
#     print(g)
#   })
  output$chart <- renderChart2({
    speedData <- data.frame(
      speed = getSpeed(
        engineRPM = rpmRange,
        tireSize = as.numeric(input$tireSize),
        parseTransmission(input$transmission,input$gear),
        #transmissionGear = 1,
        odGear = as.numeric(input$odGear),
        #transferCaseGear = as.numeric(input$transferCaseGear),
        transferCaseGear = 1,
        axleGear = as.numeric(input$axleGear)
      ),
      RPM = rpmRange
    )
    #speedData = transform(speedData)
    g <- mPlot(x="RPM", y="speed", type="Line", data=speedData)
    
    return(g)
  })
  #output$debug <- parseTransmission(input$transmission,input$gear)
})
