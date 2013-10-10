# Função que retorna o maior valor da autocorrelação (excluindo o primeiro pico)
# Exemplo de chamada: valorAutoCorr(ceiling(data$MEM_UTIL))
# Exemplo de chamada: valorAutoCorr(ceiling(data$CPU_UTIL))
valorAutoCorr <- function(data){
  corr <- acf(data, na.action=na.pass, lag.max = length(data)/2,plot=F)
  flag = TRUE
  cont = 2
  val = corr$acf[1]
  while(flag){
    if((corr$acf[cont]<val && corr$acf[cont]>0)){
      val = corr$acf[cont]
      cont = cont + 1
    }else{
      flag = FALSE
    }
  }
  resul = corr$acf[cont:length(data)]    
  return (resul)
}


# Calcula a tendência da autocorrelação
tendencia <- function(autoCorr){
  maior = max(na.omit(autoCorr))
  menor = min(na.omit(autoCorr))
  if( (maior > abs(menor)) && (maior > 0) ) {
    return ("Positiva")
  }else{
    return ("Negativa")
  } 
}


# Calcula o grau da autocorrelação
grauAutoCorr <- function(autoCorr){
  maior = max(na.omit(autoCorr))
  menor = min(na.omit(autoCorr))
  
  if(abs(maior) > abs(menor)){
    return (abs(maior))
  }else{
    return (abs(menor))
  } 
}

#Calcula a media da autocorrela��o, as correla�oes minimas sao negativas, por isso o sinal de +
mediaAutoCor <- function(maxAutoCor, minAutoCor){
  res = maxAutoCor + minAutoCor
  return(res)
}

# Função que calcula o desvio padrão, a variância, o maior e menor valor para a autocorrelação, o grau de autocorrelação e a tendência
# Parâmetros - (diretório dos arquivos, CPU[TRUE] ou Memória[FALSE], arquivo de saída)
# Exemplo de chamada: sumarioTOarquivo("C:/Users/Lari/Desktop/RUA/filesInput/", TRUE, "C:/Users/Lari/Desktop/sumario_cpu.csv")
# Exemplo de chamada: sumarioTOarquivo("C:/Users/Lari/Desktop/RUA/filesInput/", FALSE, "C:/Users/Lari/Desktop/sumario_mem.csv")
sumarioTOarquivo <- function(diretorio, cpu, arquivo){
  df <- data.frame( maquina=rep(""), desviopadrao=rep(NA), variancia=rep(NA), max_autocorrelacao=rep(NA),min_autocorrelacao=rep(NA),grau_autocorrelacao=rep(NA), tendencia=rep(""),stringsAsFactors=FALSE, media_autocorrelacao=rep(NA)) 
  df = df[-1,]
  
  for(i in (1:40)){
    dados <- read.csv(paste(diretorio, "xsys", i,".csv", sep=""))
    
    if(cpu == TRUE){
      dados <- dados$CPU_UTIL
    }else{
      dados <- dados$MEM_UTIL
    }      
    autocorrelacao <- valorAutoCorr(ceiling(dados))
    df[i,] <- c(paste("xsys",i,sep=""), round(sd(na.omit(dados)), digits=4),
                round(var(na.omit(dados)), digits=4), 
                round(max(na.omit(autocorrelacao)), digits=4), 
                round(min(na.omit(autocorrelacao)), digits=4), 
                round(grauAutoCorr(autocorrelacao), digits=4), 
                tendencia(autocorrelacao),
                round(mediaAutoCor(max(na.omit(autocorrelacao)), min(na.omit(autocorrelacao))), digits=4))
  }
  write.table(df, file = arquivo, col.names = TRUE, row.names=FALSE, sep=",")  
}