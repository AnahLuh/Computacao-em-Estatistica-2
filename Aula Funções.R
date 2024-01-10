# AULA DE FUNÇÕES 

## SINTAXE
name_function <- function (arguments) {
  body
}

## EXEMPLO 1
IQR <- function(x, na.rm = FALSE, type = 7) {
  diff(quantile(as.sumeric(x), c(0.25, 0.75), 
                na.rm = na.rm, names = FALSE,
                type = type))} 

O type da função quantile é como esses quartis serão calculados. O mais comum é o type 7.

## EXEMPLO 2
rescale <- function(x, na.rm = FALSE #Vai ser o padrão do argumento na.rm) {
                  (x - min(x, na.rm = na.rm)) / (max(x, na.rm = na.rm)) - 
                    min(x, na.rm = na.rm)}

## EXEMPLO 3 

variance <- function(x, na.rm = TRUE) {
  (sum(x-mean(x))^2) / (length(x) - 1)}
