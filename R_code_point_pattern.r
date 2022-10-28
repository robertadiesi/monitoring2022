# Point pattern analysis

# install.packages("spatstat")
library(spatstat)

# use of working directory 
setwd("C:/Users/Rober/Desktop/lab")
covid <- read.table("covid_agg.csv", header=T)  # to read the table
head(covid)
summary(covid)

attach(covid)
covid_planar <- ppp(x=lon, y=lat, c(-180, 180), c(-90,90))   # Create a Point Pattern Description
plot(covid_planar)

density_map <- density(covid_planar)  # how much dense are the points of the covid planar

plot(density_map)
points(covid_planar)  # adding points to a graph
points(covid_planar, pch=19)

cl <- colorRampPalette(c('yellow','orange','red'))(100) # to change the map's colors
cl <- colorRampPalette(c("cyan", "coral", "chartreuse")) (50)
plot(density_map, col = cl)
points(covid_planar)
