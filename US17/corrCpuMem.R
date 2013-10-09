library("psych")
correlacao <- function(){

	fileNames <- list.files(pattern="*.csv")
	retorno <- data.frame(maquina = c(1:length(fileNames)), spearman=c(1:length(fileNames)), kendall=c(1:length(fileNames)))
	contador = 1
	for(i in fileNames){
		dados <- read.csv(i)
		if(length(na.omit(dados$CPU_UTIL)) - length(na.omit(dados$MEM_UTIL)) == 0){
			retorno$maquina[contador] <- i
			retorno$spearman[contador] <- (corr.test(na.omit(dados$CPU_UTIL), na.omit(dados$MEM_UTIL), method="spearman"))$r	
			retorno$kendall[contador] <- (corr.test(na.omit(dados$CPU_UTIL), na.omit(dados$MEM_UTIL), method="kendall"))$r
			contador = contador + 1
		}else{
			if(length(na.omit(dados$CPU_UTIL)) - length(na.omit(dados$MEM_UTIL)) > 0){
				retorno$maquina[contador] <- i
				retorno$spearman[contador] <- (corr.test(na.omit(dados$CPU_UTIL)[1:length(na.omit(dados$MEM_UTIL))], na.omit(dados$MEM_UTIL), method="spearman"))$r	
				retorno$kendall[contador] <- (corr.test(na.omit(dados$CPU_UTIL)[1:length(na.omit(dados$MEM_UTIL))], na.omit(dados$MEM_UTIL), method="kendall"))$r
				contador = contador + 1
			}else{
				retorno$maquina[contador] <- i
				retorno$spearman[contador] <- (corr.test(na.omit(dados$CPU_UTIL), na.omit(dados$MEM_UTIL)[1:length(na.omit(dados$CPU_UTIL))], method="spearman"))$r	
				retorno$kendall[contador] <- (corr.test(na.omit(dados$CPU_UTIL), na.omit(dados$MEM_UTIL)[1:length(na.omit(dados$CPU_UTIL))], method="kendall"))$r
				contador = contador + 1
			}
		}
	}
	retorno
}

resultado = correlacao()

write.csv(resultado,"correlações.csv", row.names=FALSE)

normalidade <- function(){
	fileNames <- list.files(pattern="*.csv")
	for(i in fileNames){
		dados <- read.csv(i)
		png(paste("CPU", i, ".png",sep = ""))
		qqnorm(dados$CPU_UTIL)
		qqline(dados$CPU_UTIL)
		dev.off()
		png(paste("MEM", i, ".png",sep = ""))
		qqnorm(dados$MEM_UTIL)
		qqline(dados$MEM_UTIL)
		dev.off()
	}
}