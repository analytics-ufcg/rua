#split para 2 partes
files <- c(2, 5, 6, 14, 18, 25, 27, 29, 31, 1, 10, 13, 17, 28, 40)
file_names <- paste("xsys", files, ".csv", sep="")
limits <- c(30, 10, 10, 0, 8 , 3.5, 0 , 3.5, 11, 0, 0, 0, 0, 3, 0)

for(i in 1:length(file_names)){
     
     dff<- read.csv(file_names[i])
     
     
     g1 <- subset(dff, dff[,4] > limits[i])
     g2 <- subset(dff, dff[,4] <  limits[i])
	 
	 if(nrow(g2) > 0){
		write.csv(g1, paste("trace", files[i],"A.csv", sep = ""), row.names = F)
		write.csv(g2, paste("trace", files[i],"B.csv", sep = ""), row.names = F)
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
	 
	 write.csv(g1, paste("trace", files[i],"A.csv", sep = ""), row.names = F)
	 write.csv(g2, paste("trace", files[i],"B.csv", sep = ""), row.names = F)
	 write.csv(g3, paste("trace", files[i],"C.csv", sep = ""), row.names = F)	 
}
