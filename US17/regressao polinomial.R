dados <- read.csv("xsys1.csv")
a <- lm(dados$MEM_UTIL ~ dados$CPU_UTIL + I(dados$CPU_UTIL^2) + I(dados$CPU_UTIL^3))
summary(a)$r.squared
plot(dados$CPU_UTIL)

dados <- read.csv("xsys1.csv")
a <- lm(dados$CPU_UTIL ~ dados$MEM_UTIL + I(dados$MEM_UTIL^2) + I(dados$MEM_UTIL^3))
summary(a)$r.squared