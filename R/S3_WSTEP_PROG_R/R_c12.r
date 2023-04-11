library(lattice)
library(latticeExtra)
library(tidyverse)
library(ggplot2)

#cw11 p 1
#a
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)

plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)%>%
  add_markers()

#b
iris%>%
  filter(Species =="setosa")%>%
  plot_ly(x = ~Sepal.Width)%>%
  add_histogram(nbinsx=6, color = I("darkgreen"), opacity = 0.5)

#c
iris%>%
  plot_ly(x=~Sepal.Width, y=~Species)%>%
  add_boxplot()

#d
plot_ly(x = ~Sepal.Length, y = ~Petal.Length, data = iris,
        marker = list(size = 12,
                      color = 'rgba(255, 182, 193, .9)',
                      line = list(color = "rgba(100, 20, 20, .5)",
                                  width = 5)))%>%
  add_markers()%>%
  layout(title = "Scatterplot")

#e
iris %>%
  plot_ly(x = ~Sepal.Length, y = ~Petal.Length, color=~Species) %>%
  add_markers(colors="Dark2")


#cw12 zad 1







#cw12 p 2






#cw12 zad 2

#a
g_plot<-ggplot(data=diamonds, aes(x=cut, fill=clarity))+
  geom_bar()
ggplotly(g_plot)


#b 
iris
diamonds%>%
  filter(color>='G')%>%
  filter(color<='J')%>%
  plot_ly(x=~carat)%>%
  add_histogram(xbins = list(start=0, end=7, size=1),color=~color)


#c
linia_trendu<-lm(price~carat, data=diamonds)

diamonds%>%
  plot_ly(x=~carat,y=~price)%>%
  layout(title="Scatterplot",
         xaxis=list(title="Carats",showgrid=FALSE),
         yaxis=list(title="Prices",showgrid=FALSE),
         paper_bgcolor="#cbabba",
         plot_bgcolor="abadba")%>%
  add_markers(marker=list(opacity=0.5),
              colors="Set1")%>%
  add_lines(y=~fitted(linia_trendu))

