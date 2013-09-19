minMax <-function(serie){
  horizon.size = 24
  serie.split <- split(serie, ceiling(seq_along(serie)/horizon.size))
  
  # Define a sequence formed by the min and max points of every split
  
  min.max.serie <- NULL
  for(i in 1:length(serie.split)){
    
    split = serie.split[[i]]
    min.val <- min(split, na.rm=T)
    
    max.val <- max(split, na.rm=T)
    
    if (length(min.max.serie) > 0){
      
      min.max.serie <- c(min.max.serie, split[which(split == min.val | split == max.val)])
      
    }else{
      min.max.serie <- split[which(split == min.val | split == max.val)]
      
    }
  }
  
  
  # Select the EXTREME points (alternating MAX and MIN values) from min.max.serie
  is.extrema <- rep(F, length(min.max.serie))
  for (i in 2:(length(min.max.serie)-1)){
    
    point <- min.max.serie[i][[1]]
    
    prev.point <- min.max.serie[i-1][[1]]
    
    next.point <- min.max.serie[i+1][[1]]
    
    is.extrema[i] <- ((point > prev.point & point > next.point) |
                        
                        (point < prev.point & point < next.point)) 
  }
  # The extrema.serie is formed by the extreme points from the min.max.serie AND
  # the initial and the last points of the original serie
  extrema.serie <- c(min.max.serie[is.extrema], serie[1], serie[length(serie)])
}

geraMatrizDist <- function(){
  
  dados <- read.csv("xsys.csv")
  #fileNames <- list.files(pattern="*.csv")
  matriz <- dist(c(1:390), method = "euclidean")
  contador = 1
  
  
  for(i in 1:389){
    
    #dados <- read.csv(fileNames[i])
    #dados$CPU_UTIL <- dados$CPU_UTIL
    #serieA <- subset(dados, select = CPU_UTIL)
    #serieA <- na.omit(serieA)
    serieA <- dados[,3+i]
    serieA <- na.omit(serieA)
    serieA <- minMax(serieA)
    #serieA <- minMax(serieA)
    #serieA <- minMax(serieA)
    serieA <- ceiling(serieA)
    serieA <- (serieA - min(serieA)) / (max(serieA) - min(serieA))
    
    for(j in (i+1):390){
      
      #dados <- read.csv(fileNames[j])
      #dados$CPU_UTIL <- dados$CPU_UTIL
      #serieB <- subset(dados, select = CPU_UTIL)
      #serieB <- na.omit(serieB)
      serieB <- dados[,3+j]
      #serieB <- dados$CPU_UTIL
      serieB <- na.omit(serieB)
      serieB <- minMax(serieB)
      #serieB <- minMax(serieB)
      #serieB <- minMax(serieB)
      serieB <- ceiling(serieB)
      serieB <- (serieB - min(serieB)) / (max(serieB) - min(serieB))
      
      #matriz[contador][1] = sum(dist(serieA[1:1376], serieB[1:1376], method="DTW"))
      #contador = contador + 1
      
      if(length(serieA) < length(serieB)){
        matriz[contador][1] = sum(dist(serieA[1:length(serieA)], serieB[1:length(serieA)], method="DTW"))
        contador = contador + 1
      }else{
        matriz[contador][1] = sum(dist(serieA[1:length(serieB)], serieB[1:length(serieB)], method="DTW"))
        contador = contador + 1
      }
    }
  }
  
  grupos <- kmeans(matriz, centers = 4)
  grupos <- grupos[1]$cluster
  maquinaGrupo <- data.frame(Maq = xsys, Grupo = grupos)
  write.csv(maquinaGrupo, "maquinaGrupo.csv", row.names = F)
  
  matriz
}

matriz = geraMatrizDist()

dbscan = dbscan(matriz, eps = 1, MinPts = 1)


#Leitura dos traces
trace1 <- read.csv("xsys1.csv")
trace2 <- read.csv("xsys2.csv")
trace10 <- read.csv("xsys10.csv")
trace35 <- read.csv("xsys35.csv")
trace10$CPU_UTIL <- ceiling(trace10$CPU_UTIL)
trace35$CPU_UTIL <- ceiling(trace35$CPU_UTIL)
trace1$CPU_UTIL <- ceiling(trace1$CPU_UTIL)
trace2$CPU_UTIL <- ceiling(trace2$CPU_UTIL)
fileNames <- list.files(pattern="*.csv")

#Normalização/Eliminação de ruidos
trace1$CPU_UTIL <- ceiling(trace1$CPU_UTIL)
trace1CPU <- subset(trace1, select = CPU_UTIL)
trace1$CPU_UTIL <- (trace1$CPU_UTIL - min(na.omit(trace1CPU$CPU_UTIL)))/(max(na.omit(trace1CPU$CPU_UTIL)) - min(na.omit(trace1CPU$CPU_UTIL)))
trace2CPU <- subset(trace2, select = CPU_UTIL)
trace2$CPU_UTIL <- (trace2$CPU_UTIL - min(na.omit(trace2CPU$CPU_UTIL)))/(max(na.omit(trace2CPU$CPU_UTIL)) - min(na.omit(trace2CPU$CPU_UTIL)))

trace10$CPU_UTIL <- ceiling(trace10$CPU_UTIL)
trace10CPU <- subset(trace10, select = CPU_UTIL)
trace10$CPU_UTIL <- (trace10$CPU_UTIL - min(na.omit(trace10CPU$CPU_UTIL)))/(max(na.omit(trace10CPU$CPU_UTIL)) - min(na.omit(trace10CPU$CPU_UTIL)))
trace35$CPU_UTIL <- ceiling(trace35$CPU_UTIL)
trace35CPU <- subset(trace35, select = CPU_UTIL)
trace35$CPU_UTIL <- (trace35$CPU_UTIL - min(na.omit(trace35CPU$CPU_UTIL)))/(max(na.omit(trace35CPU$CPU_UTIL)) - min(na.omit(trace35CPU$CPU_UTIL)))


#Criação da matriz
matriz <- dist(c(1:length(fileNames)), method = "euclidean")
contador = 1
matriz[contador][1] = sum(abs(dif))
contador = contador + 1

#Dtw
install.packages("dtw")
library(dtw)
#valor <- dist(trace1$CPU_UTIL[3:3], trace2$CPU_UTIL[3:3], method="DTW")

#Dbscan
install.packages("fpc")
library("fpc")

#Agrupamento do resultado
grupo1 <- subset(res, res$Grupo == 1, select = c(Maq,Grupo))

#Clusters
grupos <- kmeans(matriz, centers = 10)
grupos <- grupos[1]$cluster
maquinaGrupo <- data.frame(Maq = fileNames, Grupo = grupos)
write.csv(maquinaGrupo, "maquinaGrupo.csv", row.names = F)