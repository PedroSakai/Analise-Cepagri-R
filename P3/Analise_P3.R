setwd('/Users/Windows10/Documents/E. Tecnico/R/Analises/P3')
install.packages("ggplot2")
library(ggplot2)

# Tabela com as datas de 2017 e as umidades:
t17 <- data.frame(
  Year = cepagri$horario$year[(cepagri$horario$year + 1900 == 2017)] + 1900,
  umid = cepagri$umid[(cepagri$horario$year + 1900 == 2017)]
)

# Tabela com as frequencia das umidades de 2017, separadas em 4 grupos
# 1 a 25, 26 a 50, 51 a 75, 76 a 100.
tFreq <- data.frame(
  Umid = c("1-25", "26-50", "51-75", "76-100"),
  Freq = c(length(c(t17$umid[t17$umid <= 25])),
           length(c(t17$umid[(t17$umid > 25) & (t17$umid<=50)])),
           length(c(t17$umid[(t17$umid > 50) & (t17$umid<=75)])),
           length(c(t17$umid[(t17$umid > 75) & (t17$umid<=100)]))
           ),
  Rotulo = c("Quantidade","Quantidade","Quantidade","Quantidade")
)

# Grafico de Pizza:
pdf("graficoPizza.pdf")

gPizza <- ggplot(tFreq[tFreq$Rotulo == "Quantidade",],
       aes(x = "Quantidade", weight = Freq, fill = Umid))
gPizza <- gPizza + geom_bar()
gPizza <- gPizza + coord_polar(theta = "y")
gPizza <- gPizza + theme(axis.title.x=element_blank(), axis.title.y=element_blank(), axis.ticks=element_blank(), panel.border=element_blank(), panel.grid=element_blank());
gPizza <- gPizza + labs(title = "Umidade em 2017");
print(gPizza)

dev.off () 
