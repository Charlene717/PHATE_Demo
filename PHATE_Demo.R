## Ref: https://github.com/KrishnaswamyLab/phateR
## Ref: https://expsys.ncku.edu.tw/index.php?c=welcome

##### Presetting ######
rm(list = ls()) # Clean variable
memory.limit(300000)

## Insystem
# https://syntaxfix.com/question/8457/fatal-error-in-launcher-unable-to-create-process-using-c-program-files-x86-python33-python-exe-c-program-files-x86-python33-pip-exe
# pip install --user phate
# python -m pip install phate

## Check whether the installation of those packages is required from basic
Package.set <- c("tidyverse","Seurat","viridis","phateR")
for (i in 1:length(Package.set)) {
  if (!requireNamespace(Package.set[i], quietly = TRUE)){
    install.packages(Package.set[i])
  }
}
## Load Packages
lapply(Package.set, library, character.only = TRUE)
rm(Package.set,i)

####------ Load data ------####
load("D:/Dropbox/##_GitHub/##_PHH_Lab/CellChat_Demo/2022-05-16_Secret_PADC_CellChat_Example_PRJCA001063.RData")



# #Method1#
# seuratObject_Duc2 <-  seuratObject[,seuratObject@meta.data[["Cell_type"]]=="Ductal cell type 2"]
# rm(list=setdiff(ls(), c("seuratObject_Duc2","seuratObject")))
# #Method2#
# seuratObject_Duc2 <-  seuratObject[,seuratObject@meta.data[["Cell_type"]] %in% "Ductal cell type 2"]
seuratObject_Duc2 <-  seuratObject[,seuratObject@meta.data[["Cell_type"]] %in% c("Acinar cell",
                                                                                 "Ductal cell type 1",
                                                                                 "Ductal cell type 2")]
rm(list=setdiff(ls(), c("seuratObject_Duc2","seuratObject")))
# 
# #Method3#
# # neurons_cds <- cds[,grepl("neurons", colData(cds)$assigned_cell_type, ignore.case=TRUE)]
# seuratObject_Duc2 <- seuratObject[,grepl("Ductal cell type 2", seuratObject@meta.data[["Cell_type"]], ignore.case=TRUE)]


library(Seurat)
#Method1#
data <- seuratObject_Duc2@assays[["RNA"]]@counts %>% as.data.frame()
#data <- seuratObject@assays[["RNA"]]@counts %>% as.data.frame()

# #Method2#
# data <- GetAssayData(seuratObject_Duc2, assay = "RNA", slot = "data") %>% as.data.frame()

data <- data %>% t() %>% as.data.frame()
  
# https://github.com/KrishnaswamyLab/phateR/issues/49
#work!# #In terminal# pip3 install phate
#install.packages("phateR")
#library(phateR)
library(phateR)
data_phate <- phate(data,npca = 30)

library(viridis)
ggplot(data_phate) +
  geom_point(aes(PHATE1, PHATE2, color=data$TOP2A)) +
  labs(color="Mpo") +
  scale_color_viridis(option="B")

