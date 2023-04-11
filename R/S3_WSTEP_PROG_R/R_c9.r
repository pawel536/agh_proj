library(tidyverse)
library(ggplot2)
library(ggthemes)


#cw9 p1 a-c
ggplot(data=mtcars, aes(x=cyl, y=mpg)) + geom_point()
ggplot(data=mtcars, aes(x=cyl, y=mpg)) + geom_point(shape=1, size=4)
ggplot(data=mtcars, aes(x=wt, y=mpg, color=disp, size=disp)) + geom_point(alpha=0.8) + geom_smooth()

#cw9 p1 d
pl<-ggplot(mtcars, aes(wt, mpg))
pl+geom_point(aes(alpha=cyl))
pl+geom_point(aes(shape=as.factor(cyl)))+scale_x_log10()
pl+geom_text(aes(label=cyl))
pl+geom_point(aes(size=hp/wt))
dgreen<-"#013220"
pl+geom_point(color=dgreen, alpha=0.6, size=10, shape=1)
pl+geom_text(label=rownames(mtcars))

#cw9 p1 e
m_colors<-c(automatic = "#378AB1", manual = "#E2111C")
ggplot(mtcars, aes(as.factor(cyl), fill = as.factor(am))) +
  geom_bar(position="dodge") +
  labs(x = "Number of Cylinders", y = "Count")
scale_fill_manual("Type", values = m_colors)

#cw9 z1 
#a
ggplot(data=diamonds, aes(x=carat, y=price)) + geom_point() + geom_smooth(se=FALSE)

#b
ggplot(diamonds,aes(x=carat,y=price,color=clarity))+geom_point(alpha=0.5,size=3)

#c
ggplot(diamonds, aes(x=carat, y=price, color=clarity, size=cut)) + geom_point()

#d
ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + geom_point(alpha=0.5) + scale_x_log10() + scale_y_log10()

#e
ggplot(diamonds, aes(as.factor(cut), fill = clarity)) + geom_bar() + labs(x = "Cuts", y = "Count")
ggplot(diamonds, aes(as.factor(cut), fill = clarity)) + geom_bar(position="dodge") + labs(x = "Cuts", y = "Count")

#cw9 p2
ggplot(mtcars, aes(mpg, 0)) + geom_jitter(color="green") + ylim(-2,2) + xlab("Miles per gallon")
ggplot(mtcars, aes(x=mpg, y=wt, color=as.factor(cyl) )) + geom_point(size=3) + facet_wrap(~cyl) + ggtitle("Mtcars plot")
  # facet_grid / geom_wrap / facet_wrap -> wykresy macierzowe

ggplot(mtcars, aes(x=mpg, y=wt )) + geom_point() + facet_grid( cyl ~ gear)
ggplot(mtcars, aes(x=mpg, fill=factor(am))) + geom_histogram(binwidth=3) + facet_wrap(~ cyl)+
  scale_fill_brewer(type = 'qual')

p = ggplot(mtcars, aes(x=mpg, fill=factor(am))) + geom_histogram(binwidth=5)
ggsave(filename="auta.png", p)

#cw9 z2
#a
ggplot(diamonds,aes(carat,price,color=cut)) + geom_point() + facet_wrap(~clarity)

#b
ggplot(diamonds, aes(x=carat, y=price)) + geom_point() + ggtitle("Diamonds scatterplot") +
  xlab("Weight (carats)")

#c
ggplot(diamonds,aes(price,fill=factor(clarity)))+geom_histogram(binwidth=200)

#d
ggplot(diamonds, aes(x=price, color=cut)) + geom_density()

#e
ggplot(diamonds, aes(color,price))+ geom_boxplot()+ scale_y_log10()

#f
ggplot(diamonds, aes(x=price, color=cut)) + geom_density()

#g
ggplot(diamonds,aes(cut,clarity))+geom_jitter(alpha=0.03)
