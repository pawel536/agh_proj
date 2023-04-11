#cw3  wstep
data<-c("K", "M", "M", "K")
factor(data, levels=c("K","M"))

##########################################################
#cw3  p1
mydata<-data.frame(x=c(11,12,14), y=c("a","b","c"), z=c(T,F,T))
mydata
class(mydata); str(mydata)
mydata$x
mydata[["x"]]; mydata[,1]
mydata[1,3]; mydata$x[[1]]
subset(mydata, subset=x<=12)  
position<-order(mydata$z)    #false 0 true 1 porzadek po indeksach najpierw f potem t
mydata[position, ]

##########################################################
#cw3  zad1
mydata<-data.frame(name=c("Mercury","Venus","Earth","Mars","Jupiter","Saturn","Uranus","Neptune"),
                   type=c(rep("Terrestial Planet", 4), rep("Gas Giant", 4)), 
                   diameter=c(0.382, 0.949, 1.000, 0.532, 11.209, 9.449, 4.007, 3.883),
                   rotation=c(58.64, -243.02, 1.00, 1.03, 0.41, 0.43, -0.72, 0.67),
                   rings=c(rep(FALSE, 4), rep(TRUE, 4)))
mydata[4,3]
mydata[["rings"]]
str(mydata)
mydata[4, ]
planets_rings<-subset(mydata, subset=rings==TRUE)
planets_rings
subset(mydata, subset=diameter<1)


#class(mydata); str(mydata)
#mydata$x
#mydata[["x"]]; mydata[,1]
#mydata[1,3]; mydata$x[[1]]
#subset(mydata, subset=x<=12)
#position<-order(mydata$z)
#mydata[position, ]

##########################################################
#cw3  p2
ankieta<-c("M", "K", "K", "M", "M")
f_ankieta<-factor(ankieta)
levels(f_ankieta)<-c("Kobieta", "Mężczyzna")
f_ankieta
summary(f_ankieta)

my_vector<-1:10
my_matrix<-matrix(1:9, ncol=3)
my_df<-mtcars[1:10,]
my_list<-list(my_vector, my_matrix, my_df)
my_list


##########################################################
#cw3  zad2
speed_factor<-factor(c("medium", "slow", "slow", "medium", "fast"), levels=c("slow","medium","fast"), ordered=TRUE)
speed_factor
summary(speed_factor)
sf2<-speed_factor[2]
sf5<-speed_factor[5]
sf2<sf5

title<-"The Shining"
actors<-c("Jack Nicholson", "Shelley Duvall", "Danny Lloyd", "Scatman Crothers", "Barry Nelson")
reviews<-factor(c("Good", "OK", "Good", "Perfect", "Bad", "Perfect", "Good"), levels = c("Bad", "OK", "Good", "Perfect"), ordered=TRUE)
mylist2<-list(title=title, actors=actors, reviews=reviews)
mylist2[[2]]
mylist2["actors"]
mylist2[[2]][2]

#datasets:: - zobacz zestawy
getwd

##########################################################
#cw3  p3
mycount<-function(x){sum(x<=15, na.rm=TRUE)}
x1<-c(2.4, 3.4, 8, 9.2, NA, 8, 29, 35 )
mycount(x1)

myequation<-function(x,y,z){
  result<-x+y^z
  print(result)
}
myequation(1,2,3)

##########################################################
#cw3  zad3
metry<-function(x){
cale<-x/0.0254
stopy<-x*3.2808
print(cale)
print(stopy)
}
x1<-c(2.4, 3.4, 8, 9.2, NA, 8, 29, 35 )
metry(x1)


weksr<-function(x){
  mean(x)
  x2<-x-mean(x, na.rm=TRUE)
  print(x)
  print(x2)
}
x1<-c(2.4, 3.4, 8, 9.2, NA, 8, 29, 35 )
mean(x1, na.rm=TRUE)
weksr(x1)

##########################################################
#cw3  p4
mtcars
summary(mtcars)
head(mtcars)


d_pogodowe<-read.delim("dane_pogodowe.txt", sep="\t", header=FALSE)
print(d_pogodowe)
colnames(d_pogodowe)<-c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII")
rownames(d_pogodowe)<-c(1955:2014)
print(d_pogodowe)
mean(d_pogodowe$VII); mean(d_pogodowe[["VII"]]); mean(d_pogodowe[,7])

#datasets::
#instalacja
#install.packages("nycflights13")
#library("nycflights13")
#nycflights13::flights

d_cars<-read.delim("cars.txt", sep=",", header=FALSE)
d_cars
colnames(d_cars)<-c("mpg", "cylinders", "cubicinches", "hp", "wewightlbs", "time-to-60", "year", "brand")
d_cars


getwd()
setwd("D:/Zadania_AGH/3_ProgR")


