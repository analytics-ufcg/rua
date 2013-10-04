require("psych")

information <- function(){

	fileNames <- list.files(pattern="*.csv")
	retorno <- data.frame(maquina = c(1:length(fileNames)), spearman=c(1:length(fileNames)), Rlinear=c(1:length(fileNames)), Rpoli2=c(1:length(fileNames)), Rpoli3=c(1:length(fileNames)))
	contador = 1
	for(i in fileNames){
		dados <- read.csv(i)
		
		dados$CPU_UTIL <- ((dados$CPU_UTIL - min(na.omit(dados$CPU_UTIL))) / (max(na.omit(dados$CPU_UTIL)) - min(na.omit(dados$CPU_UTIL))) * 100) + 1
		dados$MEM_UTIL <- ((dados$MEM_UTIL - min(na.omit(dados$MEM_UTIL))) / (max(na.omit(dados$MEM_UTIL)) - min(na.omit(dados$MEM_UTIL))) * 100) + 1
		
		retorno$maquina[contador] <- i
		
		if(length(na.omit(dados$CPU_UTIL)) - length(na.omit(dados$MEM_UTIL)) == 0){
			retorno$spearman[contador] <- (corr.test(na.omit(dados$CPU_UTIL), na.omit(dados$MEM_UTIL), method="spearman"))$r
		}else{
			if(length(na.omit(dados$CPU_UTIL)) - length(na.omit(dados$MEM_UTIL)) > 0){
				retorno$spearman[contador] <- (corr.test(na.omit(dados$CPU_UTIL)[1:length(na.omit(dados$MEM_UTIL))], na.omit(dados$MEM_UTIL), method="spearman"))$r
			}else{
				retorno$spearman[contador] <- (corr.test(na.omit(dados$CPU_UTIL), na.omit(dados$MEM_UTIL)[1:length(na.omit(dados$CPU_UTIL))], method="spearman"))$r
			}
		}
		
		reg = lm(log(dados$MEM_UTIL) ~ dados$CPU_UTIL)
		retorno$Rlinear[contador] <- summary(reg)$r.squared
		
		reg = lm(log(dados$MEM_UTIL)~dados$CPU_UTIL+I(dados$CPU_UTIL^2))
		retorno$Rpoli2[contador] <- summary(reg)$r.squared
		
		reg = lm(log(dados$MEM_UTIL)~dados$CPU_UTIL+I(dados$CPU_UTIL^2)+I(dados$CPU_UTIL^3))
		retorno$Rpoli3[contador] <- summary(reg)$r.squared
		
		contador = contador + 1
	}
	retorno
}

resultado = information()

write.csv(resultado,"output/informaçõesLog.csv", row.names=FALSE)

resultado <- subset(resultado, (Rlinear > 0.4) | (Rpoli2 > 0.4) | (Rpoli3 > 0.4))

write.csv(resultado,"output/informacoesLog_filtered.csv", row.names=FALSE)