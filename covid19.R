###################pre - requist #######################
############# Shiny Lib ####################
############# Shinythemes lib ################
############ COVID 19 lib ###############
########### Plotly lib ###################
###########################################################



library(shiny)
library(shinythemes)
library(COVID19)
library(plotly)

######################################
#UI.R             #
######################################

ui <- fluidPage(theme = shinytheme("superhero"),
                tags$head(
                  tags$style(HTML("
          .navbar .navbar-nav {float: right}
          .navbar .navbar-header {float: right}
        "))
                ),
                navbarPage(
                  
                 "Covid-19",
                 header = h1(em(strong("Covid-19 Analysis"))),
                 
                  tabPanel("Analysis",
                           br(),
                           
                           sidebarPanel(
                             tags$h3("Input the data : "),
                             textInput("country",label = "Country : ",""),
                             dateRangeInput("range",label = "Date",start="2020-01-01"),
                             selectInput("type",label = "Data_Type",choices = c("confirmed", "tests", "recovered", "deaths")),
                             actionButton("submitbutton","Submit",class= "btn btn-primary")
                             
                           ), # sidebarPanel
                           mainPanel(
                             img(src = "data:image/jpeg;base64,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",height=300,width=1200),
                             h2(strong("Globally, there have been 42,966,344 confirmed cases of COVID-19, including 1,152,604 deaths, reported to WHO", ),style = "font-family: 'times'; font-size: 32pt "),
                             tags$label(h3('Status')),
                             h4("Country :"),
                             verbatimTextOutput("txtout"),
                             HTML("<br><br><h4><em>The graph show's the variation of Covid-19 cases with time</em></h4><br><br>"),
                             br(),
                             plotlyOutput("covid19plot"),
                             a(em("source ~ https://covid19.who.int/"))
                             
                           ) # mainPanel
                           
                  ), # ANALYSIS
                 ################################################################
                 ######################## analysis ################################
                 ##################################################################
                 
                  tabPanel(
                    "Blog",
                    sidebarLayout(
                      
                      sidebarPanel(
                        h3("Related News"),
                        h4(">COVID-19 situation update worldwide",a("https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases")),
                        h4(">#IndiaFightsCorona COVID-19 -",a("https://www.mygov.in/covid-19")),
                        h4(">Analysis of dynamic disturbance in blood coagulation function of 261 patients with Coronavirus Disease 2019 - ",a("https://www.researchsquare.com/")),
                        h4(">SARS-CoV-2 viral load and the severity of COVID-19 -",a("https://www.cebm.net/")),
                        h4(">European Centre for Disease Prevention and Control-",a("https://www.ecdc.europa.eu/")),
                        h4(">Data | A day-by-day look at the 10 countries with the most COVID-19 cases and deaths-",a("https://www.thehindu.com/")),
                        h4(">COVID-19 Statewise Status (Click to expand)-",a("https://www.mohfw.gov.in/"))
                        
                        
                      ),
                      
                      mainPanel(
                        img(src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSaIxQEtLpaavHXCT8MQAy-cLgUqRo6Ofw4lg&usqp=CAU",height=350,width=1000),
                        h2("WHO Director-General's opening remarks at the media briefing on COVID-19 - 26 October 2020"),
                        br(),
                        br(),
                        a(em("26 October 2020",style = "color:white")),
                        h1("_______________________________________"),
                        br(),
                        
                        p("Last week saw the highest number of COVID-19 cases reported so far. Many countries in the northern hemisphere are seeing a concerning rise in cases and hospitalisations. And intensive care units are filling up to capacity in some places, particularly in Europe and North America..", style = "font-family: 'times'; font-size: 20pt "),
                        
                        p("Last week WHO conducted its first global e-learning course on health and migration, addressing a critical and often neglected topic of global health. It's vital that all countries include refugees and migrants in their national policies as part of their commitment to universal health coverage.",style = "font-family: 'times'; font-size: 20pt"),
                        
                        p("We must do all we can to protect health workers, and the best way to do that is for all of us to take every precaution we can to reduce the risk of transmission, for ourselves and others. No one wants more so-called lockdowns. But if we want to avoid them, we all have to play our part.  ",style = "font-family: 'times'; font-size: 20pt"),
                        br(),
                        a(em("source~https://www.who.int/")),
                        br(),
                        br(),
                        br()
                      ) #main panel 
                    ) #sidebarlayout
                    
                  ) #BLOG
                 ################################################################
                 ######################## blog ################################
                 ##################################################################
                  
                  
                ) # navbarPage
                #######################Navbar##########################
                
) # fluidPage
   #####################Fluid#########################


######################################
#SERVER.R             #
######################################
server <- function(input, output) {
  output$txtout <- renderText({
    paste( input$country, sep = " " )
  })
  
  output$covid19plot <- renderPlotly({
    if(!is.null(input$country)){
      
      i <- covid19(
        country = input$country, 
        start   = input$range[1], 
        end     = input$range[2]
      )
      
      plot_ly(x = i[["range"]], y = i[[input$type]])
      
    }
  })
  
}


###########################################
###########################################
shinyApp(ui = ui, server = server)