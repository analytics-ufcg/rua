require(ggplot2)
require(outliers)

files = list.files(pattern="*.csv")

for(i in files){
	dados <- read.csv(i)

	q1 <- quantile(dados$CPU_UTIL, probs = 0.25, na.rm = T)
	q3 <- quantile(dados$CPU_UTIL, probs = 0.75, na.rm = T)

	aiq <- q3 - q1

	dados <- subset(dados, dados$CPU_UTIL > (q1 - 1.5*aiq) & dados$CPU_UTIL < (q3 + 1.5*aiq))


	q1 <- quantile(dados$MEM_UTIL, probs = 0.25, na.rm = T)
	q3 <- quantile(dados$MEM_UTIL, probs = 0.75, na.rm = T)

	aiq <- q3 - q1

	dados <- subset(dados, dados$MEM_UTIL > (q1 - 1.5*aiq) & dados$MEM_UTIL < (q3 + 1.5*aiq))

	png(paste(i, ".png", sep=""))
	plot(dados$CPU_UTIL, dados$MEM_UTIL)
	dev.off()
}


files = list.files(pattern="*.csv")

for(i in files){
	dados <- read.csv(i)
	dados$outlier <- outlier(dados$CPU_UTIL*dados$MEM_UTIL, opposite = FALSE, logical = T)
	p1 <- ggplot(dados, aes( dados$CPU_UTIL, dados$MEM_UTIL, colour=outlier))+ xlab("Tempo") + ylab("Memória") + geom_point() + scale_fill_hue()
	print(p1)
}