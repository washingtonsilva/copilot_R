
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

glimpse(dados_sim)