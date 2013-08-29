clusterDist <- function(){

	fileNames <- list.files(pattern="*.csv")

	matriz <- dist(c(1:length(fileNames)), method = "euclidean")
	contador = 1

	for(i in 1:(length(fileNames)-1)){

		dados <- read.csv(fileNames[i])
		dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
		serieA <- subset(dados, select = CPU_UTIL)
        serieA <- na.omit(serieA)
		serieA <- (serieA - min(serieA$CPU_UTIL)) / (max(serieA$CPU_UTIL) - min(serieA$CPU_UTIL))

		for(j in (i+1):length(fileNames)){

			dados <- read.csv(fileNames[j])
			dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
			serieB <- subset(dados, select = CPU_UTIL)
            serieB <- na.omit(serieB)
			serieB <- (serieB - min(serieB$CPU_UTIL)) / (max(serieB$CPU_UTIL) - min(serieB$CPU_UTIL))

			if(length(serieA$CPU_UTIL)>length(serieB$CPU_UTIL)){
				dif = serieA$CPU_UTIL[1:length(serieB)] - serieB$CPU_UTIL
			}else{
				dif = serieA$CPU_UTIL - serieB$CPU_UTIL[1:length(serieA)]
			}

			matriz[contador][1] = sum(abs(dif))
			contador = contador + 1
		}

	}

	grupos <- kmeans(matriz, centers = 10)
	grupos <- grupos[1]$cluster
	maquinaGrupo <- data.frame(Maq = fileNames, Grupo = grupos)
	write.csv(maquinaGrupo, "maquinaGrupo.csv", row.names = F)

	matriz
}


matriz = clusterDist()

library("fpc")
dbscan(matriz, eps = 140, MinPts = 1, method = "dist")


# codigo para execução a partir da matriz de retorno
grupos <- kmeans(matriz, centers = 10)
grupos <- grupos[1]$cluster
fileNames <- list.files(pattern="*.csv")
maquinaGrupo <- data.frame(Maq = fileNames, Grupo = grupos)
write.csv(maquinaGrupo, "maquinaGrupo.csv", row.names = F)