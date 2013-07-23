dados <- read.csv("xsys.csv")
maquinas <-c("m31", "m232", "m233", "m242", "m245", "m246", "m247", "m251", "m253", "m254", "m255", "m256", "m257", "m258", "m259", "m260", "m10", "m15", "m17", "m23", "m55", "m65", "m67", "m69", "m70", "m71", "m77", "m117", "m132", "m147", "m148", "m186", "m187", "m188", "m189", "m190", "m191", "m192", "m193", "m262", "m298")

graficos<- function(inicio, fim){
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

graficos(4, 393)

#plot(temp, xlab("Época"), ylab=("Utilização da maquina(%)"))

