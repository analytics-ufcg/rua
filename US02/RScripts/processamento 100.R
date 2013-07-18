#393 colunas [4:393]
#ncol nrow

dados <- read.csv("xsys.csv")

encontra.limite.superior<- function(inicio, fim, limite)
for(contador in c(inicio:fim)){
  if(max(dados[contador], na.rm=TRUE)>=limite){
    temp <- subset(dados, dados[contador]>=limite, select=c(names(dados[1]), names(dados[2]), names(dados[3]), names(dados[contador])))
    nome = paste(paste("coluna", contador, sep=""),".csv", sep="")
    write.csv(temp, nome)
  }
}

encontra.limite.superior(4,393,100)