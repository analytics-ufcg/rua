require(ggplot2)
dados <- read.csv("xsys.csv")
maquinas <-c("abchlp557", "abchlp558", "abchlp579", "abchlp582", "abchlp583", "abchlp584", "abchlp750", "abchlp752", "abchlp753", "abchlp754", "abchlp755", "abchlp756", "abchlp757", "abchlp758", "abchlp759")

graficos<- function(inicio, fim){
  for(contador in c(inicio:fim)){
    if(names(dados[contador]) %in% maquinas){
      temp <- subset(dados, select=c(names(dados[3]), names(dados[contador])))
      colnames(temp) <- c("Epoch","pc")
      valores.cem <- subset(temp, pc>=100)
      nome <- paste(paste("grafico-", names(dados[contador]), sep=""), ".png", sep="")
      png(nome)
      p <- ggplot(temp, aes(Epoch, pc))
      p <- p + geom_line()+ xlab("Tempo") + ylab("Utilização da maquina(%)")
      p <- p+geom_segment(data = valores.cem, mapping = aes(x = Epoch, y = 0, xend = Epoch, yend = 100), colour="red")
      print(p)
	dev.off()
  }
 }
}

graficos(4, 393)