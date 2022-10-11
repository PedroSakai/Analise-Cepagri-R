setwd('/Users/Windows10/Documents/E. Tecnico/R/Analises/P4')
#install.packages("ggplot2")
library(ggplot2)

# Cria esqueleto da tabela principal
tMedias <- data.frame(
  Ano = double(),
  TempMedia = double()
)


# Metodo para preencher a tabela principal com as medias das temperaturas de cada mes
for(i in 0:6){
  
  tAno <- cepagri[(cepagri$horario$year + 1900 == 2015 + i),]
  
  for(a in 1:9){
    
    mes <- as.double(a/100)
    
    aux<-data.frame(
      ((tAno$horario$year + 1900)[1]) + mes,
      mean(tAno$temp[format(tAno$horario, "%m") == paste(c("0",a), collapse = "")])
    )
    names(aux)<-c("Ano", "TempMedia")
    
    tMedias <- rbind(tMedias, aux)
  }
  
  for(b in 10:12){
    
    mes <- as.double(b/100)
    
    aux<-data.frame(
      ((tAno$horario$year + 1900)[1]) + mes,
      mean(tAno$temp[format(tAno$horario, "%m") == paste(c("",b), collapse = "")])
    )
    names(aux)<-c("Ano","TempMedia")
    
    tMedias <- rbind(tMedias, aux)
  }
}

# Gráfico:

pdf("grafico7anos.pdf")

g7 <- ggplot(tMedias, aes(x = Ano, y = TempMedia))
g7 <- g7 + geom_line() 
g7 <- g7 + geom_point(aes(y = TempMedia, colour = "Meses")) 
g7 <- g7 + labs(colour = "Legenda:", title = "Variação de Temperatura");
print(g7)

dev.off ()
