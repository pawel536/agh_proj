library(csrplus)
library(ggplot2)
data(quakes)
quakes

#1
plot(quakes$long, quakes$lat, main="Mapa epicentrum",
     xlab="Dl geog ", ylab="Szer geog ", pch=20)
#ggplot(quakes,aes(x=long, y=lat)) + geom_point()

#2
plot(quakes$mag, quakes$stations, pch=20)

#3
xsth<-jitter(quakes$mag, amount = 0.05)

plot(xsth, quakes$stations, pch=20, main="Fiji eq", xlab = "Magnitude", 
     ylab = "No of sth recorded", col=rgb(0.1, 0.2, 0.8, alpha=0.3) )

#4
Quake.mod<-lm(stations~mag, data=quakes)
Quake.mod

#5
abline(Quake.mod)

#6
QR<-Quake.mod$residuals #residuals(Quake.mod)
QFV<-Quake.mod$fitted.values #fitted(Quake.mod)
plot(quakes$mag, QR, pch=20, col=rgb(0.1, 0.2, 0.8, alpha=0.3),
     main="Residual plot", xlab = "Magnitude", ylab = "Residual")
abline(h=0)

#7
hist(QR, breaks=20)
# zatem reszty maja rozk³ad zbli¿ony do normalnego

#8
plot(xsth, quakes$stations, pch=20, main="Fiji eq", xlab = "Magnitude", 
     ylab = "No of ... recorded", col=rgb(0.1, 0.2, 0.8, alpha=0.3) )
abline(Quake.mod, col="red")
cf<-confint(Quake.mod, level = 0.95) #cf
abline(coef=cf[,1],col="black")
abline(coef=cf[,2],col="black")

#9
#a RSS
a<-deviance(Quake.mod)

#b RSE
summary(Quake.mod)$sigma

#c ( d=1-c -> c=1-d )
1-summary(Quake.mod)$r.squared

#d
summary(Quake.mod)$r.squared
#R^2 = 0.7245





