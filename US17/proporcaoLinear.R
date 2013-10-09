proporcao <- function(){

	fileNames <- list.files(pattern="*.csv")
	retorno <- data.frame(maquina = c(1:length(fileNames)), Co0=c(1:length(fileNames)), CoX=c(1:length(fileNames)), R=c(1:length(fileNames)))
	contador = 1
	for(i in fileNames){
		dados <- read.csv(i)
		reg = lm(formula = dados$MEM_UTIL ~ dados$CPU_UTIL)
		retorno$maquina[contador] <- i
		retorno$Co0[contador] <- reg$coefficients[1]
		retorno$CoX[contador] <- reg$coefficients[2]
		retorno$R[contador] <- summary(reg)$r.squared
		contador = contador + 1
		png(paste(i, ".png",sep=""))
		plot(dados$CPU_UTIL,dados$MEM_UTIL, xlab = "CPU", ylab = "Memória")
		abline(a = reg$coefficients[1], b = reg$coefficients[2])
		dev.off()
	}
	retorno
}

resultado = proporcao()

write.csv(resultado, "propFunMem.csv", row.names=FALSE)