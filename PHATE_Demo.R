rm(list = ls()) # Clean variable
memory.limit(300000)

load("D:/Dropbox/##_GitHub/##_PHH_Lab/CellChat_Demo/2022-05-16_Secret_PADC_CellChat_Example_PRJCA001063.RData")


library(tidyverse)
library(phateR)

#Method1#
seuratObject_Duc2 <-  seuratObject[,seuratObject@meta.data[["Cell_type"]]=="Ductal cell type 2"]

# #Method2#
# seuratObject_Duc2 <-  seuratObject[,seuratObject@meta.data[["Cell_type"]] %in% "Ductal cell type 2"]
# 
# #Method3#
# # neurons_cds <- cds[,grepl("neurons", colData(cds)$assigned_cell_type, ignore.case=TRUE)]
# seuratObject_Duc2 <- seuratObject[,grepl("Ductal cell type 2", seuratObject@meta.data[["Cell_type"]], ignore.case=TRUE)]


data <- seuratObject_Duc2@assays[["RNA"]]@counts %>% as.numeric()
data_phate <- phate(data)
