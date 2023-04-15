library(tidyr)
library(dplyr)
#d1 <- read.table("zurowski_output_0.txt",header = TRUE, sep = ";", dec = ".")
#d2<-subset(d1, Dip_dir!="x")
#d2
#d2$Dip_dir <- as.numeric(as.character(d2$Dip_dir))
#d2

#write.table(d2, "zurowski_output_2.txt", sep = ";", dec = ".",
            #row.names = FALSE, col.names = TRUE, quote = FALSE)


d3<- read.table("zurowski_output_2.txt",header = TRUE, sep = ";", dec = ".")
xmin<-min(d3$X_C)
xmax<-max(d3$X_C)
ymin<-min(d3$Y_C)
ymax<-max(d3$Y_C)
xdiff = xmax - xmin
ydiff = ymax - ymin

d4<- subset(d3, X_C >xmin + 0.05*xdiff & X_C < xmax - 0.05*xdiff &
          Y_C >ymin + 0.05*ydiff & Y_C < ymax - 0.05*ydiff)


write.table(d4, "zurowski_output_4.txt", sep = ";", dec = ".",
            row.names = FALSE, col.names = TRUE, quote = FALSE)

#usuniecie NA z pliku, odciecie 5%