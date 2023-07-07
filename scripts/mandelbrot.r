
# iterar sobre as coordenadas complexas
# for (i in 1:100) {
#  z <- z^2 + m
#   m <- m + (abs(z) < 2)
# }

# simular um fractal de Mandelbrot e salvar imagem
# https://pt.wikipedia.org/wiki/Conjunto_de_Mandelbrots
# pacotes utilzados
library(foreach)
library(doParallel)
library(ggplot2)

# registrar o tempo de execução
inicio <- Sys.time()
# definir a resolução da imagem
resolucao <- 1000

# criar uma matriz de coordenadas complexas
x <- seq(-2, 1, length.out = resolucao)
y <- seq(-1, 1, length.out = resolucao)
z <- outer(x, y, FUN = function(x, y) complex(real = x, imaginary = y))

# criar uma matriz para armazenar o número de iterações
m <- matrix(0, resolucao, resolucao)

# definir o número de núcleos de CPU a serem usados
num_cores <- detectCores()

# registrar os núcleos de CPU para uso com o foreach
cl <- makeCluster(num_cores)
registerDoParallel(cl)

# iterar sobre as coordenadas complexas em paralelo
m <- foreach(i = 1:100, .combine = "+") %dopar% {
  z <- z^2 + m
  (abs(z) < 2)
}

# fechar a conexão com os núcleos de CPU
stopCluster(cl)

# criar um data frame com as coordenadas e o número de iterações
df <- data.frame(x = rep(x, each = resolucao),
                 y = rep(y, times = resolucao),
                 m = as.vector(m))

# criar o gráfico
fractal01  <- ggplot(df, aes(x = x, y = y, fill = m)) +
              geom_raster() +
              scale_fill_viridis_c(option = "magma") +
              theme_void()

# salvar o gráfico
ggsave("fractal01.png", fractal01, width = 12, height = 10, dpi = 300)

# exibir o tempo de execução
print(Sys.time() - inicio)