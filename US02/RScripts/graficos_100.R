require(ggplot2)
dados <- read.csv("xsys.csv")
maquinas <-c("m232", "m233", "m242", "m245", "m246", "m247", "m251", "m253", "m254", "m255", "m256", "m257", "m258", "m259", "m260")

graficos<- function(inicio, fim){
  for(contador in c(inicio:fim)){
    if(names(dados[contador]) %in% maquinas){
      temp <- subset(dados, select=c(names(dados[3]), names(dados[contador])))
      colnames(temp) <- c("Epoch","pc")
      valores.cem <- subset(temp, pc>=100)
      nome <- paste(paste("grafico-", names(dados[contador]), sep=""), ".png", sep="")
      png(nome)
      p <- ggplot(temp, aes(Epoch, pc))
      p <- p + geom_line()+ xlab("Tempo") + ylab(paste("Porcentagem de Utilização da ", names(dados[contador]), sep=""))
      p <- p+geom_segment(data = valores.cem, mapping = aes(x = Epoch, y = 0, xend = Epoch, yend = 100), colour="red")
      print(p)
	dev.off()
  }
 }
}

graficos(4, 393)