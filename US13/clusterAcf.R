clusterAcf <- function(){

	fileNames <- list.files(pattern="*.csv")

	matriz <- dist(c(1:length(fileNames)), method = "euclidean")
	contador = 1

	for(i in 1:(length(fileNames)-1)){

		dados <- read.csv(fileNames[i])
		dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
		serieA <- subset(dados, select = CPU_UTIL)
		serieA = acf(serieA, lag.max = nrow(serieA)/2, plot = FALSE, na.action = na.pass)
		serieA = serieA$acf

		for(j in (i+1):length(fileNames)){

			dados <- read.csv(fileNames[j])
			dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
			serieB <- subset(dados, select = CPU_UTIL)
			serieB = acf(serieB, lag.max = nrow(serieB)/2, plot = FALSE, na.action = na.pass)
			serieB = serieB$acf

			if(length(serieA)>length(serieB)){
				dif = serieA[1:length(serieB)] - serieB
			}else{
				dif = serieA - serieB[1:length(serieA)]
			}

			matriz[contador][1] = sum(abs(dif))
			contador = contador + 1
		}

	}

	matriz
}

clusterAcf()

dbscan(matriz, eps = 1, MinPts = 1)