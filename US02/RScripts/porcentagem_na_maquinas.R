dados <- read.csv("xsys.csv")

porc_maquina = c()

for(i in 4:ncol(dados)){
  
  num_complete = length(na.omit(dados[,i]))
  num_na = length(dados[,i]) - num_complete 
  porc_maquina = rbind(porc_maquina, cbind(num_na/num_complete))
}

porc_maquina = as.data.frame(porc_maquina)
rownames(porc_maquina) = colnames(dados)[4:ncol(dados)]
colnames(porc_maquina) = c("porcentagem")

write.csv(porc_maquina, "porcentagem_na_maquina.csv")