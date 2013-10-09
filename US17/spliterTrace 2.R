#split para 2 partes
files <- c("6B", "9A", "18B", "31A", "33B")
file_names <- paste("trace", files, ".csv", sep="")
limits <- c(2, 27, 4, 11.8, 7.2)

for(i in 1:length(file_names)){
     
     dff<- read.csv(file_names[i])
          
     g1 <- subset(dff, dff[,4] > limits[i])
     g2 <- subset(dff, dff[,4] < limits[i])
	 
	 if(nrow(g2) > 0){
		write.csv(g1, paste("trace", files[i],"A.csv", sep = ""), row.names = F)
		write.csv(g2, paste("trace", files[i],"B.csv", sep = ""), row.names = F)
	 }
}

