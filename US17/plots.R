#importação de pacote
library(ggplot2)
library(scales)

#função para plotar traces longos
plotsLongDistance <- function(){
  fileNames <- list.files(pattern="*.csv")
  
  for(i in fileNames){
    dados <- read.csv(i)
    nome <- paste(paste(i, sep=""), ".png", sep="")    
    dados$UTIS <- as.POSIXct(as.numeric(dados$UTIS), origin = "1960-01-01", tz = "GMT")
    png(nome)
  
    p <- ggplot(dados, aes(UTIS, CPU_UTIL/10)) + geom_line() + scale_x_datetime(labels = date_format("%d/%b")) + theme_bw() + xlab("Tempo") + ylab("Utilização de CPU da maquina")
    
    print(p)
    dev.off()
  }
}

plotsLongDistance()


dados <- read.csv("xsys.csv")
maquinas <-c("m31", "m232", "m233", "m242", "m245", "m246", "m247", "m251", "m253", "m254", "m255", "m256", "m257", "m258", "m259", "m260", "m10", "m15", "m17", "m23", "m55", "m65", "m67", "m69", "m70", "m71", "m77", "m117", "m132", "m147", "m148", "m186", "m187", "m188", "m189", "m190", "m191", "m192", "m193", "m262", "m298")

plotsShortDistance<- function(inicio, fim){
  for(contador in c(inicio:fim)){
    if(!(names(dados[contador]) %in% maquinas)){
      temp <- subset(dados, select=c(names(dados[3]), names(dados[contador])))
      colnames(temp) <- c("Epoch","pc")
      nome <- paste(paste("grafico-", names(dados[contador]), sep=""), ".png", sep="")
      png(nome)
      p <- ggplot(temp, aes(Epoch, pc))
      p <- p + geom_line()+ xlab("Tempo") + ylab(paste("Porcentagem de Utilização da ", names(dados[contador]), sep=""))
      print(p)
      dev.off()
    }
  }
}

plotsShortDistance(4, 393)


#codigo
dados <- read.csv("xsys22.csv")
dados$UTIS <- as.POSIXct(as.numeric(dados$UTIS), origin = "1960-01-01", tz = "GMT")
ggplot(dados, aes(UTIS, CPU_UTIL)) + geom_line() + scale_x_datetime(labels = date_format("%d/%b")) + theme_bw() + xlab("Tempo")+ ylab(paste("Utilização de CPU da maquina 22", sep=""))
