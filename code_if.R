##############################################
####### Aula CE2 - Prof. Thais         #######
#######       IF STATEMENT             #######
##############################################


## If statement
x <- 1:10
x <- x-mean(x)
x

# exemplo 1
if(mean(x)!=0){
  x/mean(x)
}else{
  stop("A variável x tem média zero")
  #x/(mean(x)+.00000001)
}



if(mean(x)==0){
  stop("você tem certeza disso?")
}
x/mean(x)


# exemplo 2: warning!
x <- 1:10
all(x!=0)
any(x!=0)
sum(x!=0)==2

if(any(x!=0)){
  x/mean(x)
}else{
  stop("você tem certeza disso?")
}

# all (todos são verdadeiros?), any (pelo menos 1 é verdadeiro?)



# exemplo 3: erro
x <- c(1,2,3,NA)
mean(x)
mean(x)!=0

if(mean(x)!=0){
  x/mean(x)
}else{
  stop("warning ...")
}


if(mean(x, na.rm=T)!=0){
  x/mean(x, na.rm=T)
}else{
  stop("warning ...")
}


x <- c(1,2,3)
if(all(x>0)){
  sqrt(x)
}else{
  stop("warning ...")
}


# It’s ok to drop the curly braces if you have 
# a very short if statement that can fit on one line
if(all(x>0)){
  z <- sqrt(x)
  z^2 + 3
}else {
  stop("warning")
}

if(all(x>0)) sqrt(x)  else stop("warning")


## Combine multiple logical expressions
# ||, &&, any, all, == , near
x <- 1:10
y <- -1:-10

if(mean(x)>0 || mean(y)>0){
  sqrt(x)
}else{
  stop("warning ...")
}

x<- c(T,T) 
y<- c(T,F) 

x||y

x&&y



if(mean(x)>0 && mean(y)>0){
  sqrt(x)
}else{
  stop("warning mean(x)< 0 or mean(y)< 0")
}

library(tidyverse)
y <- 2
z <- sqrt(2)^2
typeof(y)
typeof(z)
y
z
y==z
near(y,z)
?near
near(2, 1.9999999)
near(2, 1.9999999, tol=0.001)
.Machine$double.eps^0.5
near

## Write multiple conditions
if (this) {
  # do that
} else if (that) {
  # do something else
}else {
  # 
}

## Exercise
# Write a greeting function that says “good morning”, 
# “good afternoon”, or “good evening”, depending on 
# the time of day. (Hint: use a time argument that 
# defaults to lubridate::now().)
library(tidyverse)
library(lubridate)
lubridate::now()

x<-today()
class(today())
is.Date(x)
class(now()) == "POSIXct" 
x <- now()


greeting <- function(x=now()){
  if( !(class(x)[1] == "POSIXct" || class(x) =="Date")){
    stop("x não é um objeto \"POSIXct\" ou  \"Date\" ")
  }
  if(am(x)){
    return("Good morning")
  }else if( am(x -hours(6)) ){
    return("Good afternoon")
  }
   else{
     return("Good evening")
    }
}

x <- now()+hours(4)
x <- 3
greeting(x)


# outra opção
greet <- function(time = now()){
  if (am(time)) {
    "good morning"
  }else if (hour(time)<18) {
    "good afternoon"
  }else{
    "good evening"
  }
}

greet()

greet(time = hms::hms(0,0,13))
greet( time = hms::hms(0,0,18))
greet( time = hms::hms(0,0,2))
greet( time = hms::hms(0,0,12))


## ifelse
?ifelse

x <- -2:2
x
y <- ifelse(x>0, x^2, -x^2) # Ele vai testar a condição x>0 e a partir disso ele
# executa os comandos. Se o valor lógico da condição for TRUE, ele executa x^2.
# Se o valor lógico da condição for FALSE, ele executa -x^2.
# ifelse é uma operação vetorizada.
# ifelse não consegue fazer coisas muito mirabolantes.

y


i=1
if(x[i]>0){
  x[i]^2
}else{
  -x[i]^2
}


x <- -1:1
for(i in 1:length(x)){ # Parece muito com Python
  if(x[i]>0){
    print(x[i]^2)
  }else{
    print(-x[i]^2)
  }
}


ifelse(mean(x)>0, x^2, -x^2) # be careful
