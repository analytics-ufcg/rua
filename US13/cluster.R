#Clusterizacao com metrica DTW
cluclusterDTW <- function(){
  fileNames <- list.files(pattern="*.csv")  
  grupo <- c()
  resto <- c()
  while(TRUE){
    if(length(fileNames) <= 1){
      if(length(fileNames) == 1){
        print(fileNames)
      }
      break
    }
    grupo[1] <- fileNames[1]
    for(i in 2:(length(fileNames))){
      if(distDTW(fileNames[1], fileNames[i], 2016)){
        grupo[length(grupo) + 1] <- fileNames[i]
      }else{
        resto[length(resto) + 1] <- fileNames[i]
      }
    }
    print(grupo)
    fileNames <- resto
    grupo <- c()
    resto <- c()
  }
}


#distancia com DTW
library("dtw")
distDTW <- function(arquivo1, arquivo2, memoria){
  arq1 = arquivo1
  arq2 = arquivo2
  mem = memoria
  
  serieA <- read.csv(arq1)
  serieB <- read.csv(arq2)
  
  if(nrow(serieA)>nrow(serieB)){
    serieA <- read.csv(arq2)
    serieB <- read.csv(arq1)
  }
  
  serieA <- subset(serieA, selec = CPU_UTIL)
  serieA$CPU_UTIL <- ceiling(serieA$CPU_UTIL)
  serieB <- subset(serieB, selec = CPU_UTIL)
  serieB$CPU_UTIL <- ceiling(serieB$CPU_UTIL)
  
  posIni = 1
  continuar = TRUE
  pontoPos = 0
  pontoNeg = 0
  
  while(continuar){
    posFin = 0
    if(posIni + mem >= nrow(serieA)){
      posFin = nrow(serieA)
      continuar = FALSE
    }else{
      posFin = posIni + mem
    }
    
    valores <- data.frame(CPU_UTIL = c(posIni:posFin))
    valores$CPU_UTIL <- serieA[posIni:posFin,]
    valores$CPU_UTIL2 <- serieB[posIni:posFin,]
    matrizDist <- dist(na.omit(valores), method = "DTW")
    
    if((is.na(mean(matrizDist)) || mean(matrizDist) >= 1) && (is.na(median(matrizDist)) || median(matrizDist) >= 1)){
      pontoNeg = pontoNeg + 1
    }else{
      pontoPos = pontoPos + 1
    }
    
    posIni = posFin + 1
  }
  
  #print(pontoPos)
  #print(pontoNeg)
  if(pontoNeg == 0){
    TRUE
  }else{
    FALSE
  }
  
}


#Clusterizacao com metrica Minkowski
cluster <- function(){
    fileNames <- list.files(pattern="*.csv")	
    grupo <- c()
	resto <- c()
	while(TRUE){
	    if(length(fileNames) <= 1){
                if(length(fileNames) == 1){
		        print(fileNames)
                }
		    break
		}
		grupo[1] <- fileNames[1]
		for(i in 2:(length(fileNames))){
			if(distMinkowski(fileNames[1], fileNames[i], 2016)){
			    grupo[length(grupo) + 1] <- fileNames[i]
			}else{
			    resto[length(resto) + 1] <- fileNames[i]
			}
		}
		print(grupo)
		fileNames <- resto
		grupo <- c()
		resto <- c()
	}
}

#distancia com minkowski
distMinkowski <- function(arquivo1, arquivo2, memoria){
	arq1 = arquivo1
	arq2 = arquivo2
	mem = memoria

	serieA <- read.csv(arq1)
	serieB <- read.csv(arq2)

	if(nrow(serieA)>nrow(serieB)){
		serieA <- read.csv(arq2)
		serieB <- read.csv(arq1)
	}

	serieA <- subset(serieA, selec = CPU_UTIL)
	serieA$CPU_UTIL <- ceiling(serieA$CPU_UTIL)
	serieB <- subset(serieB, selec = CPU_UTIL)
	serieB$CPU_UTIL <- ceiling(serieB$CPU_UTIL)

	posIni = 1
	continuar = TRUE
	pontoPos = 0
	pontoNeg = 0

	while(continuar){
		posFin = 0
		if(posIni + mem >= nrow(serieA)){
			posFin = nrow(serieA)
			continuar = FALSE
		}else{
			posFin = posIni + mem
		}

		valores <- data.frame(CPU_UTIL = c(posIni:posFin))
		valores$CPU_UTIL <- serieA[posIni:posFin,]
		valores$CPU_UTIL2 <- serieB[posIni:posFin,]
		matrizDist <- dist(na.omit(valores), method = "minkowski")

		if((is.na(mean(matrizDist)) || mean(matrizDist) >= 1) && (is.na(median(matrizDist)) || median(matrizDist) >= 1)){
			pontoNeg = pontoNeg + 1
		}else{
			pontoPos = pontoPos + 1
		}

		posIni = posFin + 1
	}

	#print(pontoPos)
	#print(pontoNeg)
	if(pontoNeg == 0){
	    TRUE
	}else{
	    FALSE
	}

}

cluster()

distMinkowski("filesInput/xsys1.csv", "filesInput/xsys2.csv", 2016)
