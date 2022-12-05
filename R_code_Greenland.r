> library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)


> setwd("C:/Users/Rober/Desktop/lab")
> lst_2000 <- raster("lst_2000.tif")
> lst_2000

# exercise: plot the lst_2000 with ggplot()
p1 <- ggplot() + 
geom_raster(lst_2000, mapping=aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma", direction=-1, alpha=0.2) +
ggtitle("Temperature 2000")

p2 <- ggplot() + 
geom_raster(lst_2000, mapping=aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma", direction=-1, alpha=0.8) +
ggtitle("Temperature 2000")

p1 + p2

# upload all the data
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# quite boring ah?
# Solution?
# Using the lapply function
rlist <- list.files(pattern="lst")
rlist

# Exercise: list: rlist, function: the function we need to import
# lapply(X, FUN)
import <- lapply(rlist, raster)

 TGr <- stack(import)
 TGr
 plot(TGr)
 
p1 <- ggplot() + 
geom_raster(TGr[[1]], mapping=aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma", direction=1, alpha=0.8) +
ggtitle("Temperature 2000")

 p2 <- ggplot() + 
geom_raster(TGr[[4]], mapping=aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma", direction=1, alpha=0.8) +
ggtitle("Temperature 2015")

 p1 + p2
 
 # exercise: make the difference between 2015 and 2000
 2015- 2000
 dift <- TGr[[4]] - TGr[[1]]
 
 p3 <- ggplot() + 
geom_raster(dift, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno", direction=1, alpha=0.8) +
ggtitle("Difference in temperature from 2000 to 2015")

p1 + p2 + p3

plotRGB(TGr, r=1, g=2, b=4, stretch="lin")
