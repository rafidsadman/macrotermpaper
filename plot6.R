library(dplyr)
library(ggplot2)
library(Cairo)

domspend_perc <- read.csv("dghe percent of total gov exp.csv", skip = 2) #.x
domspend <- read.csv("domestic general health expenditure(% of current exp).csv")#.y
metadata <- read.csv("Metadata.csv", header = TRUE)

mdata <- merge(domspend, metadata, by.x = "Country.Code", by.y = "ï..Country.Code")
data <- merge(domspend_perc, mdata, by.x = "Country.Code", by.y = "Country.Code")

data <- data[,c(1,2,22,43,44,45)]

plotdata <- tbl_df(data) 
plotdata$X2017.x <- as.numeric(plotdata$X2017.x)
plotdata$X2017.y <- as.numeric(plotdata$X2017.y)

plotdata <- plotdata %>% 
  mutate_all(~ifelse(. %in% c("N/A", "null", ""), NA, .)) %>% 
  na.omit()

plotdata_cluster <- plotdata[,c(3,4)]
cls <- kmeans(plotdata_cluster, centers = 6)
plotdata$cluster <- as.character(cls$cluster)

unprep <- subset(plotdata, cluster == "4")


g <- ggplot(plotdata, aes(X2017.y, X2017.x))

CairoPNG("plot6.png", width = 600, height = 600)
g + geom_point(aes(color = cluster), size = 2, alpha = .5)  + facet_grid(IncomeGroup~.) +
  labs(x = "DGGHE(% of Current Health Expenditure)", y = "DGGHE % of General Govt. Expenditure", title = "Domestic General Govt Health Expenditure in Different Countries")
dev.off()
