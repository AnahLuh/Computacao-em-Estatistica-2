###################################################
## Cálculos iterativos e criação de Funções no R ##
###################################################
library(tidyverse)

### For loops
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

median(df$a)
median(df$b)
median(df$c)
median(df$d)

# Comments: 
### 1. Before you start the loop, you must always allocate 
### sufficient space for the output

### 2. The sequence: 1:length(df) is the same as seq_along(df)

### 3. The body 
output <- vector("double", ncol(df))  # 1. output
for (i in 1:ncol(df)) {               # 2. sequence
  output[i] <- median(df[[i]])        # 3. body ## Usa-se dois [[]] pois é um tible.
}
output


output <- vector("double", ncol(df))  # 1. output
for (i in seq_along(df)) {            # 2. sequence #seq_along() é equivalente a ncol()
  output[i] <- median(df[[i]])        # 3. body
}
output


output[1] <- median(df[[1]])
output[2] <- median(df[[2]])
output[3] <- median(df[[3]])
output[4] <- median(df[[4]])

###############################################
###Estimando a área de um círculo de raio r ###
###############################################



## Exercício
#### Crie uma função R para calcular a área de um círculo 
#### de raio r via simulação estocástica.
### Inputs da função:
# raio: valor numerico não-negativo com o raio do círculo
# n.pontos: número de pontos simulados usados para a a aproximação numérica.
# semente set.seed(17923887) : Valor numérico indicando a semente do gerador de números aleatórios.
# retornar.dados: Valor lógico indicando se a matriz de dados deve ser retornada.
# grafico: Valor lógico indicando se o gráfico deve ser retornado.

### Inclua mensagem de aviso no começo da função
