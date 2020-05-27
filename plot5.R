library(dplyr)
library(ggplot2)
library(Cairo)

domspend <- read.csv("domestic general health expenditure(% of current exp).csv")
metadata <- read.csv("Metadata.csv", header = TRUE)

domspend <- domspend[,c(1,2,22)]
data <- merge(domspend, metadata, by.x = "Country.Code", by.y = "ï..Country.Code")

plotdata <- data[,-6]

plotdata <- tbl_df(plotdata)
plotdata$X2017 <- as.numeric(plotdata$X2017)


plotdata <- plotdata %>% 
  mutate_all(~ifelse(. %in% c("N/A", "null", ""), NA, .)) %>% 
  na.omit()

g <- ggplot(plotdata, aes(X2017))

CairoPNG("plot5.png", width = 600, height = 500)
g + geom_histogram(aes(color = IncomeGroup)) + 
  geom_vline(xintercept = 36) +
  geom_text(aes(x=36, label="75 Percentile from right", y=10), colour="black", angle=90, vjust = 1.2, size=3) +
  labs(x = "% of total Health Expenditure", y = "Count of Countries", title = "Domestic General Govt. Health Expenditure in Different Income Group Countries")
dev.off()

  