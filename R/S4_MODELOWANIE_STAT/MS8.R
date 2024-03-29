##### 1 #####
dane<-read.delim("dane4.txt", header=TRUE) #dane
plot(dane$X, dane$Y, pch=19, main="1 stopien" )
RSEval = c(rep(0,12))
R2val = c(rep(0,12))

##### 2 #####
d.mod<-lm(Y~X, data=dane)
d.mod
summary(d.mod)
RSEval[1]<-summary(d.mod)$sigma
R2val[1]<-summary(d.mod)$r.squared

#a. Jaki jest b��d mi�dzy prognoz� modelu a rzeczywistymi wynikami?
#RSE wynioslo 1269

#b. Podaj wyestymowane parametry
#Wyraz wolny: -1073.6
#Wsp�czynnik liniowy: 374.6
  
##### 3 #####
abline(d.mod, col='red')

##### 4 #####
for(i in 2:12) 
{
  d.mod <- lm(Y ~ poly(X,i), data=dane)
  plot(dane$X, dane$Y, pch=19, main=paste(toString(i)," stopien"))
  lines(sort(dane$X), fitted(d.mod)[order(dane$X)], col='red', type='l') 
  RSEval[i] <- summary(d.mod)$sigma #RSE
  R2val[i]<-summary(d.mod)$r.squared #R2
}

##### 5 #####
RSEval
R2val

##### 6 #####
# Na podstawie dopasowania krzywych regresji oraz obliczonych metryk z 
# �wiczenia 5 (RSE i R2) zdecyduj kt�ry model estymuj�cy wybra�by� do 
# tego zbioru zdanych. Uzasadnij odpowied�.

# Wybra�bym model wielomianowy 6 stopnia, gdy� przyjmuje on najni�sz� warto�� 
# wspolczynnika RSE ze wszystkich modeli, jego warto�� wspolczynnika R^2 jest 
# wieksza od modeli o nizszym stopniu i nieznacznie mniejsza od pozostalych
# modeli, a dopasowanie wyglada dosc dobrze po nalozeniu na wykres z danymi.