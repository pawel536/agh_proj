#cw4  p1

medium<-"UPEL"
obecnosci<-14

if(medium=="UPEL"){
  print("obecnosci UPEL")
}else if(medium=="MS TEAMS"){
  print("obecnosci TEAMS")
}else{
  print("obecnosci reszta")
}

if(obecnosci>15){
  print("B. dobra frekwencja")
}else if(obecnosci>10){
  print("dobra frekwencja")
}else{
  print("slaba frekwencja")
}


studenci.df = data.frame(imie=c("Anna","Ewa","Henryk","Jan"),
plec = c("k", "k", "m", "m"), wiek = c(21,31,29,19));
studenci.df
studenci.df$m.mlodsi=ifelse(studenci.df$plec == "m" & studenci.df$wiek <20, "T", "F")
studenci.df

##########################################################
#cw4  zad1b

v<-c(1,7,8,12,14,19)
ifelse(v%%2,"nieparzyste","parzyste")

##########################################################
#cw4  p2

v<-72
while(v>30){
  print("zwolnij")
  v<-v-7
}
v

##########################################################
#cw4  zad2
#a)

x<-0
while(x<20){
  x<-x+1
  if(x==12) next
  print(x)
}

#b)

i<-1
while(i<=10){
  print(3*i)
  if((3*i)%%8==0){
    break
  }
  i<-i+1
}
i<-i+1
i


##########################################################
#cw4  p3
linkedin<-c(16,9,13,5,2,17,14)
for(li in linkedin){
  if(li>10){
    print("nice")
  }else{
    print("slabo")
  }
}

nyc<-list(pop=8405837, boroughs = c("Manhattan","Bronx","Staten Island","Queens","Brooklyn"), capital = FALSE)

# VERSION 1

for(p in nyc){
  print(p)
}

# VERSION 2

for(i in 1:length(nyc)){
  print(nyc[[i]])
}

##########################################################
#cw4  zad3
mtcars
for(disp in mtcars$disp){
  if(disp<160){
    break
  }else{
    print(disp)
  }
}

rivers
for(riv in rivers){
  if(riv<500){
    print("krotka rzeka")
  }else if(riv>2000){
    print("dluga rzeka")
  }else{
    print(riv)
  }
}


##########################################################
#cw4  p4
m1<-matrix((1:10), nrow=5, ncol=6)
m1
a_m1<-apply(m1,2,sum)
a_m1

movies<-c("SPIDERMAN", "BATMAN", "VERTIGO", "CHINATOWN")
movies_lower<-lapply(movies,tolower)
str(movies_lower)
movies_lower<-unlist(lapply(movies,tolower))
str(movies_lower)

##########################################################
#cw4  zad4
m1<-matrix((1:30), nrow=10, ncol=3)
m1
a_m1<-apply(m1,1,sum)
a_m1

someth<-list(c(1,2,3,4,5), c(4,12,20,28,36), c(1,3,5,7,9))
someth_avg<-unlist(lapply(someth, mean))
str(someth)
someth_avg
str(someth_avg)


##########################################################
#cw4  zad5
predkosc<-64
while(predkosc>=30 && predkosc<=80){
  if(predkosc>48){
    cat("Twoja predkosc to:", predkosc, "\nzwolnij mocno\n")
    predkosc<-predkosc-11
  }else{
    cat("Twoja predkosc to:", predkosc, "\nzwolnij\n")
    predkosc<-predkosc-6
  }
}

#cw4 zad6
#w rmd
