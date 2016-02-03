
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


rpmRange <- seq(600,3200,100)

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
  #transGear <- parseTransmission(input$transmission,input$gear) 
  #   speeds <- getSpeed(
  #     rpmRange,
  #     input$tireSize,
  #     parseTransmission(input$transmission,input$gear),
  #     input$odGear,
  #     input$transferCaseGear,
  #     input$axleGear
  #   )
  #speeds <- getSpeed(rpmRange,as.numeric(input$tireSize),1,1,1,5.38)
  #       rpmRange,
  #       input$tireSize,
  #       1,
  #       input$odGear,
  #       input$transferCaseGear,
  #       input$axleGear
  #     )
  #speeds <- getSpeed(rpmRange,30,1,1,1,5.38)
  output$debug <- renderText({
    getSpeed(
      engineRPM = rpmRange,
      tireSize = input$tireSize,
      #parseTransmission(input$transmission,input$gear),
      transmissionGear = 1,
      odGear = input$odGear,
      transferCaseGear = input$transferCaseGear,
      axleGear = input$axleGear
    )
  })
})
