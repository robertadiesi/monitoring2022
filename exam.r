
setwd("C:/Users/Rober/Desktop/exam_monitoring")



library(ncdf4) # for formatting our files - to manage spatial data from Copernicus, read and manipulate them (in nc)
library(raster) # work with raster file (single layer data)
library(ggplot2) # for plots - to ggplot raster layers - create graphics
library(viridis) # colorblind friendly palettes 
library(patchwork) # for comparing separate ggplots, building a multiframe 
library(gridExtra) # for grid.arrange plotting, creating a multiframe  
library(rgdal)


# one by one
FCOVER2000 <- raster("c_gls_FCOVER_200003100000_GLOBE_VGT_V2.0.2.nc")
FCOVER2000

FCOVER2005 <- raster("c_gls_FCOVER_200503100000_GLOBE_VGT_V2.0.1.nc")
FCOVER2005

FCOVER2010 <- raster("c_gls_FCOVER_201003100000_GLOBE_VGT_V2.0.1.nc")
FCOVER2010

FCOVER2015 <- raster("c_gls_FCOVER-RT6_201503100000_GLOBE_PROBAV_V2.0.2.nc")
FCOVER2015
  
FCOVER2020 <- raster("c_gls_FCOVER-RT6_202003100000_GLOBE_PROBAV_V2.0.1.nc")
FCOVER2020

# otherwise to import multiple data with the same pattern in the name I can create a list and use the lapply function
# this is very useful when we have many file to import

rlist <- list.files(pattern="c_gls_FCOVER")
rlist

# apply raster function to all the files to create raster layer objects
list_rast <- lapply(rlist, raster) 
list_rast

FCOVERstack <- stack(list_rast) 
FCOVERstack

# change the names because they are to long, make things more simple
names(FCOVERstack) <- c("FCOVER.1km.1","FCOVER.1km.2","FCOVER.1km.3","FCOVER.1km.4","FCOVER.1km.5")
plot(FCOVERstack)


# crop over osa peninsula
ext <-c (-83.7415, -83.2471, 8.3611, 8.7716)
FCOVERcrop <- crop(FCOVERstack, ext)
FCOVERcrop


# to unstack the images we can use the $ symbol
FCOVER2000 <- FCOVERcrop$FCOVER.1km.1
FCOVER2005 <- FCOVERcrop$FCOVER.1km.2
FCOVER2010 <- FCOVERcrop$FCOVER.1km.3
FCOVER2015 <- FCOVERcrop$FCOVER.1km.4
FCOVER2020 <- FCOVERcrop$FCOVER.1km.5

# Convert raster into data frames to ggplot them 
FCOVER2000_df <- as.data.frame(FCOVER2000, xy=TRUE) 
FCOVER2005_df <- as.data.frame(FCOVER2005, xy=TRUE) 
FCOVER2010_df <- as.data.frame(FCOVER2010, xy=TRUE) 
FCOVER2015_df <- as.data.frame(FCOVER2015, xy=TRUE) 
FCOVER2020_df <- as.data.frame(FCOVER2020, xy=TRUE) 


g1 <- ggplot() + geom_raster(FCOVER2000_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.1)) + scale_fill_viridis(option = "D") + ggtitle("Forest percentage in 2000") + labs(fill = "FCOVER")
g2 <- ggplot() + geom_raster(FCOVER2005_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.2)) + scale_fill_viridis(option = "D") + ggtitle("Forest percentage in 2005") + labs(fill = "FCOVER")
g3 <- ggplot() + geom_raster(FCOVER2010_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.3)) + scale_fill_viridis(option = "D") + ggtitle("Forest percentage in 2010") + labs(fill = "FCOVER")
g4 <- ggplot() + geom_raster(FCOVER2015_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.4)) + scale_fill_viridis(option = "D") + ggtitle("Forest percentage in 2015") + labs(fill = "FCOVER")
g5 <- ggplot() + geom_raster(FCOVER2020_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.5)) + scale_fill_viridis(option = "D") + ggtitle("Forest percentage in 2020") + labs(fill = "FCOVER")

#patchwork package 
g2 + g1 + g3 / g4 + g5

# I don't like it, so let's use 
grid.arrange(g1, g2, g3, g4, g5, nrow=2)

