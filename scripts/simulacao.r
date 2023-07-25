
# pacotes utilzados
library(tidyverse)

# simular dados de um modelo de regressão linear múltipla
# com 3 variáveis explicativas
set.seed(123)
n <- 100
x1 <- rnorm(n)
x2 <- rnorm(n)
x3 <- rnorm(n)
y <- 1 + 2 * x1 + 3 * x2 + 4 * x3 + rnorm(n)
dados_sim <- tibble(y, x1, x2, x3)

# simular um processo AR(1)
set.seed(123)
n <- 100
phi <- 0.5
e <- rnorm(n)
y <- rep(0, n)
for (i in 2:n) {
  y[i] <- phi * y[i - 1] + e[i]
}
ar1_sim <- tibble(y)
plot(ar1_sim$y, type = "l")

# simular um processo MA(1)
set.seed(123)
n <- 100
theta <- 0.5
e <- rnorm(n)
y <- rep(0, n)
for (i in 2:n) {
  y[i] <- e[i] + theta * e[i - 1]
}
ma1_sim <- tibble(y)
plot(ma1_sim$y, type = "l")


# simular um processo ARMA(1,1)
set.seed(123)
n <- 100
phi <- 0.5
theta <- 0.5
e <- rnorm(n)
y <- rep(0, n)
for (i in 2:n) {
  y[i] <- phi * y[i - 1] + e[i] + theta * e[i - 1]
}
arma11_sim <- tibble(y)
plot(arma11_sim$y, type = "l")

# simular as respostas de um questionario com 10 perguntas
# em escala de likert de 1 a 5
set.seed(123)
n <- 100
y <- matrix(0, n, 10)
for (i in 1:n) {
  y[i, ] <- sample(1:5, 10, replace = TRUE)
}
likert_sim <- tibble(y)
likert_sim
