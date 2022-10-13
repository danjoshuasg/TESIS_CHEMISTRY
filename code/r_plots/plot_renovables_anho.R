library(tidyverse)
data<-read.csv(file = "C:/Users/danjo/Downloads/Datos de contexto energia renovable.csv")
data
data
data_t <- data %>% gather(key = GeoBiomasaOtros.TWh., value = Procedencia)
data_t

?gather

data_t<-data %>% select(c(Procedencia, Anho, GeoBiomasaOtros.TWh.,Solar.TWh.,Eolica.TWh.)) %>% rename(GeoBiomasaOtros=GeoBiomasaOtros.TWh.,Solar=Solar.TWh.,Eolica=Eolica.TWh.)
data_t<-data_t %>% gather(key = "Tipo.Renovable",value = "Potencia.Generada.TWh",c(-Procedencia,-Anho))

data_p<-data %>% select(c(Procedencia, Anho, GeoBiomasaOtros.Por.,Solar.Por.,Eolica.Por.)) %>% rename(GeoBiomasaOtros=GeoBiomasaOtros.Por.,Solar=Solar.Por.,Eolica=Eolica.Por.)
data_p<-data_p %>% gather(key = "Tipo.Renovable",value = "Potencia.Generada.Por",c(-Procedencia,-Anho))

data<-merge(data_p,data_t,all=TRUE)
plot <- ggplot(data,aes(x=Anho,y=Potencia.Generada.Por,fill=Tipo.Renovable))+facet_grid(Procedencia~.)+theme(panel.grid = element_blank())+ scale_color_viridis_d(aesthetics = "fill")+geom_area(alpha=0.5)+labs(x = "Año", y = "% Potencia consumida", title = "Potencia consumida de origen energético renovable (Sin hidroeléctrica)", fill="Tipo")+theme_bw(12)
plot
write.csv(data,file = "C:/Users/danjo/Downloads/Renovables.csv")

data$Procedencia <- factor(data$Procedencia,levels = c("Peru","Sudamerica","Mundo"))
svg(filename = "PorcentagePotencia.svg")
plot <- ggplot(data,aes(x=Anho,y=Potencia.Generada.Por,fill=Tipo.Renovable))+facet_grid(Procedencia~.)+theme(panel.grid = element_blank())+ scale_color_viridis_d(aesthetics = "fill")+geom_area(alpha=0.5)+labs(x = "Año", y = "% Potencia consumida", title = "Potencia consumida de fuentes renovables (Sin hidroeléctrica)", fill="Tipo")+theme_bw(12)
plot
dev.off() 

plot
