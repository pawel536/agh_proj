##### 1 #####
dane<-read.delim("choroby_serca.txt", header=TRUE) #dane
head(dane)
dane

# Utwórz macierz wykresów rozrzutu (scatterplot matrix) i macierz korelacji 
# dla wszystkich zmiennych w zestawie danych.

plot(dane)
pairs(dane[,1:3], pch = 19, lower.panel = NULL)
round( cor(dane) , 3 )  #cor(dane$rower, dane$palenie)

# a. Przeanalizuj wspó³czynnik korelacji pomiêdzy zmiennymi niezale¿nymi. 
# Czy nie s¹ one zbyt silnie skorelowane?
# wynik 0.015, prawie brak korelacji, wiêc jest ok

# b. Czy zale¿noœæ pomiêdzy zmiennymi niezale¿nymi a 
# zmienn¹ zale¿n¹ ma charakter liniowy? Tak, z wykresu
  
##### 2 #####
d.mod<-lm(choroby~rower+palenie, data=dane)
d.mod
summary(d.mod)

##### 3 #####
#a
#wartosc p mniejsza od 0.05 wiec hipoteze zerowa mozna odrzucic

#b
summary(d.mod)$coefficients[2] #dla row spadek 0.2
summary(d.mod)$coefficients[3] #dla pal wzrost 

#c
deviance(d.mod) #RSS
sum(resid(d.mod)^2) #tak¿e RSS
summary(d.mod)$sigma #RSE
summary(d.mod)$r.squared #R^2

##### 4 #####
#R<-d.mod$residuals #residuals(d.mod)
#plot(dane$choroby, R, pch=20, col=rgb(0.1, 0.2, 0.8, alpha=0.3),
#     main="Residual plot")
#abline(h=0)

library(lmtest)
gqtest(d.mod)
gqtest(d.mod, order.by= ~palenie+rower, data = dane)
plot(d.mod, 3)

# hipoteza zerowa: równoœæ wariancji
# Jeœli p val < 0.05 to nie ma równoœci wariancji, inaczej równoœæ wariancji ?!

#zalozenie homoscedantycznosci spelnione

##### 5 #####
F<-d.mod$fitted.values #fitted(d.mod)
F
abs( round( F - dane$choroby , 1 ) )

de <-data.frame(fitted = fitted(d.mod), choroby = dane$choroby, roznica = abs(fitted(d.mod)-dane$choroby))
de
mean(de$roznica)

##### 6 #####
a<-summary(d.mod)$coefficients[1]
b<-summary(d.mod)$coefficients[2]
c<-summary(d.mod)$coefficients[3]
a+20*b+5*c
a+2*b+30*c

#albo

df <- data.frame(palenie=c(5,30), rower=c(20,2))
predict(d.mod, df)

##### 7 #####
library(ggiraph)
library(ggplot2)
library(ggiraphExtra)
library(plyr)
ggPredict(d.mod,interactive=TRUE)  #colorAsFactor =TRUE
