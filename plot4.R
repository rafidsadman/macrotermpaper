library(dplyr)
library(ggplot2)
library(Cairo)

out_pocket <- read.csv("Out of pocket health Exp(% of current exp).csv")
metadata <- read.csv("Metadata.csv", header = TRUE)

out_pocket <- out_pocket[,c(1,2,22)]
data <- merge(out_pocket, metadata, by.x = "Country.Code", by.y = "ï..Country.Code")

plotdata <- data[,-6]

plotdata <- tbl_df(plotdata)
plotdata$X2017 <- as.numeric(plotdata$X2017)

plotdata <- plotdata %>% 
  mutate_all(~ifelse(. %in% c("N/A", "null", ""), NA, .)) %>% 
  na.omit()

g <- ggplot(plotdata, aes(X2017))

CairoPNG("plotb.png", width = 600, heigh = 500)
g + geom_vline(xintercept = 45) +
  geom_text(aes(x=45, label="75 Percentile", y=15), colour="black", angle=90, vjust = 1.2, text=element_text(size=11)) +
  labs(x = "% of total Health Expenditure", y = "Count of Countries", title = "Out of Pocket Expenditure in Different Income Group Countries")
dev.off()