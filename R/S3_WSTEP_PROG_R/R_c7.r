library("readr")
library("readxl")

#read.csv(file, header = TRUE, sep = ",", quote = "\"",
#         dec = ".", fill = TRUE, comment.char = "",...)
#read.delim(file, header = TRUE, sep = "\t", quote = "\"",
#           dec = ".", fill = TRUE, comment.char = "",
#write.csv(x, file, traitsAsDir = FALSE, csv2 = TRUE, row.names = FALSE, ...)

pools1<-read.csv("swimming_pools.csv")
str(pools1)
pools2<-read.csv('swimming_pools.csv', stringsAsFactors=FALSE)
str(pools2)
write.csv(pools2, "pools2.csv", row.names=TRUE)
test_delim <- read.delim ("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test_delim.txt", sep="$")


#cw7 zad 1
#a
hd<-read.delim("hotdogs.txt", sep="\t", col.names=c("type", "calories", "sodium"), header=FALSE )
summary(hd)
hd

cars_int <- read.delim ("http://monikachuchro.pl/media/cars.txt", sep=",", header=FALSE)
colnames(cars_int)<-c("mpg", "cylinders", "cubicinches", "hp", "weightlbs", "time-to-60", "year", "brand")
summary(cars_int)
cars_int


#cw7 p 2
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
potatoes1<-read_tsv("potatoes.txt", col_names=properties)
potatoes2<-read_delim("potatoes.txt", delim="\t" ,col_names=properties)

#cw7 zad 2
#a
potatoes_frag<-read_tsv("potatoes.csv",n_max=50,skip=6,col_names=properties)
potatoes_frag

#b
potatoes_char<-read_tsv("potatoes.txt",col_names=properties,col_types="cccccccc")

#c
write_csv(potatoes_frag, "potatoes_frag.csv", col_names=TRUE)

#d
write.table(mtcars,"mtcars_t.txt")

#e
write_csv(iris[,c("Sepal.Length","Sepal.Width")],"iris_subset_1.csv")
write.csv(iris[,c("Sepal.Length","Sepal.Width")],"iris_subset_2.csv")

#f




#cw8 p1
library(MASS)

str(whiteside)
plot(whiteside)

plot(whiteside$Temp, whiteside$Gas,
  type = "p", pch=17, col="springgreen", xlab = "Outside temperature",
  ylab = "Heating gas consumption")
title("Scatter plot")
abline(a=7, b=-0.5, lty=2, col="red")


par(mfrow=c(2,2))
plot(whiteside$Temp, col="#EE9A49")
  title("First graph")
boxplot(whiteside$Temp, col="orange")
  title("Second graph")
plot(whiteside$Gas, col="#EE90AA")
  title("Third graph")
boxplot(whiteside$Gas, col="red")
  title("Fourth graph")



#cw8 zad 1
#a
plot(Cars93$Price, Cars93$Max.Price,
       type = "p", pch=17, col="red")
  title("Price relationship")
points(Cars93$Price,Cars93$Min.Price, col="blue")

#b
par(mfrow=c(1,2))
plot(Cars93$Luggage.room, Cars93$RPM,
     pch=4, col="grey", xlab = "Luggage room", ylab = "RPM")
title("Original representation")
plot(Cars93$Luggage.room, Cars93$RPM,
     pch=20, col="green", xlab = "Luggage room", ylab = "RPM", log = "xy")
title("Log-log plot")

#c
par(mfrow=c(1,3))
pie(table(Cars93$Cylinders), col="green")
title("First graph")
barplot(table(Cars93$Cylinders), las = 2, cex.names = 0.5, col="blue")
title("Second graph")
hist(Cars93$Price, col=12)
title("Third graph")



