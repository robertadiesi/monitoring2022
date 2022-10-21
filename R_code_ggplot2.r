# Installing the ggplot2 library / package

# install.packages("ggplot2")

library(ggplot2)

virus <- c(10, 30, 40, 50, 60, 80)
death <- c(100, 240, 310, 470, 580, 690)
plot(virus, death)

data.frame(virus, death) # to obtain the table with the two objects
d <- data.frame(virus, death)
summary(d) # to obtain the mean, median, etc..

ggplot(d, aes(x=virus, y=death)) + geom_point()
ggplot(d, aes(x=virus, y=death)) + geom_point(size=3, col="coral")

ggplot(d, aes(x=virus, y=death)) + geom_line()

ggplot(d, aes(x=virus, y=death)) + geom_point(size=3, col="coral") + geom_line(col="blue")

ggplot(d, aes(x=virus, y=death)) + geom_polygon()

# let's use our own data!
setwd("C:/lab/")

# to read the file inside our folder we use read.table
covid <- read.table("covid_agg.csv")   #covid_agg.csv is the file's name inside our folder
Errore in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  : 
  la linea 6 non ha 5 elementi
