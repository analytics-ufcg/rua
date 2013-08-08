# Gráficos de utilização de memória e autocorrelação
for(i in (1:40)){
  dados <- read.csv(paste("C:/Users/Rodolfo/Desktop/dados/xsys", i,".csv", sep=""))
  png(paste("C:/Users/Rodolfo/Desktop/dados/xsys", i,".png", sep=""), width=1200,height=600)
  
  par(mfrow = c(1,2))
  plot(((dados$MEM_UTIL/dados$PHYS_MEM)*100), type="l" ,ylab="Utilização de Memoria em %", xlab = "Tempo", main="Utilização de Memória", ylim=c(0,100))
# plot((ceiling((dados$MEM_UTIL/dados$PHYS_MEM)*100)), type="l" ,ylab="Utilização de Memoria em %", xlab = "Tempo", main="Utilização de Memória", ylim=c(0,100))
  acf(na.omit(dados$MEM_UTIL), lag.max=(length(dados$MEM_UTIL))/2, main="Autocorrelação", ylim=c(-1, 1))
  
  dev.off()
}


# Gráficos de utilização de CUP e autocorrelação
for(i in (1:40)){
  dados <- read.csv(paste("C:/Users/Rodolfo/Desktop/dados/xsys", i,".csv", sep=""))
  png(paste("C:/Users/Rodolfo/Desktop/dados/xsys", i,".png", sep=""), width=1200,height=600)
  
  par(mfrow = c(1,2))
  plot(((dados$MEM_UTIL/dados$PHYS_MEM)*100), type="l" ,ylab="Utilização de CPU em %", xlab = "Tempo", main="Utilização de Memória", ylim=c(0,100))
  # plot((ceiling((dados$MEM_UTIL/dados$PHYS_MEM)*100)), type="l" ,ylab="Utilização de CPU em %", xlab = "Tempo", main="Utilização de Memória", ylim=c(0,100))
  acf(na.omit(dados$MEM_UTIL), lag.max=(length(dados$MEM_UTIL))/2, main="Autocorrelação", ylim=c(-1, 1))
  
  dev.off()
}
