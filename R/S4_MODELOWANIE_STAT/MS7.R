#1
library(ggplot2)
data(diamonds)

#2 
#class(diamonds)
summary(diamonds)
str(diamonds)

#3
hist(diamonds$price)

ggplot(diamonds, aes(x=price)) + 
  geom_histogram()
mean(diamonds$price)
median(diamonds$price)

#4
sum(diamonds$price>10000)

#5 ?
library(mosaic)
mean(price~clarity, data=diamonds) #mosaic::

#6
ggplot(diamonds, aes(x=price/carat)) + 
  geom_boxplot() +
  facet_wrap(diamonds$color)

#7
ggplot(diamonds, aes(x=price)) + 
  geom_boxplot() +
  facet_wrap(diamonds$clarity)

#8
ggplot(diamonds, aes(x=carat, y=price)) +
  geom_jitter()

#9
diamonds2<-mutate(diamonds, log(carat), log(price))
diamonds2<-rename(diamonds2, log_carat=`log(carat)`)
diamonds2<-rename(diamonds2, log_price=`log(price)`)
ggplot(diamonds2, aes(x=log_carat, y=log_price)) +
  geom_jitter()

#10
model1<-lm(log_price~log_carat, diamonds2)
model1
summary(model1)

ggplot(diamonds2, aes(x=log_carat, y=log_price)) +
  geom_jitter() +
  geom_smooth(method='lm', formula=y~x)

#11
model2<-lm(log_price~color+cut, diamonds2)
model2











