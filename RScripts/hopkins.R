
#estatistica de Hopkins
#versao 1.0 - Iara

#(a) - gerando a tabela com todos os dados da memoria agrupados. 
#OBS.: Verificar a necessidade de normalizar os dados, como usa porcentagem não se também seria necessário.

data = c()
aux = read.csv("xsys1.csv", head = T)
#data = aux[,1]

for(i in 1:40){
  temp = read.csv(paste("xsys",i,".csv", sep = ""), head = T)
  temp = temp$MEM_UTIL/temp$MEM_ALLOC
  data = cbind(data, temp)
}


row.names(data) = aux[,1]
colnames(data) = c("xsys1","xsys2","xsys3","xsys4","xsys5","xsys6","xsys7","xsys8","xsys9","xsys10",
                   "xsys11","xsys12","xsys13","xsys14","xsys15","xsys16","xsys17","xsys18","xsys19","xsys20",
                   "xsys21","xsys22","xsys23","xsys24","xsys25","xsys26","xsys27","xsys28","xsys29","xsys30",
                   "xsys31","xsys32","xsys33","xsys34","xsys35","xsys36","xsys37","xsys38","xsys39","xsys40")

#(b) - funcao que calcula a distancia entre dois pontos
#Essa funcao vai ser utilizada nos somatorios de hopkins

distancia = function(ponto1, ponto2){
  resultado = 0
  for (i in 1:length(ponto1)){
    resultado = resultado + ((ponto1[i] - ponto2[i])^2)
  }
  resultado = sqrt(resultado)
}

#(c) - funcao:th um conjunto de pontos aleatorios
# Na estatistica sao incluidos p pontos aleatorios ao conjunto de dados
gerar.pontos.aleatorios = function(dados, tamanho){
  pontos = NA
  for (i in 1:ncol(dados)){
    sample = sample(0:100, tamanho)/100
    pontos = cbind(pontos, sample)
  }
  pontos = pontos[,-1]
  colnames(pontos) = colnames(dados)
  return(pontos)
}

#(d) - funcao que gera uma amostragem de tamanho p dos dados
amostragem.dados = function(dados, tamanho){
  sample = sample(nrow(dados), tamanho)
  amostra = dados[sample,]
  return (amostra)
}

ponto.mais.proximo = function(ponto, dados){
  distancia = distancia(ponto, dados[1,])
  for (i in 2:nrow(dados)){
    d = distancia(ponto, dados[i,])
    if (!(d==0) && d < distancia){
      distancia = d
    }
  }
  return(distancia)
}

hopkins = function(dados, n){
  amostra = amostragem.dados(dados, n)  
  novos.pontos = as.data.frame(gerar.pontos.aleatorios(dados, n))
  
  w = 0
  u = 0
  
  for (i in 1:n){
    w = w + ponto.mais.proximo(amostra[i,], dados)
    u = u + ponto.mais.proximo(novos.pontos[i,], dados)
  }
  
  hopkins = u/(u+w)
  
  return (hopkins)
}