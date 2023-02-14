library(ncdf4) # for formatting our files - to manage spatial data from Copernicus, read and manipulate them (in nc)
library(raster) # work with raster file (single layer data)
library(ggplot2) # for plots - to ggplot raster layers - create graphics
library(viridis) # colorblind friendly palettes 
library(patchwork) # for comparing separate ggplots, building a multiframe 
library(gridExtra) # for grid.arrange plotting, creating a multiframe  
library(rgdal)

setwd("C:/Users/Rober/Desktop/exam_monitoring")
raster("c_gls_FCOVER_QL_200003100000_GLOBE_VGT_V2.0.2.nc")
FCOVER2000 <- raster("c_gls_FCOVER_QL_200003100000_GLOBE_VGT_V2.0.2.nc")
