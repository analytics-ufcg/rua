#393 colunas [4:393]
#ncol nrow

dados <- read.csv("xsys.csv")
tamanho <- nrow(dados)
df <- list()

encontra.limite.superior<- function(inicio, fim, limite){
  for(contador in c(inicio:fim)){
    if(max(dados[contador], na.rm=TRUE)>=limite){
      temp <- subset(dados, dados[contador]>=limite, select=c(names(dados[1]), names(dados[2]), names(dados[3]), names(dados[contador])))
      nome = paste(paste("coluna", contador, sep=""),".csv", sep="")
      write.csv(temp, nome)
      lista<-c(names(dados[contador]),((nrow(temp)/tamanho)*100))
      df<-rbind(df,lista)
  }
 }
  colnames(df) = c("Maquina", "Porcentagem")
  write.csv(df, "Porcentagem_dos_100.csv", row.names=F, quote=F)
}

encontra.limite.superior(4,393,100)