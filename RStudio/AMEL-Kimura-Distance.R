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

KimuraDistance <- read.csv("AMEL-Kimura-distance.txt", sep=" ")
KimuraDistance

#Genome size in bp
genomes_size=223937270

#you can find this info in NCBI or:
# Apis.mellifera.GCF_003254395.2_Amel_HAv3.1_genomic.fa.mod.EDTA.TEanno.sum ->
## Total Length: 223937270 bp

kd_melt = melt(KimuraDistance,id="Div")
kd_melt$norm = kd_melt$value/genomes_size * 100

#you can change "color=" or "option=" for better visualization
#see: "viridis color maps"
p <- ggplot(kd_melt, aes(fill=variable, y=norm, x=Div)) + 
  geom_bar(position="stack", stat="identity", color="black") +
  scale_fill_viridis(option = "plasma", discrete = T) +
  theme_classic() +
  xlab("Kimura substitution level") +
  ylab("Percent of the genome") + 
  labs(fill = "") +
  coord_cartesian(xlim = c(0, 55)) +
  theme(axis.text=element_text(size=11),axis.title =element_text(size=12))

#add a title for each species
p + ggtitle("Apis mellifera") +
  theme(plot.title = element_text(hjust = 0.5))

#width 18 (recommended)
ggsave("AMEL-Kimura-Distance.tiff", units="in", width=18, height=9, dpi=300, compression = 'lzw')

############################################################
###########################---end---########################
############################################################