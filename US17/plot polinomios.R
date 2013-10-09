require('ggplot2')

coefs <- read.csv("output/propFunMem.csv")
files <- as.character(coefs[,1]) #c("trace33BA", "xsys5", "xsys6", "xsys14", "xsys18", "xsys28", "xsys29", "xsys32") 
	
print(files)
for(f in files){

	filename <- strsplit(f, split=".csv")[[1]][1]
	dados <- read.csv(f)

	dados$CPU_UTIL <- ((dados$CPU_UTIL - min(na.omit(dados$CPU_UTIL))) / (max(na.omit(dados$CPU_UTIL)) - min(na.omit(dados$CPU_UTIL))) * 100) + 1
	dados$MEM_UTIL <- ((dados$MEM_UTIL - min(na.omit(dados$MEM_UTIL))) / (max(na.omit(dados$MEM_UTIL)) - min(na.omit(dados$MEM_UTIL))) * 100) + 1

	tmp_coefs <- subset(coefs, maquina == f)

	dff_aux <- data.frame(CPU=dados$CPU_UTIL, MEM=exp(as.numeric(tmp_coefs[,2]) + as.numeric(tmp_coefs[,3])*dados$CPU_UTIL + as.numeric(tmp_coefs[,4])*(dados$CPU_UTIL^2) + as.numeric(tmp_coefs[,5])*(dados$CPU_UTIL^3)))
	dff_aux <- subset(dff_aux, MEM <= 100)
	
	png(paste("output/pic/corr/", filename, "_corr.png", sep=""), width = 1024, height = 750)	
	print(ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + ylim(0, 100) + theme(axis.title.x = element_text(size = 17), axis.title.y = element_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + geom_line(data = dff_aux, aes(CPU, MEM), colour="red"))
	dev.off()

}