library(dplyr)
library(ggplot2)
library(Cairo)

data <- read.csv("Trend.csv")

g <- ggplot(data, aes(Year, X..of.GDP))

CairoPNG("plot7.png", height = 480, width = 480)
g + geom_line() + labs(y = "percentage of GDP", title = "Healthcare Expenditure % of GDP Trend")
dev.off()