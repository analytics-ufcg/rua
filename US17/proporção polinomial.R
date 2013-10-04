proporcao <- function(){
	#fileNames <- list.files(pattern="*.csv")
	fileNames <- read.csv("output/informacoesLog_filtered.csv")[,1]
	retorno <- data.frame(maquina = c(1:length(fileNames)), Co0=c(1:length(fileNames)), CoX=c(1:length(fileNames)), CoX2=c(1:length(fileNames)), CoX3=c(1:length(fileNames)), R=c(1:length(fileNames)))
	contador = 1
	for(i in fileNames){
		dados <- read.csv(i)
		
		dados$CPU_UTIL <- ((dados$CPU_UTIL - min(na.omit(dados$CPU_UTIL))) / (max(na.omit(dados$CPU_UTIL)) - min(na.omit(dados$CPU_UTIL))) * 100) + 1
		dados$MEM_UTIL <- ((dados$MEM_UTIL - min(na.omit(dados$MEM_UTIL))) / (max(na.omit(dados$MEM_UTIL)) - min(na.omit(dados$MEM_UTIL))) * 100) + 1

		reg = lm(log(dados$MEM_UTIL)~dados$CPU_UTIL+I(dados$CPU_UTIL^2)+I(dados$CPU_UTIL^3))
		retorno$maquina[contador] <- i
		retorno$Co0[contador] <- reg$coefficients[1]
		retorno$CoX[contador] <- reg$coefficients[2]
		retorno$CoX2[contador] <- reg$coefficients[3]
		retorno$CoX3[contador] <- reg$coefficients[4]
		retorno$R[contador] <- summary(reg)$r.squared
		contador = contador + 1
	}
	retorno

}

resultado = proporcao()

write.csv(resultado, "output/propFunMem.csv", row.names=FALSE)
