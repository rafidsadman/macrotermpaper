library(dplyr)
library(ggplot2)
library(Cairo)

per_capita <- read.csv("per capita health exp.csv", skip = 2)
perc_gdp <- read.csv("health exp % of gdp.csv", skip = 2)

data_scatter <- matrix(c(per_capita$Country.Name, per_capita$Country.Code, per_capita$X2017, perc_gdp$X2017), ncol = 4)
colnames(data_scatter) <- c("Country Name", "Country Code", "Per Capita Health Exp", "Health Exp % of GDP")

data_scatter <- tbl_df(data_scatter)
data_scatter$`Per Capita Health Exp` <- as.numeric(data_scatter$`Per Capita Health Exp`)
data_scatter$`Health Exp % of GDP` <- as.numeric(data_scatter$`Health Exp % of GDP`)

g <- ggplot(data = data_scatter, aes(`Health Exp % of GDP`, `Per Capita Health Exp`))


png("plot1.png", width = 500, height = 500)
g + geom_point(color = "blue", size = 3, alpha = 1/4) + labs(x = "Health Expenditure(% of GDP)", y = "Per Capita Health Expenditure($ 2017)", title = "Health Expenditure Scatterplot(based on 2017 data)")
dev.off()
