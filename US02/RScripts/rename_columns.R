
dados <- read.csv("xsys.csv")

names = seq(1:390)
names = paste("m",names, sep = "")
colnames(dados)[4:393] = names

write.csv(dados,"xsys.csv")

