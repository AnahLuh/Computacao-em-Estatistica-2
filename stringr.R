##############################################
####### Aula CE2 - Stringr - Prof. Thais #######
##############################################


## Loading packages
library(tidyverse)
#library(stringr)

###################################
## Exercício do slide Aula 02 #####
###################################
library(babynames)
library(nycflights13)
babynames %>%
  mutate(last = str_sub(name, -1), # Criou a coluna last com a última letra de cada nome.
         vowel = last %in% c("a", "e", "i", "o", "u", "y")) %>% # Ele vai verificar se as letras em last fazem parte ou não do vetor, atribuindo FALSE ou TRUE.
  group_by(year, sex) %>%
  summarise(p_vowel = weighted.mean(vowel, n)) %>% # Faz a média ponderada por ano e por sexo de quantos nomes terminavam com vogal
  ggplot(aes(year, p_vowel, color=sex)) + # Plota esses dados
  geom_line()

# -=-=-=-=-=-=-= Exemplo meu -=-=-=-=-=--=--=-=#
# Proporção de nomes que começavam com vogal por sexo e por ano.

babynames %>%
  mutate(first = str_sub(name, 1, 1),
         vowel = first %in% c("A", "E", "I", "O", "U")) %>%
  group_by(sex, year) %>%
  summarise(p_vowel = weighted.mean(vowel, n)) %>%
  ggplot(aes(year, p_vowel, color = sex)) + # Se botar esse argumento color fora do aes, fica um gráfico bem estranho e ele não atribui cores diferentes aos sexos.
  geom_point()
         
# Proporção de nomes que as primeiras três letras são consoantes por sexo e por ano.

babynames %>%
  mutate(first3 = str_to_lower(str_sub(name, 1, 3)),
         consoant = (first3 %in% c("[aeiou]")))
  
  

-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=

###################################
####### Strings Basic #############
###################################

# Creating a string
string1 <- "This is a string"
string1

# Escape character:  \ 
double_quote <- "\""
double_quote # Se você só chama a variável, ela aparece como a string que vc atribuiu.
writeLines(double_quote) # Já essa função vai printar conforme o escape character, etc.

# quiz: include a literal backslash
backslash <- "\\"
writeLines(backslash)

# quiz: write http:\\
text <- "http:\\\\"
text
writeLines(text)

# quiz: write "http:\\"
text <- " \"http:\\\\\" "
text
writeLines(text)

text <- ' "http:\\\\" '
text2 <- " 'http:\\\\' " 
writeLines(text)
writeLines(text2)

# Special characters
?"'"
x <- "\u00b5" # Esse é a letra mi.
x

# Number of characters in a string
str_length(c("a", "R for data science", NA))
str_length(" ") # O espaço também é considerado caracter.

# Combine strings
str_c("x", "y", "z", sep = ", ")
str_c("x", "y", "z") # Ele só junta sem fazer separação.
str_c("Turma-", c("a", "b", "c"), "-Prof.Thais")
?str_c

pessoas <- c(" Rafael", " Andre", " Mateus")
n <- length(pessoas)
birthday <- c(T, F, F)
for(i in 1:n){
writeLines(str_c("Good morning", pessoas[i], 
      if(birthday[i]) " and happy birthday", "!"))
}

# Vector collapse
vet1 <- c("x", "y", "z")
vet2 <- str_c(vet1, collapse = ", ") 
vet2
length(vet1)
length(vet2)

# Subsetting strings  
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
str_sub(x, 1, 1) <- "Ana"
x

x
str_to_lower(x)
?str_to_lower

dog <- "The quick brown dog"
str_to_upper(dog)
str_to_lower(dog)
str_to_title(dog) # Todas as primeiras letras das palavras ficam maiúsculas.
str_to_sentence("the quick brown dog") # Apenas a primeira letra da frase fica maiúscula.

###################################
####### Regular expressions #######
###################################

## It is language that allow you to describe 
## patterns in strings
?regex
x <- c("apple", "banana", "pear")
str_view(x, "an") # Você visualmente observa se há o padrão que vc pediu.

str_view(x, ".a.") # Vc observa as duas letras ao redor do a.
str_view("bananana", ".a.")
str_view_all("bananana", ".a.")
# obs.: matches never overlap

# how do you match the character “.”?
x <- c("apple.", "banana", "pear")
str_view(x, ".") # Vê a primeira letra de cada palavra.
str_view_all(x, ".") # Cada letra vira uma partezinha
str_view_all(x, "\\.") # reg. expr. \. # Encontra o ponto final.
1. escrever um texto
2. ler o texto e tranformar em expressão regular
3. Interpretar a expressão regular

# how do you match the character “\”?
x <- c("apple\\", "banana", "pear")
writeLines(x)

str_view(x, "\\\\") # reg. exp. \\
## check the "match characters in cheatsheet"

# Anchor
x <- c("apple", "banana", "pear")
str_view(x, "^a") # Palavra que começa com "a".
str_view(x, "a$") # Palavra que termina com "a".


# Character classes
x <- c("dog", "cat1", "cat2")
str_view_all(x, "[digit]") # Tudo que seja os caracteres "digit"
str_view_all(x, "[:digit:]")
str_view_all(x, "[^digit]") # Tudo que NÃO seja os caracteres "digit".
str_view_all(x, "[:^digit:]")
str_view_all(x, "[abc]")


# Look for a literal character that normally has special meaning in a regex
str_view(c("abc", "a.c", "a*c", "a c"), "a\\.c") 
str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")
1. texto: "a\\.c"
2. expressão regular: "a\.c"
3. padrão: a.c

