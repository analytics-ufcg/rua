filter <- function(){
    fileNames <- list.files("filesInput", pattern="*.csv") 
    for (name in fileNames){
        dados <- read.csv(paste("filesInput/", name, sep=""))
        if(test(dados)){
            write.csv(dados, paste("filesOutput/", name, sep=""), row.names=FALSE)  
        }
    }
}

test <- function(data){
    dados<-data
    dados$MEM_UTIL <- (dados$MEM_UTIL/dados$PHYS_MEM)*100
    dados$MEM_UTIL <- fft(fft(dados$MEM_UTIL), inverse = F)/length(dados$MEM_UTIL)
    dados$MEM_UTIL <- as.numeric(dados$MEM_UTIL)
    if(testVaria(dados)){
	    testAutoCorr(dados)
	}else{
	    FALSE
	}
	
}

testVaria <- function(data){
    dadosTeto<-data
	valores = c()
    k = 1
    for (i in dadosTeto[,4]){
      if(i %in% valores){}
      else{
        valores[k]<-i
        k = k+1
      }
    }
    if(length(valores)>1){
      TRUE
    }else{
      FALSE
    }
}

testAutoCorr <- function(data){
    corr <- acf(data$MEM_UTIL, na.action=na.pass, lag.max = length(data$MEM_UTIL)/2,plot=F)
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
    if(max(resul)>=0.3 || min(resul)<=-0.3){
        TRUE
    }
    else{
        FALSE
    }
}

filter()


#funções que poderam ser usadas em um futuro proximo

ptest <- function(num){
    dadosTeto<- read.csv(paste("filesInput/xsys",num, ".csv", sep=""))
    dadosTeto$CPU_UTIL <- ceiling(dadosTeto$CPU_UTIL) 
    dadosTeto[order(dadosTeto$CPU_UTIL, decreasing= F),]
    cat("\nMaquina ", num , "\n")
    print (quantile(dadosTeto$CPU_UTIL,  probs = c(10,20 , 30, 40, 50, 60, 70, 80, 90, 95, 98, 100)/100, na.rm = T))
}


for(i in (1:40)){
  dadosTeto<-read.csv(paste("filesInput/xsys", i,".csv", sep=""))
  dadosTeto$CPU_UTIL <- ceiling(dadosTeto$CPU_UTIL)
  png(paste("filesInput/xsys", i,".png", sep=""), width=800,height=600)
  plot(dadosTeto$CPU_UTIL, type="l" ,ylab="Utilização de CPU", xlab = sd(dadosTeto$CPU_UTIL, na.rm=T)  )
  dev.off()
}

testQuartil <- function(data){
    dadosTeto<-data
    dadosTeto$CPU_UTIL <- ceiling(dadosTeto$CPU_UTIL)
    valores = c()
    k = 1
    for (i in c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95)){
      quartil <- quantile(dadosTeto$CPU_UTIL,  probs = c(i)/100, na.rm = T,  names = F)
      if(quartil %in% valores){}
      else{
        valores[k]<-quartil
        k = k+1
      }
    }
    if(length(valores)>2){
      TRUE
    }else{
      FALSE
    }
}