require(ggplot2)
dados <- read.csv("xsys.csv")
maquinas <-c("m10", "m15", "m17", "m23", "m55", "m65", "m67", "m69", "m70", "m71", "m77", "m117", "m132", "m147", "m148", "m186", "m187", "m188", "m189", "m190", "m191", "m192", "m193", "m262", "m298")

graficos<- function(inicio, fim){
  for(contador in c(inicio:fim)){
    if(names(dados[contador]) %in% maquinas){
      temp <- subset(dados, select=c(names(dados[3]), names(dados[contador])))
      colnames(temp) <- c("Epoch","pc")
      valores.nan <- subset(temp, is.na(pc))
      temp[is.na(temp)] <- 100
      nome <- paste(paste("grafico-", names(dados[contador]), sep=""), ".png", sep="")
      png(nome)
      p <- ggplot(temp, aes(Epoch, pc))
      p <- p + geom_line()+ xlab("Tempo") + ylab(paste("Porcentagem de Utilização da ", names(dados[contador]), sep=""))
      p <- p+geom_segment(data = valores.nan, mapping = aes(x = Epoch, y = 0, xend = Epoch, yend = 100), colour="red")
      print(p)
	dev.off()
  }
 }
}

graficos(4, 393)