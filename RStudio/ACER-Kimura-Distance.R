#---------------------------#
######Kimura Distance########
#---------------------------#
install.packages("reshape")
install.packages("hrbrthemes")
library(reshape)
library(hrbrthemes)
library(ggplot2)
library(viridis)
library(tidyverse)
library(gridExtra)
#############################

KimuraDistance <- read.csv("ACER-Kimura-distance.txt", sep=" ")
KimuraDistance

#Genome size in bp
genomes_size=205972910

kd_melt = melt(KimuraDistance,id="Div")
kd_melt$norm = kd_melt$value/genomes_size * 100

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
p <- ggplot(kd_melt, aes(fill=variable, y=norm, x=Div)) + 
  geom_bar(position="stack", stat="identity", color="black") +
  scale_fill_viridis(option = "plasma", discrete = T) +
  theme_classic() +
  xlab("Kimura substitution level") +
  ylab("Percent of the genome") + 
  labs(fill = "") +
  coord_cartesian(xlim = c(0, 55)) +
  theme(axis.text=element_text(size=11),axis.title =element_text(size=12))

p + ggtitle("Apis cerana") +
  theme(plot.title = element_text(hjust = 0.5))

#width 18
ggsave("ACER-Kimura-Distance.tiff", units="in", width=18, height=9, dpi=300, compression = 'lzw')

##end##