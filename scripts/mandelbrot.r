
# pacotes utilizados
library(ggplot2)

# simular um conjunto de mandelbrot
mandelbrot <- function(n, xmin, xmax, ymin, ymax, maxit = 1000) {
  x0 <- runif(n, xmin, xmax)
  y0 <- runif(n, ymin, ymax)
  x <- y <- rep(0, n)
  for (i in 1:maxit) {
    x1 <- x^2 - y^2 + x0
    y1 <- 2 * x * y + y0
    idx <- (x1^2 + y1^2) > 4
    x[idx] <- x0[idx]
    y[idx] <- y0[idx]
    x[!idx] <- x1[!idx]
    y[!idx] <- y1[!idx]
  }
  return(data.frame(x, y))
}
# grafico usando ggplot2 de um fractal mandelbrot
mandelbrot(100000, -2, 1, -1.5, 1.5) |>
  ggplot(aes(x, y)) +
  geom_point(alpha = 0.1, size = 0.1) +
  theme_void()
