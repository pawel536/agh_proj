library(dplyr)

##### 10-1 #####
dane<-read.csv("weather.csv", sep=';', dec=',', header = TRUE)
head(dane)
dane

##### 10-2 #####
str(dane)
dim(dane)

##### 10-3 #####
dane2 <- as.data.frame(dane)
dane2 <- dane2 [, c(-1,-2,-3,-4,-8)]
dane2
str(dane2)

##### 10-4 #####
#dane3 <- dane2 %>%
#  mutate_all(~ifelse(. %in% c("N/A", "null", ""), NA, .)) %>%
#  na.omit()

dane2 <- na.omit(dane2)

##### 10-5 #####
dim(dane2)
dane2

##### 10-6 #####
library(caTools)
Y <- rownames(dane2)
z <- sample.split(Y, SplitRatio = 4/5)
z
dane_tren <- dane2[z==TRUE,]
dane_test <- dane2[z==FALSE,]

##### 10-7 #####
dane_tren_meanrain <-dane_tren$MEAN.ANNUAL.RAINFALL
dane_test_meanrain <-dane_test$MEAN.ANNUAL.RAINFALL
dane_tren_macierz <- as.matrix(dane_tren[,-11])
dane_test_macierz <- as.matrix(dane_test[,-11])
str(dane_tren_macierz)
str(dane_test_macierz)
is.matrix(dane_tren_macierz)
is.matrix(dane_test_macierz)

##### 10-8 #####
library(GGally)
#ggpairs(dane2)

##### 10-9 #####
dane_cor <- cor(dane2)
dane_cor

##### 10-10 #####
library(corrplot)
#corrplot(dane_cor)
corrplot(dane_cor, method="number", type="lower")

##### 10-11 #####  dla mean annual rainfall
dane_cor_pom <- abs(dane_cor[11,])>0.5
dane3 <- dane2[,dane_cor_pom]
dane3

##### 10-12 #####
#ggpairs(dane3)

##################################################################
##### 11-1 #####
RSMEtren <- rep(0, 8)
RSMEtest <- rep(0, 8)

j1.mod<-lm(MEAN.ANNUAL.RAINFALL~1, data=dane_tren)
j1.mod$coefficients
#mean(dane_tren_meanrain)

##### 11-2 #####
RSMEtren[1] <- sqrt(mean((dane_tren_meanrain - j1.mod$fitted.values)^2))
RSMEtren[1]

##### 11-3 #####
p1<-predict(j1.mod, dane_test)
RSMEtest[1] <- sqrt(mean((dane_test_meanrain - p1)^2))
RSMEtest[1]

##### 11-4 #####
par(mfrow=c(1,2))
plot(dane_tren_meanrain)
abline(j1.mod)
plot(dane_test_meanrain)
abline(j1.mod)

##### 11-5 #####
j2.mod<-lm(MEAN.ANNUAL.RAINFALL~ALTITUDE, data=dane_tren)
j2.mod$coefficients
RSMEtren[2] <- sqrt(mean((dane_tren_meanrain - j2.mod$fitted.values)^2))
RSMEtren[2]

##### 11-6 #####
p2<-predict(j2.mod, dane_test)
RSMEtest[2] <- sqrt(mean((dane_test_meanrain - p2)^2))
RSMEtest[2]

##### 11-7 #####
par(mfrow=c(1,2))
plot(dane_tren$ALTITUDE,dane_tren_meanrain)
abline(j2.mod)
plot(dane_test$ALTITUDE,dane_test_meanrain)
abline(j2.mod)

##### 11-8 #####
j3.mod<-lm(MEAN.ANNUAL.RAINFALL~MAX.RAINFALL, data=dane_tren)
j3.mod$coefficients
RSMEtren[3] <- sqrt(mean((dane_tren_meanrain - j3.mod$fitted.values)^2))
RSMEtren[3]

##### 11-9 #####
p3<-predict(j3.mod, dane_test)
RSMEtest[3] <- sqrt(mean((dane_test_meanrain - p3)^2))
RSMEtest[3]

##### 11-10 #####
par(mfrow=c(1,2))
plot(dane_tren$MAX.RAINFALL,dane_tren_meanrain)
abline(j3.mod)
plot(dane_test$MAX.RAINFALL,dane_test_meanrain)
abline(j3.mod)

