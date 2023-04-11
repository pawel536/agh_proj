#install.packages("readr")
#install.packages("readxl")
#install.packages("lubridate")

#(readr)
#library(readxl)
#library(lubridate)

today<-Sys.Date()
today
unclass(today)
today
now<-Sys.time()
now
Sys.timezone()

as.Date('1915-6-16')
str1<-"2020-11-03"
str(str1)
date1<-as.Date(str1, format="%Y-%m-%d")
str(date1)
date1

str2<- "2012-3-12 14:23:08"
time2<-as.POSIXct(str2, format="%Y-%m-%d %H:%M:%S")
time3<-as.POSIXlt(str2, format="%Y-%m-%d %H:%M:%S")

typeof(time2)
typeof(time3)
cat(time2)
unlist(time3)

today <- Sys.Date()
format(today, format="%B %d %Y")
weekdays(today)
history_date<- as.Date(-179,origin="1942-06-04")

#cw6 zad1

#a)
date1<-as.Date("30/Lipiec/2020", format="%d/%B/%Y")
date2<-as.Date("15/1/2020", format="%d/%m/%Y")
date3<-as.Date("1 Sty 20", format="%d %b %y")

#b)
day1<-as.Date("2020-10-15")
day5<-as.Date("2020/02/11",format="%Y/%d/%m")
day5-day1

#c)
bdays<-c(as.Date("1915-06-16"),as.Date("1890-02-17"),as.Date("1893-09-25"))
bnames<-c("Turkey", "Fisher", "Cramer")
names(bdays)<-bnames
weekdays(bdays)

#d)
mydate<-as.POSIXct("2020-4-19 7:01:00", format="%Y-%m-%d %H:%M:%S")

#e)
mydate<-as.Date(-179,origin="1942-06-04")

#fg)
my_fav_dates<-c(as.Date("2005-04-19 8:01:00", format="%Y-%m-%d %T"),as.Date("2006-04-19 11:01:00", 
              format="%Y-%m-%d %T"),as.Date("2008-04-19 7:01:00", format="%Y-%m-%d %T"))
difference<-diff(my_fav_dates)
mean(difference)
max(difference)
min(difference)
weekdays(my_fav_dates)

#h)
day1<-as.POSIXct("2000-11-10 12:00:00")
day2<-as.POSIXct("2020-11-10 14:00:00")
difftime(day2,day1,units="secs")

###################################
#cw6 p2

library(lubridate)
mdate<-ymd(20211109)
year(mdate)
month(mdate)
day(mdate)
mdy("11/09/21")
date2<- mdy(c(' 07/02/2016 ', '7 / 03 / 2016', ' 7 / 4 / 16 '))
date3<- ymd(c("20160724","2016/07/23","2016-07-25"))
time_date<- ymd_hms("2021-11-13 15:30:30")
wday(time_date, label=TRUE)
Sys.timezone(location = TRUE)
OlsonNames(tzdir = NULL)
with_tz(time_date, "America/Chicago")
now()
today()

#cw6 zad2

#a)
b_day<-ymd(20010307)
b_day
year(b_day)
month(b_day)
day(b_day)
leap_year(b_day)

#bc)
str1<-c("30-2020-01", "15/2020/02")
date4<-dym(str1)

#defg)
class_d_h<-now()
class_d_h

class_d_h_e<-with_tz(class_d_h, tzone ="Australia/Perth")
class_d_h_f<-force_tz(class_d_h,"Australia/Sydney") #nie zmienia godz

class_d_h
class_d_h_e
class_d_h_f

class_d_h<-class_d_h+hours(2)
class_d_h

#h)
round_date(class_d_h, unit = "hours")

#i)
date_Auckland<-ymd_hms("2020-10-10 10:10:00",tz="Pacific/Auckland")
date_Arizona<-ymd_hms("2020-10-10 10:10:00",tz="America/Phoenix")
difftime(date_Auckland,date_Arizona,units="hours")

#j)

difftime(class_d_h, ymd_hms("20010307 00:00:00"), units = "days")
weekdays(ymd("20010307"))  # 7568 DZIEN ZYCIA

#k)
data<-ymd(20211110)
format(data, format="%d %b %Y")
format(data, format="%y %m %d")
format(data, format="%Y %B %d")

