#### Listas com o Purr ###

# Uma lista do R é como uma caixa dentro de uma caixa dentro de outra caixa.
list(x = c(1, 2, 3), y = "two", z = "FALSE")

# As principais dificuldades das listas e ver e extrair os conteúdos e usar funções nelas.

a_list <- list(num = c(8, 9),
               log = TRUE,
               cha = c("a","b","c"))

a_list["num"] # Retorna um objeto lista, por isso retorna $num
a_list[["num"]] # Retorna o conteúdo da lista e é um vetor.
# Esse último comando é equivalente a a_list$num

a_list %>%
  pluck('cha', 1)

# Aula 2

library(tidyverse)

# install.packages("repurrrsive")
library(repurrrsive)

View(sw_people)

## Exercícios do Star Wars

sw_people %>% map_chr(pluck, 'name') # Extraindo os nomes
# map_chr -> retorna um vetor com os nomes

# Se fizesse pluck('name') ia dar erro, pois não tem 'name' diretamente no sw_people.

which(sw_people %>% 
        map_chr(pluck, 'name') %in% c("Darth Vader", "Anakin Skywalker"))
# Retorna a posição dos elementos que atendem ao estabelecido.

(sw_people %>%
    map_chr(pluck, 'height'))[c(4, 11)]

# Assim, o Darth Vader tem 202 e o Anakin Skywalker tem 188.

## Exercício notas

set.seed(1000)
exams <- list(
  student1 = round(runif(10, 50, 100)),
  student2 = round(runif(10, 50, 100)),
  student3 = round(runif(10, 50, 100)),
  student4 = round(runif(10, 50, 100)),
  student5 = round(runif(10, 50, 100))
)

## Queremos testar lenght(exams$student1) == 10.

# Família map com funções elaboradas pelo usuário

fun1 <- function(x) {
  length(x) == 10
}

exams %>%
  map(fun1)
map_lgl(exams, fun1) # Retorna um vetor com valores lógicos.
fun1(exams[[1]])
fun1(exams[[2]])
fun1(exams[[3]])

map_lgl(exams, function(y) length(y) == 10)

map_lgl(exams, ~length(.) == 10) # ~ indica em função de alguma coisa.

map_dbl(exams, ~(sum(.) - min(.))/9) # Outro exemplo

# O map_2() é usado para quando se deseja ter duas listas de entrada.

extra <-list(0, 0, 1, 1, .5)
mean(exams[[1]] + extra[[1]])

map2_dbl(exams, extra, ~mean(.x) + .y)

exams %>% map2_dbl(extra, ~ mean(.x) + .y)

# O comando pmap é o caso geral que recebe p listas.

exams %>%
  map(summary)

exams %>%
  map(summary) %>%
  map_dbl(~.['Median'])
