# Funcao que classifica as maquinas em tres categorias: "CPU", "MEM" e "CPU/MEM" (sem peso)
# Parametros - (diretorio dos dados, arquivo de sai�da )
# Exemplo de chamada: classificaComPeso("C:/Users/Lari/Desktop/RUA/filesInput/", "C:/Users/Lari/Desktop/RUA/classificacaoSemPeso.csv")
classificaSemPeso <- function(diretorio, arquivo){
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
    cpu = round((cont_cpu/(nrow(dados)))*100, digits=4)
    mem = round((cont_mem/(nrow(dados)))*100, digits=4)
    
    if(cpu>=99){
      classe = "CPU"
    }else if(mem>=99){
      classe = "MEM"
    }else{
      classe = "CPU/MEM"
    } 
      
    df[j,] <- c(paste("xsys",j,sep=""), cpu, mem, classe)
  }
  write.table(df, file = arquivo, col.names = TRUE, row.names=FALSE)  
}


# Funcao que classifica as maquinas em tres categorias: "CPU", "MEM" e "CPU/MEM" (com peso)
# Parametros - (diretorio dos dados, arquivo de sai�da )
# Exemplo de chamada: classificaComPeso("C:/Users/Lari/Desktop/RUA/filesInput/", "C:/Users/Lari/Desktop/RUA/classificacaoComPeso.csv")
classificaComPeso <- function(diretorio, arquivo){
  df <- data.frame(MAQ=rep(""), CPU=rep(NA), MEM=rep(NA), Classe=rep(""), stringsAsFactors=FALSE)
  df = df[-1,]
  filtro_mem <- read.csv(paste(diretorio,"sumario_mem.csv", sep = ""), head = T, sep = " ")
  filtro_cpu <- read.csv(paste(diretorio,"sumario_cpu.csv", sep = ""), head = T, sep = " ")
  filtro_mem$cpu = 0
  filtro_mem$mem = 0
  filtro_mem$classe = 0
  filtro_cpu$cpu = 0
  filtro_cpu$mem = 0
  filtro_cpu$classe = 0
  
  for(j in (1:40)){
    dados <- read.csv(paste(diretorio, "xsys", j,".csv", sep=""))    
    
    dados$CPU_UTIL <- ceiling(dados$CPU_UTIL)
    dados$MEM_UTIL <- ceiling(dados$MEM_UTIL)
    
    cont_cpu = 0
    cont_mem = 0 
    pontos = 0
    for(i in 1:(length(dados$CPU_UTIL))){
      if(!is.na(dados$CPU_UTIL[i]) && !is.na(dados$MEM_UTIL[i])){
        if(dados$CPU_UTIL[i]-dados$MEM_UTIL[i]>0){
          cont_cpu = cont_cpu + (dados$CPU_UTIL[i]-dados$MEM_UTIL[i])
          pontos = pontos +  (dados$CPU_UTIL[i]-dados$MEM_UTIL[i])
        }else if(dados$CPU_UTIL[i]-dados$MEM_UTIL[i]<0){
          cont_mem = cont_mem + (dados$MEM_UTIL[i]-dados$CPU_UTIL[i])
          pontos = pontos + (dados$MEM_UTIL[i]-dados$CPU_UTIL[i])
        }
      }
    }
    cpu = round((cont_cpu/(pontos))*100, digits=4)
    mem = round((cont_mem/(pontos))*100, digits=4)
    
    if(cpu>=99){
      classe = "CPU"
    }else if(mem>=99){
      classe = "MEM"
    }else{
      classe = "CPU/MEM"
    } 
    
    filtro_cpu[filtro_cpu$maquina == paste("xsys",j, sep = ""), ]$cpu = cpu
    filtro_cpu[filtro_cpu$maquina == paste("xsys",j, sep = ""), ]$mem = mem
    filtro_cpu[filtro_cpu$maquina == paste("xsys",j, sep = ""), ]$classe = classe
    print(filtro_cpu[filtro_cpu$maquina == paste("xsys",j, sep = ""), ])
    
    filtro_mem[filtro_mem$maquina == paste("xsys",j, sep = ""), ]$cpu = cpu
    filtro_mem[filtro_mem$maquina == paste("xsys",j, sep = ""), ]$mem = mem
    filtro_mem[filtro_mem$maquina == paste("xsys",j, sep = ""), ]$classe = classe
    
    df[j,] <- c(paste("xsys",j,sep=""), cpu, mem, classe)
    
    #print(paste("xsys",j, sep = ""))
    
  }
  write.table(filtro_cpu, file = "sumario_cpu.csv", sep = ",", col.names = T, row.names=FALSE)
  write.table(filtro_mem, file = "sumario_mem.csv", sep = ",", col.names = T, row.names=FALSE)
  write.table(df, file = arquivo, col.names = TRUE, row.names=FALSE)  
}