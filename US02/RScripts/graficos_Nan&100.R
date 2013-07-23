require(ggplot2)
dados <- read.csv("xsys.csv")
maquinas <-c("abchlc520")

graficos<- function(inicio, fim){
  for(contador in c(inicio:fim)){
    if(names(dados[contador]) %in% maquinas){
      temp <- subset(dados, select=c(names(dados[3]), names(dados[contador])))
      colnames(temp) <- c("Epoch","pc")
      valores.nan <- subset(temp, is.na(pc))
      valores.cem <- subset(temp, pc>=100, na.rm=TRUE)
      temp[is.na(temp)] <- 100
      nome <- paste(paste("grafico-", names(dados[contador]), sep=""), ".png", sep="")
      png(nome)
      p <- ggplot(temp, aes(Epoch, pc))
      p <- p + geom_line()+ xlab("Tempo") + ylab("Utilização da maquina(%)")
      p <- p+geom_segment(data = valores.nan, mapping = aes(x = Epoch, y = 0, xend = Epoch, yend = 100), colour="red")
      p <- p+geom_segment(data = valores.cem, mapping = aes(x = Epoch, y = 0, xend = Epoch, yend = 100), colour="blue")
      print(p)
	dev.off()
  }
 }
}

graficos(4, 393)