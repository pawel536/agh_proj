#1 
# kowariancja - nie pokazuje sily zaleznosci, jedynie jej kierunek

# korelacja - kowariancja dzielona przez odchylenia standardowe obu analizowanych zmiennych. 
# pokazuje sile zaleznosci liniowej i nalezy do predzialu [-1;1]
# bezwymiarowa

#2
library(ggplot2)
library(MASS)
data(cats)
ggplot(cats,aes(x=Bwt, y=Hwt)) + geom_point()

#3
fun_cov <- function(x, y) {
  meanx<-mean(x)
  meany<-mean(y)
  n<-length(x)
  f_sum<-0
  for(i in 1:n) {
    f_sum<-f_sum+(x[i]-meanx)*(y[i]-meany)
  }
  f_sum<-f_sum/(n-1)
  print(f_sum)
  #f_sum<-f_sum/sd(x)/sd(y)
  #print(f_sum)
}

fun_cov(cats$Bwt,cats$Hwt)

#4
cov(cats$Bwt,cats$Hwt)
cor(cats$Bwt,cats$Hwt)

#5 interpretacja - wartosc ok 0.8 - silna korelacja, dodatnia wiec wraz ze wzrostem jednej 
# wartosci druga rowniez rosnie

#6
cats.mod<-lm(Hwt~Bwt, data=cats)
cats.mod

#7 (metod = pearson)
library(dplyr)
library(ggpubr)
ggscatter(data=cats, x="Bwt", y="Hwt", add="reg.line", cor.coef=TRUE, cor.method="pearson")
