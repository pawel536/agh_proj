#cw2 zad1
a<-15
a
b<-c(4,7,10,15,24)
b
b/2
c<-c(4.6,8,10.1,9)
d<-c(7.9,2.1,8,12.5)
suma_cd<-c+d
iloraz_cd<-d/c
d%%3
c[4]
d[3:5]

#cw2 zad2
zmienna_numeric<-42.8
zmienna_character<-"data science"
zmienna_logical<-FALSE
class(zmienna_numeric)
class(zmienna_character)
class(zmienna_logical)
zmienna_numeric_int <- as.integer(zmienna_numeric)
class(zmienna_numeric_int)
zmienna_numeric_int

#cw2 zad3
napiwki_vector<-c(140,50,20,120,240)
dni_vector<-c("pon", "wt", "sr", "czw", "pt")
names(napiwki_vector)<-dni_vector
napiwki_vector
napiwki_wt_czw<-napiwki_vector[c(2,4)]
napiwki_wt_czw

?mean
?sd
mean(napiwki_vector)
sd(napiwki_vector)

napiwki_vector>100
sum(napiwki_vector>100)

x3<-c(5, 8, NA, 91, 3, NA, 14, 30, 100)
sum(x3); mean(x3)
mean(x3, na.rm=TRUE)

#cw2 zad4
lista_obecnosci<-c(25,30,16,20,10,21,12)
days_vector<-c("pn", "wt", "sr", "czw", "pt", "sb", "nd")
names(lista_obecnosci)<-days_vector
lista_obecnosci
lista_obecnosci["pn"]
class(lista_obecnosci)
lista_obecnosci<-as.integer(lista_obecnosci)
names(lista_obecnosci)<-days_vector
lista_obecnosci
class(lista_obecnosci)
sum(lista_obecnosci<=20)
lista_obecnosci==max(lista_obecnosci)
lista_obecnosci==min(lista_obecnosci)
mean(lista_obecnosci)
liczebnosc_grup<-c(25,30,18,20,15,21,15)
lista_obecnosci/liczebnosc_grup==1
lista_obecnosci/liczebnosc_grup<0.5

wynik<-sum(x3>15, na.rm=TRUE)
wynik

#cw2 zad5
seq(1:30);seq(30:1) #to samo
seq(from=0, to=1, by=0.25)
seq(from=20, to=5, length.out=10)
seq(from=1, to=900, along.with=0.5)
seq_along(1)
a<-rnorm(100,mean=0,sd=10)
hist(a)
rep(1:4,5)

#cw2 zad6
seq(from=-6, to=6, by=2)
seq(from=-2, to=5, length.out=15)
normal<-rnorm(1000,mean=10,sd=1)
pow<-rep(1:10,3)

#cw2 zad7
m1<-matrix(1:9, ncol=3)
m1
m2<-matrix(1:9, nrow=3)
m2
m3<-matrix(1:9, nrow=3, byrow=TRUE)
m3

a<-c(9,10,11)
b<-c(6,9,12)
c<-c(16,18,20)
mabc<-matrix(c(a,b,c), nrow=3, byrow=TRUE)
mabc
?colnames
rownames(mabc)<-c("a", "b", "c")
mabc

m11<-m1+2
m11
m21<-m2*3
m21

m1[2,3]
m1[2, ]
m1[,1]

#cw2 zad8
w1<-c(2:17)
w1
mw1<-matrix(w1, nrow=4)
mw1
mw2<-matrix(w1, nrow=4, byrow=TRUE)
mw2
mw1/3
mw1*mw2
mw1*mw2 >= 20

e<-c(460.998, 290.475, 309.306 )
f<-c(314.4, 247.9, 165.8)
mef<-matrix(c(e,f), nrow=3)
rownames(mef)<-c("ANH", "TESB", "RotJ")
colnames(mef)<-c("US", "non-US")
mef
mef[3,]
mef[1,2]

mghi<-matrix(rnorm(9, mean=6, sd=12), nrow=3, byrow=TRUE)
mghi