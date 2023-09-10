# Import libraries #
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
#see: Apis.mellifera.GCF_003254395.2_Amel_HAv3.1_genomic.fa.mod.EDTA.TEanno.sum
data <- read.csv ("AMEL-nested-pc.txt", header = T, sep = "\t", 
                    col.names = c("Class", "Type",
                                  "Count", "bpMasked", "%.masked"),
                    stringsAsFactors = FALSE)

data
#tail(data)
PD <- data %>% 
  group_by(Class, Type) %>% 
  summarise (n = sum(Count)) 
print(PD)


#definitive
#It worked but it is out of scale (external pie). If necessary, adjust "start="
#only pie   ->    "donutAlpha = 0.0"
p <- PieDonut(PD, aes(Class, Type, count=n), start=3*pi/2, labelposition = 1, ratioByGroup = F, donutAlpha = 0.0, r0 = 0.2, title = "Apis mellifera")

#only donut   ->    "pieAlpha = 0.0"
p <- PieDonut(PD, aes(Class, Type, count=n), start=3*pi/2, labelposition = 1, ratioByGroup = F, pieAlpha = 0.0, r0 = 0.2, title = "Apis mellifera")

#both (pie and donut)
p <- PieDonut(PD, aes(Class, Type, count=n), start=3*pi/2, labelposition = 1, ratioByGroup = F, r0 = 0.2, title = "Apis mellifera")

ggsave("AMEL-nested_piechart.tiff", units="in", width=10, height=9, dpi=300, compression = 'lzw')

#1. Click on: Export > Save image as...
#2. Define: 1920x1017 > Save
#3. Edit on Photoshop the center (if necessary)

#################################################
####################---end---####################
#################################################
