library(tidyr)
library(dplyr)
library(ggplot2)


d1 <- read.table("zurowski_output_4.txt",header = TRUE, sep = ";", dec = ".")
grupowanie_normals<-kmeans(as.matrix(dplyr::select(d1, c("X_N","Y_N","Z_N"))), centers = 3, nstart=40, iter.max = 100000, algorithm="Lloyd" )
d1$clustering<- grupowanie_normals$cluster
d1<- dplyr::filter(d1, clustering==1)
d1<- dplyr::select(d1, c("X_N","Y_N","Z_N"))
d1 <- sample_n(d1, 10)

d2<-matrix(c(sum(d1$X_N^2),sum(d1$X_N*d1$Y_N),sum(d1$X_N*d1$Z_N),
                sum(d1$Y_N*d1$X_N),sum(d1$Y_N^2),sum(d1$Y_N*d1$Z_N),
                sum(d1$Z_N*d1$X_N),sum(d1$Z_N*d1$Y_N),sum(d1$Z_N^2)),nrow=3, ncol=3)
d2

ei <- eigen(d2)
p <- ei$vectors
d <- ei$values
p
d
ei$values






sm<-0
cs<-0
for( x in 1:10 ) {
  for( y in 1:10) {
    #sm += ()
  }
}


#k1 <- read.table("cebs_salt_output_0.txt",header = TRUE, sep = ";", dec = ".")
#grupowanie_normals<-kmeans(as.matrix(dplyr::select(k1, c("X_N","Y_N","Z_N"))), centers = 3, nstart=40, iter.max = 100000, algorithm="Lloyd" )
  #k1$clustering<- grupowanie_normals$cluster
#write.table(k1, "cebs_salt_output_1.txt", sep = ";", dec = ".",
  #row.names = FALSE, col.names = TRUE, quote = FALSE)

triangles <- read.table("cebs_salt_output_1.txt",header = TRUE, sep = ";", dec = ".")
grid <- read.table("cebs_salt_grid_6000.txt",header = TRUE, sep = ";", dec = ".")
gmerged <- merge(x = grid, y = triangles, by = c("IDT1", "IDT2", "IDT3"), all.y = TRUE)
palkmeans3<- c("green", "blue","pink")
ggplot(gmerged, aes(x=py, y=px, col=factor(clustering) )) + #, 
   geom_point() + scale_color_manual("Cluster", values = palkmeans3) + theme(aspect.ratio = 1)
# geom_point(size=0.04) +
a<-sum(is.na(gmerged$px))
b<-sum(!is.na(gmerged$px))
library(scales)
b
a+b
percent((b/(a+b)), accuracy = 0.01) #jak to liczyc - powtarzalnosc obserwacji




e<-matrix(c(1,2,3,4,5,6), nrow=3)
f<-matrix(c(3,4,5,6,7,8), nrow=3)
merge(e,f,by=c("V2"),all=FALSE)
merge(e,f,by=c("V2"),all.x=TRUE)
merge(e,f,by=c("V2"),all.y=TRUE)
merge(e,f,by=c("V2"),all=TRUE)