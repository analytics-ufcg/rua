#split para 2 partes
files <- c(2, 5, 6, 14, 18, 25, 27, 29, 31, 1, 10, 11, 13, 15, 16, 17, 19, 20, 21, 22, 23, 24, 26, 28, 30, 35, 36, 4, 40, 8)
file_names <- paste("xsys", files, ".csv", sep="")
limits <- c(30, 10, 10, 0, 8 , 3.5, 0 , 3.5, 11, 0, 0, 0, 0, 0, 10, 0, 1.5, 0, 0, 0, 0, 5, 3, 3, 0.0, 3.9, 3.9, 0, 0, 15)

for(i in 1:length(file_names)){
     
     dff<- read.csv(file_names[i])
     
     
     g1 <- subset(dff, dff[,4] > limits[i])
     g2 <- subset(dff, dff[,4] <  limits[i])
	 
	 if(nrow(g2) > 0){
		write.csv(g1, paste("trace", files[i],"A.csv", sep = ""))
		write.csv(g2, paste("trace", files[i],"B.csv", sep = ""))
	 }
}


#split para 3 partes
files <- c(9, 32, 33)
file_names <- paste("xsys", files, ".csv", sep="")
limits <- c(20, 7, 7.5)
limits2 <- c(10, 6, 7)

for(i in 1:length(file_names)){
     
     dff<- read.csv(file_names[i])
     
     g1 <- subset(dff, dff[,4] > limits[i])
     g2 <- subset(dff, dff[,4] <=  limits[i] & dff[,4] >=  limits2[i])
     g3 <- subset(dff, dff[,4] <  limits2[i])
	 
	 write.csv(g1, paste("trace", files[i],"A.csv", sep = ""))
	 write.csv(g2, paste("trace", files[i],"B.csv", sep = ""))
	 write.csv(g3, paste("trace", files[i],"C.csv", sep = ""))	 
}
