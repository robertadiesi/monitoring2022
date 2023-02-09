# R Project for Monitoring Ecosystems

# Let's start by setting the working directory 

setwd("C:/Users/Rober/Desktop/exam_project")

# now I procede by loading/installing the packages I need to use 

library(raster)        # to manage raster information and way more 
library(ggplot2)       # to produce the plots with ggplot function
library (RStoolbox)    # to provide a set of high-level remote sensing tools for various classification tasks
library(viridis)       # to use viridis palette
library(patchwork)     # to plot together different plots made with ggplot


# The aim of this project is to compare the difference in Snow Content Area in the Alps located in the North of Italy between the winter of 2022 and 2023
# Snow Cover is a relevant input parameter for weather forecasts and climate change observations

# I downloaded the data of Snow Cover Extent (SCE) from Copernicus, using the 500m x 500m per pixel resolution

# let's proceed by importing the data of winter 2022 from Copernicus 

raster("")
