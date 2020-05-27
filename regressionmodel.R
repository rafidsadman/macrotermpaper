##Correlation between Health Care spending per capita Vs Govt Spending on Healthcare(% of total health expenditure)

library(dplyr)
library(ggplot2)
library(Cairo)

data <- read.csv("corrdata2.csv")

data <- tbl_df(data)
data$govspending <- as.numeric(data$govspending)
  
cor <- cor(data$adjust_percap, data$govspending)

lmodel <- lm(data$adjust_percap ~ data$govspending)
modelsummary <- summary(lmodel)
modelcoeffs <- modelsummary$coefficients
beta.estimate <- modelcoeffs["data$govspending", "Estimate"]
std.error <- modelcoeffs["data$govspending", "Std. Error"]
t_value <- beta.estimate/std.error  # calc t statistic
p_value <- 2*pt(-abs(t_value), df=nrow(data)-ncol(data))  # calc p Value

g <- ggplot(data, aes(govspending, percapita.))

CairoPNG("lmplot1.png", widht = 800, height = 500)
g + geom_point() + geom_smooth(method = "lm") + labs(x = "Total Govt. Spending in Health Care", y = "Per Capita Spending in Health Care", title = "Linear Regression Model: Bangladesh Govt. Spending Vs Per Capita Spending")
dev.off()

