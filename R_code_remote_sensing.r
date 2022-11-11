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
