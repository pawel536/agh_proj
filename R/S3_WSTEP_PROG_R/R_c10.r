library(tidyverse)
library(ggplot2)
library(ggthemes)


#cw10 zad 1

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=as.factor(Species))) +
  geom_point(alpha=0.5, shape=12) + geom_jitter(width=0.2)

# ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
# (alpha = 0.5, position=position_jitter(width=0.2), shape=12)

ggplot(data=iris,aes(Sepal.Length,..density..)) + geom_histogram(binwidth=1,fill="blue")

ggplot(iris, aes(x=Sepal.Length,fill=Species)) +
  geom_histogram(binwidth = 0.5, alpha=0.2, position="identity")

ggplot(iris, aes(x=Sepal.Length,fill=Species)) +
  geom_histogram(binwidth = 0.5, alpha=0.2, position = "fill")

ggplot(iris, aes(x=Sepal.Length,fill=Species)) +
  geom_bar(position="fill") + scale_fill_brewer()

#cw10 p 2

ir_pl<-ggplot(iris, aes(Sepal.Width, fill = Species)) +
  geom_bar(position = "fill") + scale_fill_brewer()

ir_pl

ir_pl + theme(legend.position="bottom")

ir_pl + theme(legend.position=c(0.8, 0.7))

ir_pl + theme_dark()

ir_pl + ggtitle("Iris plot") +
  theme(
    rect = element_rect(fill = "light blue"),
    #legend.key = element_rect(color = "light yellow"),
    axis.text=element_text(color="dark blue"),
    plot.title=element_text(size=16, face="italic", color="dark blue"),
    legend.margin=margin(10, 30, 20, 20, "pt")
  )

ir_pl + theme_void()
#ggplot2 - complete themes

#cw10 zad 2
mtcars

w1<-ggplot(mtcars, aes(wt, mpg, color = cyl)) + geom_point() +
  ggtitle("Scatter plot") + ylab("Miles per gallon") + xlab("WT") +
  theme(
    axis.title.y = element_text(size=14,color="#993333",face="bold"),
    axis.title.x = element_text(size=14,color="blue",face="bold"),
    plot.background = element_rect(fill = "lightblue"),
    plot.title=element_text(size=14, face="italic", color="red"),
    panel.background = element_rect(fill = "lightyellow", color = "gray"),
  )
  
w1

w1 + theme_economist_white()

#cw10 p 3



#cw10 zad 3

mpg_mean<-mean(mtcars$mpg)
mpg_median<-median(mtcars$mpg)
ggplot(mtcars,aes(x=qsec,y=mpg,color=am))+geom_point() +
  geom_hline(yintercept=mpg_median, color="black", linetype=4) +
  geom_hline(yintercept=mpg_mean, color="green", linetype=4)
