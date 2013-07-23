require(ggplot2)
dados <- read.csv("xsys.csv")
maquinas <-c("abcslp187", "abchlc202", "abchlc208", "abchlc217", "abchls160", "abchls800", "abcslc204", "abchlc795", "abchlp795", "abchls795", "abchlp337", "bcdhlp112", "bcdhlp234", "abchlp920", "abchlp921", "abchlp504", "abchlp505", "abchlp506", "abchlp507", "abchlp508", "abchlp509", "abchlp510", "abchlp511", "abchlp970", "abchlp249")

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
      p <- p + geom_line()+ xlab("Tempo") + ylab("Utilização da maquina(%)")
      p <- p+geom_segment(data = valores.nan, mapping = aes(x = Epoch, y = 0, xend = Epoch, yend = 100), colour="red")
      print(p)
	dev.off()
  }
 }
}

graficos(4, 393)