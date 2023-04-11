
#cw8 p2 a

library(corrplot)
library(MASS)
var<-UScereal[, c(2:10)]
corr_matrix<-cor(var)
corrplot(corr_matrix, method = "color", type="upper")

#cw8 p2 b

plot(mtcars$hp, mtcars$mpg, type = "n", #nie nanosi
     xlab = "Horsepower", ylab = "Gas mileage")
points(mtcars$hp, mtcars$mpg, pch = mtcars$cyl)
text(x = mtcars$hp,
     y = mtcars$mpg,
     labels = mtcars$am, adj = -1)


#cw8 zad2 a
par(mfrow=c(1,2))
hist(Cars93$Horsepower, xlab="HorsePower", main="histogram")
truehist(Cars93$Horsepower, xlab="HorsePower",main="histogram z MASS")
lines(density(Cars93$Horsepower))


#cw8 zad2 b

install.packages("aplpack")
library(aplpack)

par(mfrow=c(2,2))
plot(Boston$zn, Boston$rad,pch=5,col=7)
title("scatterplot")
sunflowerplot(Boston$zn, Boston$rad,pch=8,col=18)
title("sunflower plot")
boxplot(crim~rad, data=Boston, xlab="rad", ylab="crim", main="boxplot", log = "y", col=6)
title("boxplot")
bagplot(Boston$zn, Boston$rad, xlab="zn", ylab="rad")
title("bagplot")


#cw8 zad2 c

par(mfrow=c(1,1))
plot(Cars93$Horsepower, Cars93$MPG.city, type = "n",
     xlab = "Horsepower", ylab = "Gas mileage")
points(Cars93$Horsepower, Cars93$MPG.city, pch = as.character(mtcars$cyl))

plot(Cars93$Horsepower, Cars93$MPG.city,
     pch=as.character(mtcars$cyl), xlab = "Horsepower", ylab = "MPG.city")


#cw8 zad2 d

# index<-Cars93[Cars93$Cylinders == 3,] LUB
index<-which(Cars93$Cylinders==3)
plot(MPG.city~Horsepower,data=Cars93,pch=15)
text(x = Cars93$Horsepower[index],
     y = Cars93$MPG.city[index],
     labels = Cars93$Make[index], cex=2, font=2)
