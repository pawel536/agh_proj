install.packages("ggpmisc")
install.packages("fpp2")
install.packages("forecast")

#cw14 p 1
AirPassengers
str(AirPassengers)
summary(AirPassengers)

length(AirPassengers)

start(AirPassengers)
end(AirPassengers)
time(AirPassengers)
deltat(AirPassengers)
frequency(AirPassengers)
cycle(AirPassengers)
plot(AirPassengers, xlab = "Year", ylab = "Number of passengers")


miles<-c(412, 480, 683, 1052, 1385, 1418, 1634, NA, NA, 5948, 6109, 5981, 6753, 8003, 10566, 12528, 14760, 16769, 19819, 22362, 25340, 25343, 29269, 30514)
miles[8:9] <- median(miles, na.rm = TRUE)
plot(miles)
miles_ts<-ts(miles, start=1937, frequency = 1)
plot(miles_ts)
is.ts(miles_ts)
ts.plot(miles_ts, xlab="year", ylab="air passengers miles sum", main="TS plot")


library(forecast)
autoplot(AirPassengers)+
  geom_smooth()


ggplot(AirPassengers, as.numeric = FALSE) + geom_line() +
  stat_peaks(colour = "red") +
  stat_peaks(geom = "text", colour = "red",
             vjust = -0.5, x.label.fmt = "%Y") +
  stat_valleys(colour = "blue") +
  stat_valleys(geom = "text", colour = "blue", angle = 45,
               vjust = 1.5, hjust = 1, x.label.fmt = "%Y")

#cw14 zad 1

qcement
str(qcement)
summary(qcement)
length(qcement)
start(qcement)
end(qcement)
time(qcement)
deltat(qcement)
frequency(qcement)
cycle(qcement)
autoplot(qcement)+geom_smooth()


ozonet_airquality=airquality%>%
  select(Ozone,Temp)%>%
  slice(62:153)
ozonet_airquality$Ozone[is.na(ozonet_airquality$Ozone)]<-meano_a
#ozonet_airquality[c(4,11,14,22,23,41,42,46,54,58,89),1]<-median(ozonet_airquality$Ozone,na.rm=T)
ozonet_airquality<-ts(ozonet_airquality,start=start(ts(airquality)),frequency=4)
autoplot(ozonet_airquality,facets=T)


str(arrivals)
start(arrivals)
end(arrivals)
cycle(arrivals)
autoplot(arrivals)+
  geom_smooth()

#cw14 z 2

acf(qcement, lag.max = 30)
pacf(ozonet_airquality)
ggseasonplot(qcement)
ggseasonplot(qcement,col=rainbow(12))
ggsubseriesplot(qcement)


