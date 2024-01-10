library(tidyverse)

#### Exercícios - família MAP ####

view(mtcars)

# Write code that uses one of the map functions to:

## 1. Compute the mean of every column in mtcars.

mtcars %>%
  map_dbl(mean)

## 2. Determine the type of each column in nycflights13::flights.

flights <- nycflights13::flights

flights %>%
  map_chr(typeof)

## 3. Compute the number of unique values in each column of iris.

map_dbl(iris, n_distinct)

map_dbl(iris, ~length(unique(.)))

## 4. From random normals with means of -10, 0, 10 and 100, generate 10 samples each.

map(c(-10, 0, 10, 100), ~rnorm(10, .))

## 5. Check if each column of diamonds is a factor.

diamonds %>%
  map_lgl(is.factor)

## 6. Apply a summary function to every numeric column in iris data.

map_dfr(keep(iris, is.numeric), summary) 

## 7. Transform #6 in a function that apllies a generic function f to numeric columns of a dataframe.

funcao_dados <- function(df, f, ...) {
  map(keep(df, is.numeric), f,)
}
