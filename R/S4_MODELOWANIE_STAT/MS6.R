#1
library(MASS)
data(survey)
survey
surv_age<-survey$Age
surv_age<-na.omit(surv_age)
surv_age
n<-length(surv_age)
n
x<-mean(surv_age)
x
sd2<-sd(surv_age)
sd2

#2
e<-qnorm(0.975)*sd2/sqrt(n)
przedzial2<-c(x-e,x+e)
przedzial2

#3
sd3<-7
e<-qnorm(0.975)*sd3/sqrt(n)
przedzial3<-c(x-e,x+e)
przedzial3

#4 
t<-t.test(surv_age) #odczytujemy wartosci
t$estimate
t$conf.int
(t$conf.int[2]-t$conf.int[1])/2

#5
vec <- rep(0, 1000)
for( i in 1:1000 ) {
  vec[i]<-mean(rnorm(5, mean=10, sd=sqrt(3)))
}
hist(vec)

#6
vec <- rep(0, 1000)
for( i in 1:1000 ) {
  vec[i]<-mean(rnorm(100, mean=10, sd=sqrt(3)))
}
hist(vec)
 
#porownanie: kszta³t obu histogramów jest podobny, jednak dla wiêkszej iloœci wylosowanych próbek 
# przedzia³y histogramu maj¹ wê¿szy zakres (przy jednakowej iloœci przedzia³ow)

#7
dane<-read.delim("szczury.txt", header=FALSE)
szcz<-unlist(dane, use.names = FALSE)
szcz
wyn<-rep(0,times=1000)

for (i in 1:1000) {
  s<-sample(szcz, replace = TRUE)
  wyn[i]=mean(s)
}

#8
mean(wyn)

#9
hist(wyn)





