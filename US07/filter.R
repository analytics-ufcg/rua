filter <- function(){
    fileNames <- list.files("filesInput", pattern="*.csv") 
    for (name in fileNames){
        dados <- read.csv(paste("filesInput/", name, sep=""))
        if(test(dados)){
            write.csv(dados, paste("filesOutput/", name, sep=""), row.names=FALSE)  
        }
    }
}

test <- function(data){
    TRUE
}




filter()