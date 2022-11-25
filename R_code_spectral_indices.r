landcover <- c("Forest", "Humans")
percent_1992 <- c(89.77, 10.23)
percent_2006 <- c(51.99, 48.01)
perc <- data.frame(landcover, percent_1992, percent_2006)

library(ggplot2)

ggplot(perc, aes(x=landcover, y=percent_1992, color=landcover)) + geom_bar(stat="identity", fill= "light green")
ggplot(perc, aes(x=landcover, y=percent_2006, color=landcover)) + geom_bar(stat="identity", fill= "light green")

# install.packages("patchwork")
library(patchwork)

p1 <- ggplot(perc, aes(x=landcover, y=percent_1992, color=landcover)) + geom_bar(stat="identity", fill= "light green")
p2 <- ggplot(perc, aes(x=landcover, y=percent_2006, color=landcover)) + geom_bar(stat="identity", fill= "light green")
p1 + p2
p1/p2

setwd("C:/Users/Rober/Desktop")

ggplot()+
geom_raster(dvi1992, mapping
install.packages("viridis")
library(viridis)

