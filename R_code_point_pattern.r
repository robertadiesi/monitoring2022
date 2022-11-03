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


# Install the rgdal package by:
# install.packages("rgdal")
library(rgdal)   # GDAL is a translator library for raster and vector geospatial data formats
setwd("C:/Users/Rober/Desktop/lab")
#let's add the coastlines
coastlines <- readOGR("ne_10m_coastline.shp")
covid <- read.table("covid_agg.csv", header=T)
covid
head(covid)
attach(covid)
covid_planar <- ppp(x=lon, y=lat, c(-180, 180), c(-90,90))
plot(covid_planar)
plot(coastlines,add=T)
density_map <- density(covid_planar)
plot(density_map)
points(covid_planar, pch=18, col="green")
plot(coastlines, add=T)
plot(coastlines, add=T, col="yellow")

cl <- colorRampPalette(c("bisque", "azure", "brown"))(100)
plot(density_map, col=cl)
points(covid_planar, pch=18)
plot(coastlines, add=T)


 #suing interpolation
attach(covid)
marks(covid_planar) <- cases


cases_map <- Smooth(covid_planar)
plot(cases_map, col=cl)
points(covid_planar)
plot(coastlines, add=T)
