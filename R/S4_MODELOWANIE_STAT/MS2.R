#c1
rivers
p1<-c(sum(rivers),mean(rivers),median(rivers),var(rivers),sd(rivers),min(rivers),max(rivers))
p1

#c2
hist(rivers, breaks=20)

#c3
library(sp)

ph_dane<-readRDS("gleby.rds")
ph_dane<-na.omit(ph_dane)
class(ph_dane)
ph_dane

ph_df<-as.data.frame(ph_dane) #?
ph_df
class(ph_df)

#c4
range(ph_df$pH,na.rm=TRUE)
mean(ph_df$pH,na.rm=TRUE)
median(ph_df$pH,na.rm=TRUE)
sd(ph_df$pH,na.rm=TRUE)
IQR(ph_df$pH,na.rm=TRUE)

#c5
hist(ph_df$pH)

#c6
density(ph_df$pH, na.rm=TRUE)

#c7
boxplot(ph_df$pH, na.rm=TRUE, range=1.5)

#c8
pom<-as.vector(ph_df$pH)
pom<-na.omit(pom)
pom2<-scale(pom)
hist(pom2)

#c9
gr_dane<-read.delim("gravity.txt")
colnames(gr_dane)<-c("X", "grav_modeled", "grav_measured")
ggplot(gr_dane) +
 geom_point(aes(x=X, y=grav_measured), size=2, shape=23, color ="blue") +
 geom_line(aes(x=X, y=grav_modeled), size=2, color = "red") +
 labs(x="X [m]", y="gravity [mGal]")

#c10
diamonds
dim(diamonds)
colnames(diamonds)

#c11
library(dplyr)
d2<-diamonds %>%
  filter(carat>0.8)
d2

#c12
d2 %>%
  arrange(desc(carat))
