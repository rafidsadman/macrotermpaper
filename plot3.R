library(dplyr)
library(ggplot2)
library(Cairo)

per_capita <- read.csv("per capita health exp.csv", skip = 2) #.x
perc_gdp <- read.csv("health exp % of gdp.csv", skip = 2) #.y
metadata <- read.csv("Metadata.csv", header = TRUE)

data_scatter <- merge(per_capita, perc_gdp, by.x = "Country.Code", by.y = "Country.Code")
data <- merge(data_scatter, metadata, by.x = "Country.Code", by.y = "ï..Country.Code")

plotdata <- data[,c(1,2,22,44,45,43)]

plotdata <- tbl_df(plotdata)
plotdata$X2017.x <- as.numeric(plotdata$X2017.x)
plotdata$X2017.y <- as.numeric(plotdata$X2017.y)

plotdata <- subset(plotdata, IncomeGroup == "Lower middle income")


g <- ggplot(plotdata, aes(X2017.y, X2017.x))

CairoPNG("plot3.png", width = 600, heigh = 500)
g + geom_point(aes(color = Region), size = 2, alpha = .75) + geom_vline(xintercept = 5, linetype = "dotted", color = "red", size = 1) + labs(x = "Health Expenditure(% of GDP)", y = "Per Capita Health Expenditure($ 2017)", title = "Health Expenditure Scatterplot of Lower Middle Income Countries(based on 2017 data)")
dev.off()