# Community ecology example with R
# Multivariate analysis

install.packages("vegan")
library(vegan)

setwd("C:\Users\Rober\Desktop")

# to upload R project, use the following function
load("biomes_multivar.RData")
ls()

# plot per species matrix
head(biomes)

biomes_types

multivar <- decorana(biomes)
multivar

plot(multivar)
attach(biomes_types)

# biomes names in the graph:
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T)
