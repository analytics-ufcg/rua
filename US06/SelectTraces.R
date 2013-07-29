traces_selecionados <- read.csv("Maquinas_selecionas.csv", head = T)
dados <- read.csv("xsys.csv", head = T)

dados_selecionados = paste(dados[,2],dados[,3], sep = " ")

for(i in seq(4:393)){
  maquina = c()
  if(is.element(colnames(dados)[i], traces_selecionados[,1]) == TRUE){
    print(colnames(dados)[i])
    print(traces_selecionados[,1])
    print(is.element(colnames(dados)[i], traces_selecionados[,1]))
    dados_selecionados = cbind(dados_selecionados, dados[,i])
  }
}

colnames(dados_selecionados) = c("datatime","M105", "M121", "M122", "M137", "M143", "M169", "M173", "M174", "M178", "M196", "M243",
                                 "M300", "M308", "M376", "M379", "M86",  "M87",  "M9",   "M93",  "M97")

write.csv(dados_selecionados,"traces_selecionados.csv")