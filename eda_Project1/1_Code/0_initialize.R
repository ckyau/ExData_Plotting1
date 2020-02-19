# Switch Scientific Notation Off ------------------------------------------
options(scipen = 999)

# Installs and loads packages ---------------------------------------------
for (func in list.files(path = "1_code/0_functions/")) { source(file = paste0("1_code/0_functions/", func)) }

installLoadPackages(c("tidyverse", "plotly"), folderToInstallTo = "C:/Users/cyau/R/R-3.6.1/library")

rm(func, installLoadPackages)
