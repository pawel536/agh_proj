library(tidyr)
library(dplyr)
library(ggplot2)

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