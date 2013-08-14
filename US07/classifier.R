# selection <- function(){
#     classificacao <- data.frame(MAQ=rep(""), CPU=rep(NA), MEM=rep(NA), Classe=rep(""), stringsAsFactors=FALSE)
#     classificacao = classificacao[-1,]
#     cont = 1
#     fileNames <- list.files("filesInput", pattern="*.csv") 
#     for (name in fileNames){
#         dados <- read.csv(paste("filesInput/", name, sep=""))
#         classificacao <- classifier(dados, name)
#     }
# 	write.csv(classificacao, "classificacao.csv")
# }
# 
# classifier <- function(data, maquina){
#     dados<-data
#     dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
#     dados$MEM_UTIL <- ceiling(dados$MEM_UTIL)
#     cont_cpu = 0
#     cont_mem = 0
#     for(i in 1:(length(dados$CPU_UTIL))){
#     	if(!is.na(dados$CPU_UTIL[i]) && !is.na(dados$MEM_UTIL[i])){
#          if(dados$CPU_UTIL[i]-dados$MEM_UTIL[i]>0){
# 	       cont_cpu = cont_cpu + 1 
#          }else if(dados$CPU_UTIL[i]-dados$MEM_UTIL[i]<0){
# 	       cont_mem = cont_mem + 1 
# 	   }
# 	}
#     }
#     cpu = round((cont_cpu/(nrow(dados)))*100, digits=2)
#     mem = round((cont_mem/(nrow(dados)))*100, digits=2)
#     if(cpu>=99){
#         classe = "CPU"
#     }else if(mem>=99){
#         classe = "MEM"
#     }else{
#         classe = "CPU/MEM"
#     }    
# 
#     c(maquina, cpu, mem, classe)
# }
# 
# selection()


# Função que classifica as máquinas em três categorias: "CPU", "MEM" e "CPU/MEM"
# Exemplo de chamada: classificacaoTOarquivo("C:/Users/Lari/Desktop/RUA/filesInput/")
classificacaoTOarquivo <- function(diretorio){
  df <- data.frame(MAQ=rep(""), CPU=rep(NA), MEM=rep(NA), Classe=rep(""), stringsAsFactors=FALSE)
  df = df[-1,]
  
  for(j in (1:40)){
    dados <- read.csv(paste(diretorio, "xsys", j,".csv", sep=""))
    
    dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
    dados$MEM_UTIL <- ceiling(dados$MEM_UTIL)
    
    cont_cpu = 0
    cont_mem = 0 
    for(i in 1:(length(dados$CPU_UTIL))){
      if(!is.na(dados$CPU_UTIL[i]) && !is.na(dados$MEM_UTIL[i])){
        if(dados$CPU_UTIL[i]-dados$MEM_UTIL[i]>0){
          cont_cpu = cont_cpu + 1 
        }else if(dados$CPU_UTIL[i]-dados$MEM_UTIL[i]<0){
          cont_mem = cont_mem + 1 
        }
      }
    }
    cpu = round((cont_cpu/(nrow(dados)))*100, digits=2)
    mem = round((cont_mem/(nrow(dados)))*100, digits=2)
    
    if(cpu>=99){
      classe = "CPU"
    }else if(mem>=99){
      classe = "MEM"
    }else{
      classe = "CPU/MEM"
    } 
      
    df[j,] <- c(paste("M-",j,sep=""), cpu, mem, classe)
  }
  write.table(df, file = "C:/Users/Lari/Desktop/RUA/filesInput/classificacao.csv", col.names = TRUE, row.names=FALSE)  
}