# my first R project!

# first of all let's set the working directory

setwd("C:/Users/Rober/Desktop/exam_monitoring")


# I # recall the libraries for already installed packaged that I need 

library(ncdf4) # for formatting our files - to manage spatial data from Copernicus, read and manipulate them (in nc)
library(raster) # work with raster file (single layer data)
library(ggplot2) # for plots - to ggplot raster layers - create graphics
library(viridis) # colorblind friendly palettes 
library(patchwork) # for comparing separate ggplots, building a multiframe 
library(gridExtra) # for grid.arrange plotting, creating a multiframe  
library(rgdal)


# importing the Copernicus data
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

# Create a stack
FCOVERstack <- stack(list_rast) 
FCOVERstack

# change the names because they are to long, make things more simple
names(FCOVERstack) <- c("FCOVER.1km.1","FCOVER.1km.2","FCOVER.1km.3","FCOVER.1km.4","FCOVER.1km.5")
plot(FCOVERstack)


# cropping the image focusing on the area of interest, in this case is Costa Rica
ext <-c (-85.9797, -82.7917, 7.9958, 11.2468)
FCOVERcrop <- crop(FCOVERstack, ext)
plot(FCOVERcrop)
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


g1 <- ggplot() + geom_raster(FCOVER2000_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.1)) + scale_fill_viridis(option = "D") + ggtitle("Forest Cover in 2000") + labs(fill = "FCOVER")
g2 <- ggplot() + geom_raster(FCOVER2005_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.2)) + scale_fill_viridis(option = "D") + ggtitle("Forest Cover in 2005") + labs(fill = "FCOVER")
g3 <- ggplot() + geom_raster(FCOVER2010_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.3)) + scale_fill_viridis(option = "D") + ggtitle("Forest Cover in 2010") + labs(fill = "FCOVER")
g4 <- ggplot() + geom_raster(FCOVER2015_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.4)) + scale_fill_viridis(option = "D") + ggtitle("Forest Cover in 2015") + labs(fill = "FCOVER")
g5 <- ggplot() + geom_raster(FCOVER2020_df, mapping = aes(x=x, y=y, fill=FCOVER.1km.5)) + scale_fill_viridis(option = "D") + ggtitle("Forest Cover in 2020") + labs(fill = "FCOVER")

#patchwork package 
g2 + g1 + g3 / g4 + g5

# I don't like it, so let's use 
grid.arrange(g1, g2, g3, g4, g5, nrow=3)

# saving the file in PNG format in the output folder
png("outputs_fcover_ggplot.png", res= 300, width = 3000, heigh = 3000)
grid.arrange(g1, g2, g3, g4, g5, nrow=3)
dev.off()

# # Create a color palette with colorRampPalette and trying different colors
cl1 <- colorRampPalette(colors = c('red','yellow','lightgreen','darkgreen'))(100)
plot(FCOVERcrop, col=cl1) # in red less vegetation cover

# Plot FCOVER of each year
par(mfrow=c(2,3))
plot(FCOVER2000, main="Forest Cover in 2000", col=cl1)
plot(FCOVER2005, main="Forest Cover in 2005", col=cl1)
plot(FCOVER2010, main="Forest Cover in 2010", col=cl1)
plot(FCOVER2015, main="Forest Cover in 2015", col=cl1)
plot(FCOVER2020, main="Forest Cover in 2020", col=cl1)

# export
png("outputs_fcover.png", res = 300, width = 3000, heigh = 3000)
par(mfrow=c(3,2))
plot(FCOVER2000, main="Forest Cover in 2000", col=cl1)
plot(FCOVER2005, main="Forest Cover in 2005", col=cl1)
plot(FCOVER2010, main="Forest Cover in 2010", col=cl1)
plot(FCOVER2015, main="Forest Cover in 2015", col=cl1)
plot(FCOVER2020, main="Forest Cover in 2020", col=cl1)
dev.off()


# plotting frequency distribution of forest cover value -> plot all histograms together

par(mfrow=c(3,2))
hist(FCOVER2000, main= "Forest Cover in 2000")
hist(FCOVER2005, main= "Forest Cover in 2005")
hist(FCOVER2010, main= "Forest Cover in 2010")
hist(FCOVER2015, main= "Forest Cover in 2015")
hist(FCOVER2020, main= "Forest Cover in 2020")

#Export them
png("outputs_hist_FCOVER.png", res = 300, width = 3000, heigh = 3000)
par(mfrow=c(3,2))
hist(FCOVER2000, main= "Forest Cover in 2000")
hist(FCOVER2005, main= "Forest Cover in 2005")
hist(FCOVER2010, main= "Forest Cover in 2010")
hist(FCOVER2015, main= "Forest Cover in 2015")
hist(FCOVER2020, main= "Forest Cover in 2020")
dev.off()

