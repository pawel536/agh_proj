#c1
x<-seq(-2,2,0.01)
ggplot()+
  geom_line(aes(x=x, y=dnorm(x)), size=1, color = "red") +
  labs(x="x", y="Gêstosc prawd. rozkl norm")

#c2
#x<-seq(-2,2,0.01)
ggplot()+
  geom_line(aes(x=x, y=pnorm(x)), size=1, color = "red") +
  labs(x="x", y="Dystrybuanta rozkl norm")

#c3
y<-c(runif(5))

#c4
#y2<-punif(0.5, 0, 1)
y2<-punif(0.5)

#c5
#y3<-dunif(0.5, 0, 1)
y3<-dunif(0.5)


#c6
library(sp)
ph_dane<-readRDS("gleby.rds")
ph_df<-as.data.frame(ph_dane)
ph_df<-na.omit(ph_df)
ph_df

w<-ecdf(ph_df$pH)
plot(w)

#c7
shapiro.test(ph_df$pH)

#c8
z<-rnorm(1000,mean=0,sd=1)
shapiro.test(z)
ks.test(z,pnorm,alternative="two.sided")   #,alternative="two.sided"
