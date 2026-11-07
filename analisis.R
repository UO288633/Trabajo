# 1. Instalar y cargar el paquete necesario
install.packages("readxl")
library(readxl)

# 2. Leer el Excel desde GitHub
url <- "https://github.com/UO288633/Trabajo/raw/refs/heads/main/datos_paro_ccaa_2025.xlsx"
datos <- read_excel(url)

# 3. Limpiar los espacios de los nombres de las columnas
names(datos) <- trimws(gsub("\\s+", " ", names(datos)))

# 4. Excluir Ceuta, Melilla y el Total Nacional
# Para comparar únicamente las 17 comunidades autónomas
ccaa <- datos[
  !datos$`Comunidad o ciudad autónoma` %in%
    c("Ceuta", "Melilla", "Total Nacional"),
]

# 5. Calcular las correlaciones de Pearson
cor_educacion_paro <- cor(
  ccaa$`Población 25-64 con estudios superiores (%)`,
  ccaa$`Tasa de paro (%)`,
  use = "complete.obs"
)

cor_educacion_pib <- cor(
  ccaa$`Población 25-64 con estudios superiores (%)`,
  ccaa$`PIB per cápita (euros)`,
  use = "complete.obs"
)

cor_pib_paro <- cor(
  ccaa$`PIB per cápita (euros)`,
  ccaa$`Tasa de paro (%)`,
  use = "complete.obs"
)

# 6. Mostrar los resultados
cat("Correlación estudios superiores y paro:", cor_educacion_paro, "\n")
cat("Correlación estudios superiores y PIB:", cor_educacion_pib, "\n")
cat("Correlación PIB y paro:", cor_pib_paro, "\n")

# 7. Regresión lineal: estudios superiores y tasa de paro
modelo <- lm(
  `Tasa de paro (%)` ~ `Población 25-64 con estudios superiores (%)`,
  data = ccaa
)

cat("Resumen del modelo:\n")
print(summary(modelo))

# 8. Crear el gráfico de dispersión
png("correlacion_educacion_paro.png",
    width = 1200, height = 900, res = 150)

plot(
  ccaa$`Población 25-64 con estudios superiores (%)`,
  ccaa$`Tasa de paro (%)`,
  main = "Estudios superiores y tasa de paro por CCAA (2025)",
  xlab = "Población con estudios superiores (%)",
  ylab = "Tasa de paro (%)",
  pch = 19
)

abline(modelo, lwd = 2)

dev.off()
