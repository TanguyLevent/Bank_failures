

ggplot(mdata.work1, aes(Date,Loss, fill=Type)) +
        geom_bar(stat = "identity") +
        scale_fill_brewer(palette="Pastel2") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
        xlim(1980,2020) +
        ylab("Loss (in billion)") +
        ggtitle("A History of Bank losses in the United States since 1986")


### Part 02

mdata.work2 <- mdata.work %>% filter(Type == institution) %>% arrange(desc(Loss))
mdata.work2 <- head(mdata.work2,5)

ggplot(mdata.work2, aes(Name,Loss , fill = Name)) +
        geom_bar(stat = "identity") +
        scale_fill_brewer(palette="Pastel2") +
        theme(axis.text.x = element_text(angle = 75, hjust = 1)) +
        theme(axis.text.x=element_blank(),
              axis.ticks.x=element_blank()) +
        ylab("Loss (in billion)") + 
        xlab("Bank name")+
        ggtitle("Top 5 - Commercial bank failure cost for federal government since 1986")


### Part 03

mdata.work3 <- mdata.bank %>% select(Failure.Date,Estimated.Loss..2015.)
mdata.work3$Estimated.Loss..2015. <- 1
colname2 <- c("Date","Loss")
names(mdata.work3) <- colname2

mdata.work3$Date <- format(mdata.work3$Date, "%Y")
data.work3 <- mdata.work3 %>% group_by(Date) %>%  summarise(Loss = sum(Loss))


ggplot(data.work3, aes(Date,Loss,fill=Date)) +
        geom_bar(stat = "identity") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))+ 
        guides(fill=FALSE) + 
        ylab("Number of institutions") +
        ggtitle("A History of Bank Failures in the United States")


plot_ly(x=data.work3$Date, y=data.work3$Loss, type = "bar", color = ~ data.work3$Date, 
        colors=c("orange","green","cornflowerblue","violet") ) %>%
        layout(showlegend = FALSE)

### Part 04

mdata.work4 <- mdata.bank %>% select(Institution.Name,Failure.Date,Total.Assets)
colname3 <- c("Name","Date","Assets")
names(mdata.work4) <- colname3

mdata.work4$Date <- format(mdata.work4$Date, "%Y")
mdata.work4 <- mdata.work4 %>% group_by(Name,Date) %>%  summarise(Assets = sum(Assets))

mdata.work4$Assets <- mdata.work4$Assets / 1000000

library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(plotly)
library(data.table)



mdata.bank <- read.csv("data/banks.csv")

mdata.bank$Failure.Date <- as.Date(mdata.bank$Failure.Date, "%m/%d/%Y")
mdata.bank$Estimated.Loss..2015.[is.na(mdata.bank$Estimated.Loss..2015.)] <- 0

mdata.work <- mdata.bank  %>% select(Institution.Name,Institution.Type,Failure.Date,Estimated.Loss..2015.)
colname <- c("Name","Type", "Date", "Loss")
names(mdata.work) <- colname

mdata.work$Date <- format(mdata.work$Date, "%Y")

mdata.work <- mdata.work %>% group_by(Date,Type,Name) %>%  summarise(Loss = sum(Loss))
mdata.work$Date <- as.numeric(mdata.work$Date)
mdata.work$Loss <- mdata.work$Loss/1000000
        
        ggplot(mdata.work, aes(Date,Loss, fill=Type)) +
        geom_bar(stat = "identity") +
        scale_fill_brewer(palette="Pastel2") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
        xlim(1980,2020) +
        ylab("Loss (in billion)") +
        ggtitle("A History of Bank losses in the United States since 1986")

        
        ggplot(mdata.work, aes(Date,Loss , fill = Type )) +
        geom_bar(stat = "identity") +
        theme(axis.text.x = element_text(angle = 75, hjust = 1)) +
        theme(axis.text.x=element_blank(),
              axis.ticks.x=element_blank()) +
        ylab("Loss (in billion)") +
        xlab("Bank name")+
        ggtitle("Top 5 - Commercial bank failure cost for federal government since 1986")


