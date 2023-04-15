library(tidyr)
library(dplyr)
library(ggplot2)

d1 <- read.table("zurowski_output_4.txt",header = TRUE, sep = ";", dec = ".")

f1 <- function(x) sqrt(sum(x^2))

f2 <- function(tab) {
  dipa <- acos((tab[,3]))*(180/pi)
  dipd <- atan2(tab[,2], tab[,1])*180/pi
  return(cbind(dipa, dipd))
}

grupowanie_normals<-kmeans(as.matrix(dplyr::select(d1, c("X_N","Y_N","Z_N"))), centers = 3, nstart=40, iter.max = 100000, algorithm="Lloyd" )
d1$clusteringn<- grupowanie_normals$cluster
ggplot(d1, aes(x=Y_C, y=X_C, color=as.factor(clusteringn))) + geom_point()

tab_A<-grupowanie_normals$centers
tab_A[1,] <- tab_A[1,] / f1( tab_A[1,] )
tab_A[2,] <- tab_A[2,] / f1( tab_A[2,] )
tab_A[3,] <- tab_A[3,] / f1( tab_A[3,] )
f1( tab_A[1,] )

grupowanie_normals<-kmeans(as.matrix(dplyr::select(d1, c("X_D","Y_D","Z_D"))), centers = 3, nstart=40, iter.max = 100000, algorithm="Lloyd" )
d1$clusteringd<- grupowanie_normals$cluster
ggplot(d1, aes(x=Y_C, y=X_C, color=as.factor(clusteringd))) + geom_point()

tab_B<-grupowanie_normals$centers
tab_B[1,] <- tab_B[1,] / f1( tab_B[1,] )
tab_B[2,] <- tab_B[2,] / f1( tab_B[2,] )
tab_B[3,] <- tab_B[3,] / f1( tab_B[3,] )
f1( tab_B[1,] )

dA <- f2(tab_A)
tab_A
dA

dC <- dA
dC[3,2] <- dC[3,2] + 360
dC

dB<- f2(tab_B)
tab_B
dB

dD <- dB
dD[,1] <- dD[,1] - 90
dD
dD[3,2] <- dD[3,2] + 360
dD


d1 <- sample_n(d1, 5000)
df1<- dplyr::filter(d1, clusteringn==1)
df2<- dplyr::filter(d1, clusteringn==2)
df3<- dplyr::filter(d1, clusteringn==3)

write.table(dplyr::select(df1, c("Dip_dir","Dip_ang")), "zurowski_output_6na.txt", sep = ",", dec = ".",
            row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(dplyr::select(df2, c("Dip_dir","Dip_ang")), "zurowski_output_6nb.txt", sep = ",", dec = ".",
            row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(dplyr::select(df3, c("Dip_dir","Dip_ang")), "zurowski_output_6nc.txt", sep = ",", dec = ".",
            row.names = FALSE, col.names = FALSE, quote = FALSE)

df1<- dplyr::filter(d1, clusteringd==1)
df2<- dplyr::filter(d1, clusteringd==2)
df3<- dplyr::filter(d1, clusteringd==3)

write.table(dplyr::select(df1, c("Dip_dir","Dip_ang")), "zurowski_output_6da.txt", sep = ",", dec = ".",
            row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(dplyr::select(df2, c("Dip_dir","Dip_ang")), "zurowski_output_6db.txt", sep = ",", dec = ".",
            row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(dplyr::select(df3, c("Dip_dir","Dip_ang")), "zurowski_output_6dc.txt", sep = ",", dec = ".",
            row.names = FALSE, col.names = FALSE, quote = FALSE)

##### -----8----- ##### START

#tab_B <- d1 %>%
#  group_by(clustering) %>%
#  summarize(meanX <- mean(X_N), meanY <- mean(Y_N), meanZ <- mean(Z_N))

#tab_B<-as.matrix(tab_B[,2:4])
#rownames(tab_B)<-c(1,2,3)

#tab_B <- cbind( tab_B, rbind( tab_B[1,] / f1( tab_B[1,]),
#  tab_B[2,] / f1( tab_B[2,]), tab_B[3,] / f1( tab_B[3,])))

#tab_B <- cbind(tab_B, f2(tab_B[,4:6]))
#colnames(tab_B)<-c("X_N","Y_N","Z_N", "X_NU", "Y_NU", "Z_NU", "dip_ang", "dip_d")

#cbind(tab_A, dip_A)
#tab_B

##### -----8----- #####