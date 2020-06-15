library(tidyverse)

source("constants.R")

states_summary <-
  list.files(path = "./scraped_data/states_summary", full.names = TRUE) %>%
  map_dfr(read_csv) %>%
  select(-c(1)) %>%
  select(Ano, Estado, Registros)

states <-
  list.files(path = "./scraped_data/states", full.names = TRUE) %>%
  map_dfr(read_csv) %>%
  select(-c(1))

cities_summary <-
  list.files(path = "./scraped_data/cities_summary", full.names = TRUE) %>%
  map_dfr(read.csv) %>%
  select(-c(1))

cities <-
  list.files(path = "./scraped_data/cities", full.names = TRUE) %>%
  map_dfr(read_csv) %>%
  select(-c(1))

(nrow(states_summary) == length(2015:2020) * length(STATES))

(nrow(states) == length(2015:2019) * length(STATES) * length(MONTHS) + 
  length(2020) * length(STATES) * length(MONTHS[1:6]))

(ss_table <- states_summary %>%
    group_by(Ano) %>%
    summarise(Registros = sum(Registros)))

(s_table <- states %>%
  group_by(Ano) %>%
  summarise(Registros = sum(Registros)))

(cs_table <- cities_summary %>%
  group_by(Ano) %>%
  summarise(Registros = sum(Registros)))

(c_table <- cities %>%
  group_by(Ano) %>%
  summarise(Registros = sum(Registros)))

levels(as.factor(paste(cities$Cidade, cities$Estado, sep = "-")))
View(cities %>% filter(Cidade == "Caiçara"))
       