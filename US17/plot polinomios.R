dados <- read.csv("trace33BA.csv")

dados$CPU_UTIL <- ((dados$CPU_UTIL - min(na.omit(dados$CPU_UTIL))) / (max(na.omit(dados$CPU_UTIL)) - min(na.omit(dados$CPU_UTIL))) * 100) + 1
dados$MEM_UTIL <- ((dados$MEM_UTIL - min(na.omit(dados$MEM_UTIL))) / (max(na.omit(dados$MEM_UTIL)) - min(na.omit(dados$MEM_UTIL))) * 100) + 1

png("trace33BA.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) {exp(1.91532870430257 + 0.166665460911177*x + -0.00379564565439557*(x^2) + 2.23516211614603e-05*(x^3))}, colour = "red")
dev.off()

dados <- read.csv("xsys14.csv")

dados$CPU_UTIL <- ((dados$CPU_UTIL - min(na.omit(dados$CPU_UTIL))) / (max(na.omit(dados$CPU_UTIL)) - min(na.omit(dados$CPU_UTIL))) * 100) + 1
dados$MEM_UTIL <- ((dados$MEM_UTIL - min(na.omit(dados$MEM_UTIL))) / (max(na.omit(dados$MEM_UTIL)) - min(na.omit(dados$MEM_UTIL))) * 100) + 1

png("trace14.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) {exp(1.84557499411278 + 0.0555225370809045*x + -0.00103961620822247*(x^2) + 6.64709244531218e-06*(x^3))}, colour = "red")
dev.off()

dados <- read.csv("xsys18.csv")
png("trace18.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) -7.16049594293095 + 35.3511837694694*x -20.090836697329*(x^2) + 3.49292141419192*(x^3), colour = "red")
dev.off()

dados <- read.csv("xsys28.csv")
png("trace28.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) 1.71316977069654 + 12.5481650248707*x -12.1030908281553*(x^2) + 2.53940571455775*(x^3), colour = "red")
dev.off()

dados <- read.csv("xsys29.csv")
png("trace29.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) 1.73227955700229 + 15.103263370786*x -14.9281574988747*(x^2) + 3.20535330186864*(x^3), colour = "red")
dev.off()

dados <- read.csv("xsys32.csv")
png("trace32.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) 5.47582798615203 + 7.41728269236074*x -6.36367666356598*(x^2) + 1.36499288785147*(x^3), colour = "red")
dev.off()

dados <- read.csv("xsys5.csv")
png("trace5.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) 3.33608441278749 + 45.066021648664*x -18.1178326248273*(x^2) + 1.8187185689837*(x^3), colour = "red")
dev.off()

dados <- read.csv("xsys6.csv")
png("trace6.png")
ggplot(dados, aes(CPU_UTIL, MEM_UTIL))+ xlab("CPU") + ylab("Memória") + geom_point() + scale_fill_hue() + opts(axis.title.x = theme_text(size = 17), axis.title.y = theme_text(size = 17)) + theme(axis.text.x = element_text(size = 15), axis.text.y = element_text(size = 15)) + stat_function(fun=function(x) 3.53698821561234 + 43.9471960683356*x -16.0830917731072*(x^2) + 1.49371778332193*(x^3), colour = "red")
dev.off()
