library(lattice)
library(latticeExtra)
library(tidyverse)
library(ggplot2)

#cw11 p 1

str(airquality)
histogram(~ Ozone, data = airquality,
          nint=10,
          type="count")

xyplot(Ozone ~ Solar.R, data = airquality,
       main = "Air Quality",
       xlab = "Temperature (Fahrenheit)",
       ylab = "Ozone (ppb)"
)

histogram(~Ozone|factor(Month),
          data = airquality,
          layout=c(5,1),
          xlab="Ozone (ppb)")

xyplot(Ozone ~ Temp, airquality, groups = Month,
       # Complete the legend spec
       auto.key = list(space = "right",
                       title = "Month",
                       text = month.name[5:9]))

#cw11 zad 1

#a
xyplot(Sepal.Length~Petal.Length,iris,main="Iris scatterplot",xlab="Petal length",ylab="Sepal length")

#b
xyplot(Petal.Length ~ Sepal.Length,
       data = iris,
       main = "Iris scatterplot",
       xlab = "Petal length",
       ylab = "Sepal length",
       group = Species,
       auto.key = list(space="right",title="iris type")
)

#c
histogram(~Petal.Width|factor(Species),iris,layout=c(3,1),nint=15, col="darkgreen")

#d
#xyzplot(Sepal.Length ~ Petal.Width ~ Petal.Length, )
        
cloud(Petal.Length ~ Sepal.Length * Petal.Width,
      group = Species, data = iris,
      auto.key = TRUE,
      alpha=0.8,
      screen=list(x=-60,y=0,z=10)
)

#e
bwplot( ~Petal.Width | Species,  data = iris, layout = c(3, 1),
        auto.key = TRUE,
        xlab = "Petal width"
)
bwplot(~Petal.Width | Species,  data = iris,
       layout = c(3, 1), panel = panel.violin,
       xlab = "Petal width")

#f


#cw11 p 2

xyplot(rate.female ~ rate.male,
       data = USCancerRates,
       grid = TRUE, abline = c(0, 1),
       as.table=TRUE)

bwplot(~ rate.male + rate.female,
       data = USCancerRates,
       outer = TRUE,
       xlab="Rate (per 100,000)",
       strip = strip.custom(factor.levels = c("Male", "Female")),
       aspect=2)

dens_plot <- densityplot(~ rate.male + rate.female,
              data = USCancerRates, outer = TRUE,
              plot.points = FALSE, as.table = TRUE)
print(dens_plot)
update(dens_plot, xlab = "Rate")
dim(dens_plot)
dens_plot[2]


dotplot(mpg ~ hp | cyl + am, data = mtcars,
        as.table = TRUE,
        scales = list(x = list(log=TRUE)),
        par.settings = ggplot2like(),
        lattice.options = ggplot2like.opts())


plot2<-xyplot(mpg~hp|equal.count(mtcars$wt, 5), data=mtcars)
print(plot2)
plot3<-update(plot2, type=c("p","r"), pch=5)
plot(plot3)
update(plot2, pch=19, col="green")


plot3<-xyplot(mpg~hp, data=mtcars)
plot(plot3, split=c(1,1,2,1))
plot(update(plot3, col="red"), split=c(3,1,4,2), newpage=FALSE)
plot(update(plot3, col="green"), split=c(4,1,4,2),newpage=FALSE)
plot(update(plot3, col="brown"), split=c(2,2,2,2), newpage=FALSE)


plot(plot3, position=c(0,0,1,.5))
plot(update(plot3, col="red"), position=c(0.7,0.5,1,0.8), newpage=FALSE)
plot(update(plot3, col="green"), position=c(0.0, 0.5, 0.7,1),newpage=FALSE)

#cw 11 zad 2
#a
xyplot(carat~log(depth)|color,diamonds,abline=c(-1.33,0.515),layout=c(2,4),groups=color,as.table = TRUE,grid=TRUE)

#b
barchart(~carat|price,diamonds,equal.count(diamonds$price,3))


#d
histogram(~price,diamonds,nint=8, par.settings = ggplot2like())

#e 
p1<-bwplot( ~price, data = diamonds, auto.key = TRUE,
)

p2<-xyplot(carat ~ price,
           data = diamonds,
           type=c("p","smooth"),
)

p3<-cloud(price ~ carat * color,
          data = diamonds,
          auto.key = TRUE,
)

plot(update(p2, col="red"), split=c(3,1,4,2), newpage=FALSE)
plot(update(p3, col="green"), split=c(4,1,4,2),newpage=FALSE)
plot(update(p1, col="brown"), split=c(2,2,2,2), newpage=FALSE)


#f
plot(p1, position=c(0,0,1,.5))plot(update(p3, col="red"), position=c(0.7,0.5,1,0.8), newpage=FALSE)
plot(update(p2, col="green"), position=c(0.0, 0.5, 0.7,1),newpage=FALSE)


