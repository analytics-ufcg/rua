filter <- function(){
    fileNames <- list.files("filesInput", pattern="*.csv") 
    for (name in fileNames){
        dados <- read.csv(paste("filesInput/", name, sep=""))
        dados$CPU_UTIL <- (((dados$CPU_UTIL)/20)*100)
        if(test(dados)){
            write.csv(dados, paste("filesOutput/", name, sep=""), row.names=FALSE)  
        }
    }
}

test <- function(data){
    TRUE
}




filter()

for( i in seq(1 : 40)){
  name <- paste("xsys", i, ".csv", sep="")
  plot <- paste("xsys", i, ".png", sep="")
  print(i)
  machine <- read.csv(name)
  
  png(plot, 800, 600)  
  plot(x = machine$UTIS,y = ceiling(machine$CPU_ALLOC), type="l", xlab = "Tempo", ylab = "Quantidade de Cores", main = paste("Gráfico Cores alocados xsys", i, sep=""))
  
  dev.off()

}