# when we have many graphs, we can plot automathically all graphs together
pairs(FCOVERcrop)

# plotting values of 2000 against 2020 to better see the differences 
plot(FCOVER2000, FCOVER2020, xlab = "Forest Cover in 2000", ylab = "Forest Cover in 2020") 
abline(0, 1, col="blue") 

# Export
png("outputs_FCOVER_2000vs2020.png", res = 300, width = 3000, heigh = 3000)
plot(FCOVER2000, FCOVER2020, xlab = "Forest Cover in 2000", ylab = "Forest Cover in 2020") 
abline(0, 1, col="blue") 
dev.off()

# I want to produce a matrix of scatterplots 
pairs(FCOVERcrop)

# Export
png("outputs_FCOVER_matrix.png", res = 300, width = 3000, heigh = 3000)
pairs(FCOVERcrop)
dev.off()

# Plot the difference between 2000-2020 so I can see better the differences between the two layers
dif <- FCOVER2000 - FCOVER2020
dif
cl2 <- colorRampPalette(colors = c('red','yellow','lightgreen','black'))(100)
plot(dif, col=cl2, main = "Difference Forest Cover between 2000 and 2020")


# Export
png("outputs_FCOVER_dif.png", res = 600, width = 3000, heigh = 3000)
plot(dif, col=cl2, main = "Difference Forest Cover between 2000 and 2020")
dev.off()


# Download data from Copernicus Global Land Service on Leaf Area Index (1km V2)

# listing all the files with the pattern present in the working directory
LAIlist <- list.files(pattern="LAI") 
LAIlist

# Apply raster function to all the files
LAIlist_rast <- lapply(LAIlist, raster) 
LAIlist_rast

# Create a stack
LAIstack <- stack(LAIlist_rast) 
LAIstack

# Change variables'names 
names(LAIstack) <- c("LAI.1km.1","LAI.1km.2","LAI.1km.3")

# Crop over Costa Rica
LAIcrop <- crop(LAIstack, ext)
plot(LAIcrop)
LAIcrop

# Separate files, assigning to each element of the crop a name
LAI2000 <- LAIcrop$LAI.1km.1
LAI2010 <- LAIcrop$LAI.1km.2
LAI2020 <- LAIcrop$LAI.1km.3

# Convert raster into data frames to ggplot them
LAI2000df <- as.data.frame(LAI2000, xy=TRUE) 
LAI2010df <- as.data.frame(LAI2010, xy=TRUE) 
LAI2020df <- as.data.frame(LAI2020, xy=TRUE) 

# Plot them with ggplot
p1 <- ggplot() + geom_raster(LAI2000df, mapping = aes(x=x, y=y, fill=LAI.1km.1)) + scale_fill_viridis(option = "magma") + ggtitle("Leaf Area Index in 2000") + labs(fill = "LAI")
p2 <- ggplot() + geom_raster(LAI2010df, mapping = aes(x=x, y=y, fill=LAI.1km.2)) + scale_fill_viridis(option = "magma") + ggtitle("Leaf Area Index in 2010") + labs(fill = "LAI")
p3 <- ggplot() + geom_raster(LAI2020df, mapping = aes(x=x, y=y, fill=LAI.1km.3)) + scale_fill_viridis(option = "magma") + ggtitle("Leaf Area Index in 2020") + labs(fill = "LAI")

# Plot them together
p1 + p2 + p3


# Export file
png("outputs_lai_ggplot.png", res = 500, width = 6000, heigh = 3000)
p1 + p2 + p3
dev.off()

# Plot the difference between 2000 and 2020:
dif_LAI<- LAI2000 - LAI2020

# Create a color palette 
cl2 <- colorRampPalette(colors = c('red','orange','green','black'))(100)
cl3 <- colorRampPalette(colors = c('blue','purple','coral','white'))(100)

par(mfrow=c(1,2))
plot(dif_LAI, col=cl2, main = "Difference in LAI between 2000 and 2020")
plot(dif_LAI, col=cl3, main = "Difference in LAI between 2000 and 2020")

# Export file
png("outputs_dif_LAI.png", res = 500, width = 6000, heigh = 3000)
par(mfrow=c(1,2))
plot(dif_LAI, col=cl2, main = "Difference in LAI between 2000 and 2020")
plot(dif_LAI, col=cl3, main = "Difference in LAI between 2000 and 2020")
dev.off()