##### 11-11 #####
j4.mod<-lm(MEAN.ANNUAL.RAINFALL~ALTITUDE+MAX.RAINFALL, data=dane_tren)
j4.mod$coefficients
RSMEtren[4] <- sqrt(mean((dane_tren_meanrain - j4.mod$fitted.values)^2))
RSMEtren[4]
summary(j4.mod)$r.squared

##### 11-12 #####
p4<-predict(j4.mod, dane_test)
RSMEtest[4] <- sqrt(mean((dane_test_meanrain - p4)^2))
RSMEtest[4]

##### 11-13 #####
library(scatterplot3d)
par(mfrow=c(1,2))
s3d<-scatterplot3d(x=dane_tren$ALTITUDE,y=dane_tren$MAX.RAINFALL,z=dane_tren_meanrain)
s3d$plane3d(j4.mod)
s3d<-scatterplot3d(x=dane_test$ALTITUDE,y=dane_test$MAX.RAINFALL,z=dane_test_meanrain)
s3d$plane3d(j4.mod)

##### 11-14 #####
par(mfrow=c(1,2))
barplot(RSMEtren, xlab="Tren")
barplot(RSMEtest, xlab="Test")

##################################################################
##### 12-1 #####
j5.mod<-lm(MEAN.ANNUAL.RAINFALL~ALTITUDE+log(ALTITUDE)+ALTITUDE^2, data=dane_tren)
j5.mod$coefficients
RSMEtren[5] <- sqrt(mean((dane_tren_meanrain - j5.mod$fitted.values)^2))
RSMEtren[5]

##### 12-2 #####
p5<-predict(j5.mod, dane_test)
RSMEtest[5] <- sqrt(mean((dane_test_meanrain - p5)^2))
RSMEtest[5]

##### 12-3 #####
j6.mod<-lm(MEAN.ANNUAL.RAINFALL ~ MAX.RAINFALL+log(MAX.RAINFALL)+MAX.RAINFALL^2, data=dane_tren)
j6.mod$coefficients
RSMEtren[6] <- sqrt(mean((dane_tren_meanrain - j6.mod$fitted.values)^2))
RSMEtren[6]

##### 12-4 #####
p6<-predict(j6.mod, dane_test)
RSMEtest[6] <- sqrt(mean((dane_test_meanrain - p6)^2))
RSMEtest[6]

##### 12-5 #####
stepf <- step(j1.mod, direction = 'forward', scope=as.formula(lm(MEAN.ANNUAL.RAINFALL~ALTITUDE+
        MAX.RAINFALL+MEAN.CLOUD.COVER+MEAN.ANNUAL.AIR.TEMP, data=dane_tren)))

#summary(stepf)
#stepf$anova

##### 12-6 #####
j7.mod<-lm(MEAN.ANNUAL.RAINFALL~MAX.RAINFALL + MEAN.ANNUAL.AIR.TEMP + 
          MEAN.CLOUD.COVER, data=dane_tren)
j7.mod$coefficients
RSMEtren[7] <- sqrt(mean((dane_tren_meanrain - j7.mod$fitted.values)^2))
RSMEtren[7]

##### 12-7 #####
p7<-predict(j7.mod, dane_test)
RSMEtest[7] <- sqrt(mean((dane_test_meanrain - p7)^2))
RSMEtest[7]

##### 12-8 #####
jall.mod<-lm(MEAN.ANNUAL.RAINFALL~ALTITUDE + MAX.RAINFALL + 
               MEAN.CLOUD.COVER + MEAN.ANNUAL.AIR.TEMP, data=dane_tren)

stepd <- step(jall.mod, direction = 'backward')
#summary(stepd)
#stepd$anova

##### 12-9 #####
j8.mod<-lm(MEAN.ANNUAL.RAINFALL~MAX.RAINFALL + MEAN.CLOUD.COVER + MEAN.ANNUAL.AIR.TEMP, data=dane_tren)
j8.mod$coefficients
RSMEtren[8] <- sqrt(mean((dane_tren_meanrain - j8.mod$fitted.values)^2))
RSMEtren[8]

##### 12-10 #####
p8<-predict(j8.mod, dane_test)
RSMEtest[8] <- sqrt(mean((dane_test_meanrain - p8)^2))
RSMEtest[8]

RSMEtren
RSMEtest


