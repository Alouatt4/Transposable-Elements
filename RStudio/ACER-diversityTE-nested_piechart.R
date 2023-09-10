# Importar bibliotecas necessárias
library(ggplot2)
library(dplyr)
install.packages("ggpie")
library(ggpie)
install.packages("webr")
install.packages("plotly")
library(webr)
library(ggforce)
library(plotly)

#already data.frame
data <- read.csv ("ACER-nested-pc.txt", header = T, sep = "\t", 
                    col.names = c("Class", "Type",
                                  "Count", "bpMasked", "%.masked"),
                    stringsAsFactors = FALSE)

data
#tail(data)
PD <- data %>% 
  group_by(Class, Type) %>% 
  summarise (n = sum(Count)) 
print(PD)
#go to "definitive"

#definitive
#It worked but it is out of scale (external pie)
p <- PieDonut(PD, aes(Class, Type, count=n), start=3*pi/2, labelposition = 1, ratioByGroup = F, donutAlpha = 0.0, r0 = 0.2, title = "Apis cerana")
p <- PieDonut(PD, aes(Class, Type, count=n), start=3*pi/2, labelposition = 1, ratioByGroup = F, pieAlpha = 0.0, r0 = 0.2, title = "Apis cerana")
p <- PieDonut(PD, aes(Class, Type, count=n), start=3*pi/2, labelposition = 1, ratioByGroup = F, r0 = 0.2, title = "Apis cerana")
 
# y <- PieDonut(PD, aes(Class, Type, count=n), start=6*pi/10, labelposition = 3, title = "", ratioByGroup = F)
# y
# p

#definitive
#save different plots and edit in photoshop
#adjust r0 according to % of the genome *see ".TEannosum". Ex. 20.65% = r0 = 0.2
p <- PieDonut(PD, aes(Class, Type, count=n), labelposition = 1, start=7*pi/3, title = "Apis cerana", ratioByGroup = F, r0= 0.3)
p <- PieDonut(PD, aes(Class, Type, count=n), labelposition = 1, start=7*pi/3, ratioByGroup = F, pieAlpha = 0.0)
p


ggsave("ACER-nested_piechart.tiff", units="in", width=10, height=9, dpi=300, compression = 'lzw')

#end
#################################################