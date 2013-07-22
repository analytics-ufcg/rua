dados <- read.csv("xsys.csv")
maquinas <-c("abcslp187", "abchlc202", "abchlc208", "abchlc217", "abchlc520", "abchls160", "abchls800", "abcslc204", "abchlc795", "abchlp795", "abchls795", "abchlp337", "bcdhlp112", "bcdhlp234", "abchlp920", "abchlp921", "abchlp504", "abchlp505", "abchlp506", "abchlp507", "abchlp508", "abchlp509", "abchlp510", "abchlp511", "abchlp970", "abchlp249", "abchlp557", "abchlp558", "abchlp579", "abchlp582", "abchlp583", "abchlp584", "abchlp750", "abchlp752", "abchlp753", "abchlp754", "abchlp755", "abchlp756", "abchlp757", "abchlp758", "abchlp759")

graficos<- function(inicio, fim){
  for(contador in c(inicio:fim)){
    if(!(names(dados[contador]) %in% maquinas)){
      temp <- subset(dados, select=c(names(dados[3]), names(dados[contador])))
	colnames(temp) <- c("Epoch","pc")
      nome <- paste(paste("grafico-", names(dados[contador]), sep=""), ".png", sep="")
      png(nome)
      p <- ggplot(temp, aes(Epoch, pc))
      p <- p + geom_line()+ xlab("Tempo") + ylab("Utilização da maquina(%)")
      print(p)
	dev.off()
  }
 }
}

graficos(4, 393)

#plot(temp, xlab("Época"), ylab=("Utilização da maquina(%)"))

