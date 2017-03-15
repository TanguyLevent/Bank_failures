library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(plotly)
library(data.table)

mdata.bank <- read.csv("data/banks.csv")


mdata.work <- mdata.bank  %>% select(Institution.Name,Institution.Type,Failure.Date,Estimated.Loss..2015.)
colname <- c("Name","Type", "Date", "Loss")
names(mdata.work) <- colname

mdata.work$Date <- format(mdata.work$Date, "%Y")

mdata.work <- mdata.work %>% group_by(Date,Type,Name) %>%  summarise(Loss = sum(Loss))
mdata.work$Date <- as.numeric(mdata.work$Date)
mdata.work$Loss <- mdata.work$Loss/1000000


shinyServer(function(input, output) 
{
        dt.agg <- reactive({
                
                mdata.work2 <- mdata.work %>% filter(Type == input$type)
        })
        
        dt.agg2 <- reactive({
                
                mdata.work3 <- mdata.work %>% filter(Type == input$type) %>% arrange(desc(Loss))
                mdata.work3 <- head(mdata.work3,5)
                
        })
        
         output$distPlot <- renderPlot({
                 data <- dt.agg()
                 ggplot(data, aes(Date,Loss, fill=Date)) +
                         geom_bar(stat = "identity") +
                         theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                         guides(fill=FALSE) +
                         xlim(1980,2020) +
                         ylab("Loss (in billion)") +
                         ggtitle("A History of Bank losses in the United States since 1986")
        })
  
        output$distPlot2 <- renderPlot({
                data2 <- dt.agg2()
                
                ggplot(data2, aes(Name,Loss , fill = Name)) +
                        geom_bar(stat = "identity") +
                        scale_fill_brewer(palette="Pastel2") +
                        theme(axis.text.x = element_text(angle = 75, hjust = 1)) +
                        theme(axis.text.x=element_blank(),
                              axis.ticks.x=element_blank()) +
                        ylab("Loss (in billion)") + 
                        xlab("Bank name")+
                        ggtitle("Top 5 - Commercial bank failure cost for federal government since 1986")
        })

         
         mdata.work3 <- mdata.bank %>% select(Failure.Date,Estimated.Loss..2015.)
         mdata.work3$Estimated.Loss..2015. <- 1
         colname2 <- c("Date","Loss")
         names(mdata.work3) <- colname2
         
         mdata.work3$Date <- format(mdata.work3$Date, "%Y")
         data.work3 <- mdata.work3 %>% group_by(Date) %>%  summarise(Loss = sum(Loss))
         
        output$distPlot3 <- renderPlot({

                ggplot(data.work3, aes(Date,Loss,fill=Date)) +
                        geom_bar(stat = "identity") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1))+ 
                        guides(fill=FALSE) + 
                        ylab("Number of institutions") +
                        ggtitle("A History of Bank Failures in the United States")
                
        })
  
})
