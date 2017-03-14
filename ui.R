library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(
        fluidPage(
                  # Application title
                  titlePanel("Every bank failure in the United States since the Great Depression"),
                  br(),
                  h4("Synopsis"),
                  p("A bank failure occurs when a bank is unable to meet its obligations to its depositors 
                     or other creditors because it has become insolvent or too illiquid to meet its liabilities.
                      More specifically, a bank usually fails economically when the market value of its assets 
                     declines to a value that is less than the market value of its liabilities. 
                     The insolvent bank either borrows from other solvent banks or sells its assets at a 
                     lower price than its market value to generate liquid money to pay its depositors on 
                     demand. The inability of the solvent banks to lend liquid money to the insolvent bank 
                     creates a bank panic among the depositors as more depositors try to take out cash deposits 
                     from the bank. As such, the bank is unable to fulfill the demands of all of its depositors 
                     on time. Also, a bank may be taken over by the regulating government agency if 
                     Shareholders Equity (i.e. capital ratios) are below the regulatory minimum."),
                  br(),
                  h4("Exploratory"),
                  hr("Below a History of Bank Failures in the United States"),
                  hr(),
                  plotOutput("distPlot3"),
                  
                
                  # Sidebar with a slider input for number of bins 
                  sidebarLayout(
                    sidebarPanel( selectInput("type","Select a bank institution", 
                                              choices = c("COMMERCIAL BANK","SAVINGS ASSOCIATION","SAVINGS BANK"))),
                    br()
                   
                  ),
                
                  plotOutput("distPlot"),
                  plotOutput("distPlot2"),
                  br(),
                  
                  h4("Conclusion"),
                  p("First we saw that the 90' crisis was the most important historical crisis period in term of 
                number of failure institutions.The most likely to fail in the banking institution was the 
                saving associations during the 90' crisis period and the commercial bank during the crisis 
                    in the subprime mortgage market in the USA ")
        )
)