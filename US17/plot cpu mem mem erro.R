files <- c("trace33BA", "xsys5", "xsys6", "xsys14", "xsys18", "xsys28", "xsys29", "xsys32") 

for(f in files){

	filename <- paste(f, ".csv", sep="")
	dados <- read.csv(filename)

	dados$CPU_UTIL <- ((dados$CPU_UTIL - min(na.omit(dados$CPU_UTIL))) / (max(na.omit(dados$CPU_UTIL)) - min(na.omit(dados$CPU_UTIL))) * 100) + 1
	dados$MEM_UTIL <- ((dados$MEM_UTIL - min(na.omit(dados$MEM_UTIL))) / (max(na.omit(dados$MEM_UTIL)) - min(na.omit(dados$MEM_UTIL))) * 100) + 1

	dfM <- subset(dados, select = c(UTIS, MEM_UTIL))
	dfM$Tipo <- "Mem Real"

	dfC <- dfM
	dfC$MEM_UTIL <- dados$CPU_UTIL
	dfC$Tipo <- "CPU"

	coefs <- read.csv("output/propFunMem.csv")
	coefs <- subset(coefs, maquina == filename)

	dfMG <- dfM
	dfMG$MEM_UTIL <- exp(as.numeric(coefs[,2]) + as.numeric(coefs[,3])*dados$CPU_UTIL + as.numeric(coefs[,4])*(dados$CPU_UTIL^2) + as.numeric(coefs[,5])*(dados$CPU_UTIL^3))
	dfMG$Tipo <- "Mem Gerada"

	dfD <- dfM
	dfD$MEM_UTIL <- dfM$MEM_UTIL - dfMG$MEM_UTIL
	dfD$Tipo <- "Erro"

	dff <- rbind(dfC, dfM)
	dff <- rbind(dff, dfMG)
	dff <- rbind(dff, dfD)
	
	dff$UTIS <- as.POSIXct(as.numeric(dff$UTIS), origin = "1960-01-01", tz = "GMT")
	png(paste("output/pic/", f, "_grid.png", sep=""), width = 1024, height = 750)	
	print(ggplot(dff, aes(UTIS, MEM_UTIL, colour = Tipo)) + geom_line() + facet_wrap( ~ Tipo, ncol = 1) + theme(axis.title.x = element_text(size = 17), axis.title.y = element_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15), legend.position="none") + xlab(NULL) + ylab("Memória"))
	dev.off()
}
