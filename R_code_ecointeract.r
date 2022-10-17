# This is a code for investigating relationships among ecological variables

# We are using the sp package. To install it use:
# install.packages("sp")
library(sp) # you can also make use of require (), it is usefull to make additional pieces of R

# we are using meuse:
# search for: "meuse dataset R sp package"
# https://search.r-project.org/CRAN/refmans/geostats/html/meuse.html

data(meuse) # Loads specified data sets, or list the available data sets.

View(meuse) # The View () function in R invokes a spreadsheet-style data viewer on a matrix-like R object. To show data in a table.

head(meuse) # It gives you a snapshot of that large dataset

names(meuse) # to assign a name to each of the elements of our vector

summary(meuse) # To get a better idea of the distribution of your variables in the dataset

plot(cadmium,zinc) # you will receive an error, because the object is "meuse"
# we need to explain to R that cadmium and zinc are part of the object "meuse", they're linked
# we use "$" to link things to each other, in this case we link meuse$cadmium and meuse$zinc
plot(meuse$cadmium, meuse$zinc)

cad <- meuse$cadmium   # we make a new object "cad" to make things more simple
zin <- meuse$zinc
plot(cad,zin)
attach(meuse) # attach is used to access the variables present in the data framework without calling the data frame. If we use attach, we don't need to use the $ simbol
plot(cadmium,zinc)
# detach (meuse)

# now we're gonna see the relationship between all the variables 
# we use "pairs"
pairs(meuse) # to create a pairwise correlation plot

meuse[,3:6] # to select specific variables/columns

pol <- meuse[,3:6] 
head(pol) # to show the first 6 columns
pairs(pol, col="blue", cex=1.5)

# let's use the names of the columns:

# in R ~ (tilde) means =  
pairs(~cadmium + copper + lead + zinc, data=meuse)

panel.correlations <- function (x, y, digits=1, prefix="", cex.cor)
  
coordinates(meuse)= ~x+y       

spplot(meuse, "zinc", main="Concentration of zinc")  #spplot is designed to combine a standard R plot with a legend representing a (continuous) color scale
# main is the title of the plot

spplot(meuse, c("copper","zinc","lead")) 

bubble(meuse, "zinc")
