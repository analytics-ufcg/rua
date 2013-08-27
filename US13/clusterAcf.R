dados <- read.csv("filesInput/xsys4.csv")
dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
serieA <- subset(dados, select = CPU_UTIL)

dados <- read.csv("filesInput/xsys5.csv")
dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
serieB <- subset(dados, select = CPU_UTIL)

serieA = acf(serieA, lag.max = nrow(serieA), plot = FALSE, na.action = na.pass)
serieB = acf(serieB, lag.max = nrow(serieB), plot = FALSE, na.action = na.pass)

serieA = serieA$acf
serieB = serieB$acf

if(length(serieA)>length(serieB)){
    dif = serieA[1:length(serieB)] - serieB
}else{
    dif = serieA - serieB[1:length(serieA)]
}

sum(dif)

dbscan(matriz, eps = 1, MinPts = 1)