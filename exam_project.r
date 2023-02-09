# Hi and welcome to my first R Project for Monitoring Ecosystems!

## Let's start by loading and installing the packages I need to use for the project

# To manage raster information and way more
library(raster)  
# To open Copernicus data with nc extention
library(ncdf4) 
# To produce the plots with ggplot function
library(ggplot2)       
# To provide a set of high-level remote sensing tools for various classification tasks
library (RStoolbox)    
# To use viridis palette
library(viridis)       
# To plot together different plots made with ggplot
library(patchwork)     


# I'm going to set the working directory 

setwd("C:/Users/Rober/Desktop/exam_project")


# The aim of this project is to compare the difference in Snow Content Area in the Alps located in the North of Italy between the winter of 2017 and winter 2022
## Snow Cover is a relevant input parameter for weather forecasts and climate change observations 
## I downloaded the data of Snow Cover Extent (SCE) from Copernicus, using the 500m x 500m per pixel resolution 

# Let's proceed by importing the data of winter 2022 from Copernicus 

raster("c_gls_SCE500_202202280000_CEURO_MODIS_V1.0.1.nc")
snow2022 <- raster("c_gls_SCE500_202202280000_CEURO_MODIS_V1.0.1.nc")

# Now I'm going to use the plot function, that is useful for creating graphs and charts for visualizations
plot(snow2022)

# Since the area visualized is too wide and I want to focus only on the area of the Alps in the North of Italy, I'm going to crop the image 
# let's add the coordinates numbers I found on Copernicus to define the region of interest 
ext <- c(4.29, 16.11, 43.17, 48.61)
snow22 <- crop(snow2022, ext)

# now I use the plot function to visualize the new image
plot(snow22)

# Let's save the new image in PNG format in the folder 
png(file="image_winter22.png", units="cm", width=30, height=25, res=400)
plot(snow22)
dev.off()

# Now I can import the Copernicus data of winter 2017
snow2017 <- raster("c_gls_SCE500_201703010000_CEURO_MODIS_V1.0.1.nc")
# cropping the image focusing on the same area of interest
snow17 <- crop(snow2017, ext)
plot(snow17)

# Save in PNG
png(file="image_winter17.png", units="cm", width=30, height=25, res=400)
plot(snow17)
dev.off()

p22 <- ggplot() + geom_raster(snow22, mapping = aes(x=x, y=y, fill = Snow.Cover.Extent)) + scale_fill_viridis() + ggtitle("Snow Cover in winter 2022")
p17 <- ggplot() + geom_raster(snow17, mapping = aes(x=x, y=y, fill = Snow.Cover.Extent)) + scale_fill_viridis() + ggtitle("Snow Cover in winter 2017")

png(file="image_winter17_22.png", units="cm", width=30, height=25, res=400)
p17 / p22
dev.off()

# computing differece in snow cover between 2017 and 2022
dif <- (snow22 - snow17)
plot(dif)

# The visualization with these colors is not that clear, let's change them with the colorRampPalette function
coldif = colorRampPalette(c("green", "blue", "orange"))(100) 
plot(dif, col=coldif)
# in green the snow missing in 2022 with respect to 2017

# saving the file in PNG format
png(file="diff_winter17_22.png", units="cm", width=30, height=25, res=600)
plot(dif, col=coldif)
dev.off()