# alternation
str_view(c("grey", "gray"), "gr(e|a)y") # No último argumento vc bota que tanto faz se é "e" ou "a", ou seja, "grey" ou "gray".
str_view(c("grey", "gray"), "gre|ay") # Tanto faz se é "gre" ou "ay".
str_view(c("grey", "gray"), "g(re|a)y") # Tanto faz se é "grey" ou "gay".
1. grey
2. gay

# range
x <- c("apple", "banana", "pear")
str_view_all(x, "[a-i]") # Vai procurar da letra "a" até a "i" (conforme a ordem alfabética)
str_view_all(x, "[aeiou]") # Vai procurar esses caracteres.
str_view_all(x, "[^aeiou]") # Vai procurar tudo exceto esses caracteres.

# Repetition
x <- "1888: MDCCCLXXXVIII"
str_view(x, "CC?") # 0/1. O símbolo "?" pra se repete NENHUMA ou UMA vez.
str_view(x, "CC+") # 1+. O símbolo "+" pra repetir MAIS DE UMA vez.
str_view(x, "CC*") # 0+. O símbolo "*" pra repetir UMA OU MAIS vezes.
str_view(x, "CCC") 

str_view(x, 'C[LX]+') # "C" seguido de "L" ou "X" mais de uma vez.
str_view(x, 'C{3}') # "C" 3 Cs juntos
str_view(x, 'C{4,}') #  Quatro ou mais "C" juntos
str_view(x, 'C{1,2}') # De UM a DOIS "C" juntos.


###################################
####### Regexp usage ##############
###################################

# When you first look at a regexp, you’ll think a cat walked across your keyboard, 
# but as your understanding improves they will soon start to make sense.

# 1. Determine which strings match a pattern.
# 2. Find the positions of matches.
# 3. Extract the content of matches.
# 4. Replace matches with new values.
# 5. Split a string based on a match.

## 1. Detect matches and find positions of matches
library(tidyverse)

x <- c("apple", "banana", "pear")
str_detect(x, "e") # Dá um output de TRUE ou FALSE, conforme a palavra tenha o match.

# How many common words start with t?
str_detect(words, "^t")
sum(str_detect(words, "^t")) # Quantidade de palavras que começam com "t".
sum(!str_detect(words, "^t")) # Quantidade de palavras que não começam com "t".



# What proportion of common words end with a vowel?
head(words)
head(str_detect(words, "[aeiouy]$")) # Dá um output de TRUE ou FALSE de palavras que terminam com o padrão estabelecido (vogais)
mean(str_detect(words, "[aeiouy]$")) # Dá a proporção de palavras que terminam com vogal.

x <- c("apple", "banana", "pear")
str_count(x, "a") # Dá um output de quantas letras "a" existem.

# On average, how many vowels per word?
mean(str_count(words, "[aeiouy]"))

# Quiz: Create a df and a column with # vowels and consonants
df <- tibble(
  word = words, 
  i = seq_along(word)
)

df <- df %>% 
  mutate(
    vowels = str_count(word, "[aeiouy]"),
    consonants = str_count(word, "[^aeiouy]")
  )


## 2. Extract matches

# find all sentences that contain a colour
colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|") # Pega os padrões da variável colours e separa por "|".
colour_match
sum(str_detect(sentences, colour_match)) # Soma quantas frases tem esse padrão.

has_colour <- str_subset(sentences, colour_match) # Pega as frases que bateram com o padrão de colour_match
has_colour

colours <- c("\\bred", "orange", "yellow", "green", "blue", "purple\\b")
colour_match <- str_c(colours, collapse = "\\b|\\b")
colour_match
has_colour <- str_subset(sentences, colour_match)
has_colour

matches <- str_extract(has_colour, colour_match)
head(matches)
matches2 <- str_extract_all(has_colour, colour_match)
head(matches2)



## 3. Replace matches
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-") # Substitui as primeiras vogais por "-"
str_replace_all(x, "[aeiou]", "-") # Substitui todas as vogais por "-"

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", 
                     "3" = "three")) # Você substitui varios matches em um comando só.

## 4. Split 

sentences %>%
  head(2) %>% 
  str_split(" ") # Separa as palavras quando há um espaço.

df <- sentences %>%
  head(5) %>% 
  str_split(" ", simplify = T) # Separa as palavras quando há um espaço e cria um tibble a partir disso.


## Materials
# See string manipulation with stringr cheatsheet
https://stringr.tidyverse.org/#cheatsheet
  
## Exercises

# 1. From the words data: 
### a. Find all words that start or end with x.

sum(str_detect(words, "^x|x$"))
sum(str_count(words, "^x|x$"))
str_subset(words, "^x|x$")

### b. Find all words that start with a vowel and end with a consonant.

sum(str_detect(words, "^[aeiou]" and "[^aeiou]$")) # Eu tentei algo assim, mas não funcionou.
str_subset(words, "^[aeiou]") # Testei os patterns separadamente e tava certo.
str_subset(words, "[^aeiou]$")

patterns <- c('^[aeiou]', '[^aeiou]$') # Então fiz um vetor com os matches e apliquei no str_detect.
sum(str_detect(words, patterns))


# "^aeiou" -> ele vai procurar strings que comecem com os caracteres juntos aeiou.
# "^[aeiou]" -> ele vai procurar palavras que COMECEM com "a", "e", "i" ou "u".
# "[^aeiou] -> ele vai procurar todas as palavras que tenham consoantes.
# "^[^aeiou]" -> ele vai procurar todas as palavras que comecem com consoantes

# 2. From the Harvard sentences data, extract:
### a. The first word from each sentence.

df <- sentences %>%
  str_split(" ", simplify = T)
df <- df[ ,1]
  

### b. All words ending in ing.

word <- sentences %>%
  str_split(" ")

str_sub(word, "ing$")

...

