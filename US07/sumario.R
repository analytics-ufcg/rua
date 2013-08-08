# Sumario (CPU_UTIL) - variância e desvio padrão
df <- data.frame( maquina=rep(""), desviopadrao=rep(NA), variancia=rep(NA), stringsAsFactors=FALSE) 
df = df[-1,]
for(i in (1:40)){
  dados <- read.csv(paste("C:/Users/Lari/Desktop/Rua/filesInput/xsys", i,".csv", sep=""))
  df[i,]  <- c(paste("xsys",i,sep=""),sd(na.omit(dados$CPU_UTIL)), var(na.omit(dados$CPU_UTIL)))
}
# Exportando os resultados 
write.table(df, file ="sumario_cpu.csv", col.names = TRUE, row.names=FALSE)




# Sumario (MEM_UTIL) - variância e desvio padrão
df <- data.frame( maquina=rep(""), desviopadrao=rep(NA), variancia=rep(NA), stringsAsFactors=FALSE) 
df = df[-1,]
for(i in (1:40)){
  dados <- read.csv(paste("C:/Users/Lari/Desktop/Rua/filesInput/xsys", i,".csv", sep=""))
  df[i,]  <- c(paste("xsys",i,sep=""),sd(na.omit(dados$MEM_UTIL)), var(na.omit(dados$MEM_UTIL)))
}
# Exportando os resultados 
write.table(df, file ="sumario_mem.csv", col.names = TRUE, row.names=FALSE)