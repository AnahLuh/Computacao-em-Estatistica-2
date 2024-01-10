library(nycflights13)
library(tidyverse)
library(stringr)
flights <- nycflights13::flights

# 1- Find all flights that 
# a) Had an arrival delay of two or more hours

flights_1 <- flights %>%
  select(arr_delay) %>%
  filter(arr_delay >= 2)

# b) Flew to Houston (IAH or HOU)

flights_2 <- flights %>%
  select(dest) %>%
  filter(dest == "IAH" | dest == "HOU")


# c) Departed in summer (July, August, and September)

flights_3 <- flights %>%
  select(month) %>%
  filter(month == "7"|month == "8"|month == "9")

# d) Arrived more than two hours late, but didn’t leave late

flights_4 <- flights %>%
  select(arr_delay, dep_delay) %>%
  filter(arr_delay >= 2) %>%
  filter(dep_delay <= 0)

# e) Departed between midnight and 6am (inclusive)

flights_5 <- flights %>%
  select(dep_time) %>%
  filter(dep_time <= 600)

# 2- How many flights have a missing dep_time

sum(is.na(flights$dep_time)) # 8255

# 3- Sort flights to find the most delayed flights

flights_6 <- flights%>%
  arrange(desc(dep_delay))

head(flights_6)

# 4- Which flights travelled the farthest?

flights_7 <- flights%>%
  select(distance, flight) %>%
  arrange(desc(distance))

head(flights_7)

# 5- Select variables containing the word time

flights_8 <- flights %>%
  select(contains("time")) # Contém tal palavra.

# 6- Select variables ending with the word delay

flights_9 <- flights %>%
  select(ends_with("delay")) # Termina com tal palavra.

# 7- Add two variable: departed hour and departed minute

flights$dep_time <- as.character(flights$dep_time)
flights$dep_minute <- str_sub(flights$dep_time, -2)
flights$dep_hour <- substring(flights$dep_time, 1, nchar(flights$dep_time)-2) #nchar calcula o tamanho da palavra.
                    # Argumentos: dataset, onde começa a contagem, onde termina.
flights_10 <- flights %>%
  select(dep_time, dep_minute, dep_hour)

# 8- Average departure delay per day (number of flights)

flights_11 <- flights %>%
  select(day, dep_delay) %>%
  filter(dep_delay > 0) %>%
  group_by(day) %>%
  summarise(flights_delayed = n())

mean(flights_11$flights_delayed)

# 9- Average departure delay by plane

mean(flights$dep_delay, na.rm = TRUE)

