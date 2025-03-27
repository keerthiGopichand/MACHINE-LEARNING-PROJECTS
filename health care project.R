
library(shiny)
library(shinydashboard)
library(caret)
library(kernlab)
library(e1071)

predict_ksvm <- predict(hmodata_ksvm1, newdata=testSet) 
CMAT <- confusionMatrix(predict_ksvm, testSet$cost_status)
CMAT

PREDmodel <- hmodata_ksvm1
save(PREDmodel, file = "PREDmodel.rda")

# Define UI for application that draws a histogram
ui <- dashboardPage(
  dashboardHeader(title = "Shiny WEB APP"),
  dashboardSidebar(
    sidebarMenu(id = "sidebar1",menuItem("EXPLORATORY ANALYSIS", tabName = "EXPA")),
    sidebarMenu(id = "sidebar2",menuItem("Dataset", tabName = "dataset"))
  ),
  dashboardBody(fluidRow(
    tabItems(
      tabItem(tabName = "dataset",tabBox(id="t1", width = 12,tabPanel("Upload",
                                                                        fluidRow(
                                                                          column(width = 12, tags$p("Insert data file  ")),
                                                                          column(width = 12, fileInput("file", "Choose CSV File", accept=c('.csv'))),
                                                                          column(width = 12, tags$p("Insert solution file ")),
                                                                          column(width = 12, fileInput("file2", "Choose CSV File", accept=c('.csv')))
                                                                        )
      ),
      tabPanel("Data", tableOutput("dataTable")),
      tabPanel("Accuracy", verbatimTextOutput("Accuracy")),
      tabPanel("Result", verbatimTextOutput("result")),
      
      )
      ),
      tabItem(tabName = "EXPA",
              fluidRow(
                box(title="Histogram of BMI",width = 12,
                    
                    sliderInput("bins",
                                "Number of bins:",
                                min = 0,
                                max = 30,
                                value = 26
                    ),
                    
                    plotOutput("distPlot")
                    
                    
                    
                      
                )),
              box(title="Histogram of Cost",width = 12,
                    plotOutput("distPlot1")),
              
              box(title="Scattedplot",width = 12,
                  plotOutput("plot1", click = "plot_click")),
              
              
      )
    )  
  )
  )
)




server <- function(input, output) {
  
  dataX <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
    
  })
  dataS <- reactive({
    req(input$file2)
    read.csv(input$file2$datapath)
    
  })
  output$dataTable <- renderTable({
    req(dataX)
    dataX()
  
  })
  
  output$result <- renderPrint({
    newplot <- data.frame(predict(hmodata_ksvm1,dataX(), type="response"))
    newplot
  })
  

  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    BMI    <- hmodata[, 3] 
    bins <- seq(min(BMI), max(BMI), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(BMI, breaks = bins, col = 'black', border = 'white')
  })
  
  output$distPlot1 <- renderPlot({
    Cost    <- hmodata[,14] 
    hist(Cost, breaks = 25, col = 'black', border = 'white')
  })
  
  output$plot1 <- renderPlot({
    plot(hmodata$age, hmodata$cost)
  })
  
  
  output$Accuracy <- renderPrint({
    #load the data
    dataset <- dataX()
    dataset_solution <- dataS()
    PREDICTOR(dataset, dataset_solution)})
  
  
  
  PREDICTOR <- function(dataset, dataset_solution){

      load(file= "PREDmodel.rda")
      predict_ksvm <- predict(PREDmodel, dataset) 
      dataset_solution$expensive <- as.factor(dataset_solution$expensive)
      confusionMatrix(predict_ksvm, dataset_solution$expensive)
      }
  
  
}



# Run the application 
shinyApp(ui = ui, server = server)