library(ncdf4)
library(dplyr)
library(sp)

#setwd("D:Zadania_AGH/5_MDP")

nc<-nc_open("GEBCO_11_Oct_2022_2a38cd492539/gebco_2022_n46.9325_s40.4835_w29.3643_e36.0549.nc")
print(nc)

elev <- ncvar_get(nc, "elevation")
lon <- ncvar_get(nc, "lon")
lat <- ncvar_get(nc, "lat")

length(elev)
length(lon)
length(lat)

cartesian_product<- expand.grid(lon,lat)
cartesian_product<- dplyr::mutate(cartesian_product, c(elev) )

colnames(cartesian_product)<-c("x","y", "z")
cartesian_product <- dplyr::filter(cartesian_product, y>43.1 & y<43.9 & x>34 & x<35)
coordinates(cartesian_product) <- c("x", "y")

proj4string(cartesian_product) <- CRS("+proj=longlat +datum=WGS84")
cartesian_product <- spTransform(cartesian_product, CRS("+proj=utm +zone=36 ellps=WGS84"))#tu moze byc inne
cartesian_product<-as.data.frame(cartesian_product)
cartesian_product<-dplyr::mutate(cartesian_product, id=1:nrow(cartesian_product))
cartesian_product

cartesian_product3 <-cartesian_product
cartesian_product3<-dplyr::select(cartesian_product3, c(3,2,1,4))
write.table(x=cartesian_product3, file = "gebco2022_1.csv", sep=" ", row.names = F, col.names = F )
nc_close(nc)