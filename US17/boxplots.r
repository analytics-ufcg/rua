files <- c("trace33BA", "xsys5", "xsys6", "xsys14", "xsys18", "xsys28", "xsys29", "xsys32") 

for(f in files){

	filename <- paste(f, ".csv", sep="")
	dados <- read.csv(filename)

	dados$CPU_UTIL <- ((dados$CPU_UTIL - min(na.omit(dados$CPU_UTIL))) / (max(na.omit(dados$CPU_UTIL)) - min(na.omit(dados$CPU_UTIL))) * 100) + 1
	dados$MEM_UTIL <- ((dados$MEM_UTIL - min(na.omit(dados$MEM_UTIL))) / (max(na.omit(dados$MEM_UTIL)) - min(na.omit(dados$MEM_UTIL))) * 100) + 1

	dfM <- subset(dados, select = c(MEM_UTIL))

	coefs <- read.csv("output/propFunMem.csv")
	coefs <- subset(coefs, maquina == filename)

	dfMG <- dfM
	dfMG$MEM_UTIL <- exp(as.numeric(coefs[,2]) + as.numeric(coefs[,3])*dados$CPU_UTIL + as.numeric(coefs[,4])*(dados$CPU_UTIL^2) + as.numeric(coefs[,5])*(dados$CPU_UTIL^3))

	dfD <- dfM
	dfD$UTIS <- dados$UTIS
	dfD$MEM_UTIL <- dfM$MEM_UTIL - dfMG$MEM_UTIL
	dfD$UTIS <- as.POSIXct(as.numeric(dfD$UTIS), origin = "1960-01-01", tz = "GMT")
	
	
	png(paste("output/pic/", f, "_boxplot.png", sep=""), width = 1024, height = 750)	
	print(ggplot(dfD, aes(UTIS, MEM_UTIL)) + geom_boxplot() + xlab(NULL) + ylab("Erro") + theme(axis.title.x = element_text(size = 17), axis.title.y = element_text(size = 17), axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)))
	dev.off()
}
