
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
#library(ggplot2)
#library(rCharts)
#library(googleCharts)

rpmRange <- seq(100,3200,100)
xlim <- c(100,3200)
ylim <- c(-15,80)

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
  output$jeep <- renderImage({
    filename <- normalizePath(file.path('./jeep.jpg'))
    list(src=filename,
         alt=paste("1952 M38A1"),
         width = 320,
         height = 200
         )

  },deleteFile = FALSE)
  output$tireSize <- renderText({as.numeric(input$tireSize)})
  output$axleGear <- renderText({as.numeric(input$axleGear)})
  output$transferCaseGear <- renderText({input$transferCaseGear})
  output$transmission <- renderText({input$transmission})
  output$transmissionGear <- renderText({parseTransmission(input$transmission,input$gear)})
  output$odGear <- renderText({input$odGear})

  speedData <- reactive({data.frame(
    speed = getSpeed(
      engineRPM = rpmRange,
      tireSize = as.numeric(input$tireSize),
      parseTransmission(input$transmission,input$gear),
      odGear = as.numeric(input$odGear),
      transferCaseGear = as.numeric(input$transferCaseGear),
      axleGear = as.numeric(input$axleGear)
    ),
    RPM = rpmRange
  )
  })
  output$plot <- renderPlot({
    p<-plot(as.numeric(speedData()$RPM),
         as.numeric(speedData()$speed),
         type = "l",
         xlim = xlim, 
         ylim = ylim,
         xlab = "RPM",
         ylab = "Speed (MPH)")
    rect(3000,ylim[1]-5,xlim[2]+200,ylim[2]+5,density = 10,col = "red")
    rect(2800,ylim[1]-5,3000,ylim[2]+5,density = 10,col = "orange")
    rect(1200,ylim[1]-5,2800,ylim[2]+5,density = 10,col = "green")
    })
  output$clickRPM <- renderText({paste0("RPM = ", input$plot_click$x)})
  output$clickSpeed <- renderText({paste0("Speed = ", input$plot_click$y, " MPH")})
})