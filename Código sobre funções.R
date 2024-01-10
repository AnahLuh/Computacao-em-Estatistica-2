##############################################
####### Aula CE2 - Prof. Thais         #######
#######       FUNCTIONS                #######
##############################################

# Geração de números aleatórios
set.seed(587)
rnorm(10)
x<-2
y<-3
rnorm(10)
set.seed(984651)
rnorm(10)

df <- tibble::tibble(
  a = rnorm(10), b = rnorm(10),
  c = rnorm(10), d = rnorm(10))



# Função rescale 
rescale <- function (x, remove.na = F){
  (x - min(x, na.rm = remove.na)) / (max(x, na.rm = remove.na) - 
                                       min(x, na.rm = remove.na))
}

x <- c(0, 5, 10)
remove.na = F
(x - min(x, na.rm = remove.na)) / (max(x, na.rm = remove.na) - 
                                     min(x, na.rm = remove.na))

# testando a função rescale
rescale(c(0, 5, 10))
(5-0)/(10-0)

x <- c(0, 5, 10)
remove.na = F
(x - min(x, na.rm = remove.na)) / (max(x, na.rm = remove.na) - min(x, na.rm = remove.na))

# testando a função rescale
rescale(c(-10, 0, 10))
(-10-(-10))/(10-(-10))

x <- c(-10, 0, 10)
remove.na = F
(x - min(x, na.rm = remove.na)) / (max(x, na.rm = remove.na) - min(x, na.rm = remove.na))

# testando a função rescale
rescale(c(1, 2, 3, NA, 5), remove.na=T)
rescale(c(0, 0.1, 0.2, 0.7, 1), remove.na=T)


# outra função rescale
rescale <- function (x, na.rm = F){
  (x - min(x, na.rm = na.rm)) / diff(range(x, na.rm = na.rm))
}

## Outra opção: função rescale01
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10))
rescale01(c(-10, 0, 10))
rescale01(c(1, 2, 3, NA, 5))


## Aplicação no exemplo 
df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a <- rescale(df$a)
df$b <- rescale(df$b)
df$c <- rescale(df$c)
df$d <- rescale(df$d)


## Exercise 2
## Write your own function to cumpute the variance of a vector 
variance <- function(x){
  (sum((x-mean(x))^2))/(length(x)-1)
}

z <- -100:100
var(z)
variance(z)


## Return 
complicated_function <- function(x, y, z) {
  if (length(x) == 0 || length(y) == 0) {
    return(0)
  }
  
  # Complicated code here
}


## Environment
f <- function(x) {
  z <- 10000
  x + y
} 

y <- 100
w <- f(y)
w
z
