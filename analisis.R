install.packages("readxl")
library(readxl)

# 2. Leer el Excel desde GitHub
url <- "https://github.com/UO288633/Trabajo/raw/refs/heads/main/datos_paro_ccaa_2025.xlsx"

datos <- read_excel(url)

# 3. Comprobar que los datos se han cargado
print(names(datos))
print(head(datos))
