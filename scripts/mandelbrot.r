
# criar uma imagem de um fractal de Mandelbrot
library(ggplot2)

# definir a resolução da imagem
resolucao <- 1000

# criar uma matriz de coordenadas complexas
x <- seq(-2, 1, length.out = resolucao)
y <- seq(-1, 1, length.out = resolucao)
z <- outer(x, y, FUN = function(x, y) complex(real = x, imaginary = y))

# criar uma matriz para armazenar o número de iterações
m <- matrix(0, resolucao, resolucao)

# iterar sobre as coordenadas complexas
for (i in 1:100) {
  z <- z^2 + m
  m <- m + (abs(z) < 2)
}

# criar um data frame com as coordenadas e o número de iterações
df <- data.frame(x = rep(x, each = resolucao),
                 y = rep(y, times = resolucao),
                 m = as.vector(m))

# criar o gráfico
ggplot(df, aes(x = x, y = y, fill = m)) +
  geom_raster() +
  scale_fill_gradientn(colours = rainbow(10)) +
  theme_void()
