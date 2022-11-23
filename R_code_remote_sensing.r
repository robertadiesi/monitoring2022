# R code for remote sensing data analysis in ecosystem monitoring

library(raster)
library(RStoolbox)

install.packages(c("raster","RStoolbox"))
> library(RStoolbox)
Errore: caricamento pacchetto o namespace fallito per ‘RStoolbox’ in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
 non c'è alcun pacchetto chiamato ‘recipes’
In aggiunta: Messaggio di avvertimento:
il pacchetto ‘RStoolbox’ è stato creato con R versione 4.2.2 

setwd("C:/Users/Rober/Desktop/lab")

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) # 
plot(p224r63_2011, col=cl)

plot(p224r63_2011$B1_sre, col=cl)
plot(p224r63_2011[[1]], col=cl)

par(mfrow=c(1,2)) # multiframe
plot(p224r63_2011[[2]], col=cl)

plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)
plot(p224r63_2011[[3]], col=cl)
plot(p224r63_2011[[4]], col=cl)

# exercise: plot the four bands with different legends 
par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011[[1]], col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)

# Exercise: plot the final band, namely the NIR, band number 4
# red, orange, yellow
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

# -----

# multilayered colors 
dev.off()
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

# plot the previous 4 manners in a single multiframe 
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Hist")

### back in time 
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=4, b=2, stretch="Lin")

# exercise: make a multiframe with 2 rows and 1 column plotting the 1988 and the 2011 images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=4, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# calculating the difference between images
# multitemporal analysis 
difnir <- p224r63_1988[[4]] - p224r63_2011[[4]]
cl <- colorRampPalette(c('green','blue','yellow'))(100) #
plot(difnir,col=cl)

# difference vegetation Index
# recent DVI (2011)
DVI2011 <- p224r63_2011[[4]] - p224r63_2011[[3]]
DVI1988 <- p224r63_1988[[4]] - p224r63_1988[[3]]

difDVI <- DVI1988 - DVI2011
cl <- colorRampPalette(c('blue','white','red'))(100) #
plot(difDVI, col=cl)
