library(arpenr)
library(RSelenium)
library(purrr)
library(dplyr)

source("R/constants.R")


rs <- RSelenium::rsDriver(port = 4567L, browser = "firefox", verbose = FALSE)

rd <- rs$client

cat("Browser opened...\n")

args <- commandArgs(trailingOnly = TRUE)

year_start = args[1]
year_finish = args[2]

month <- args[3]

state = args[4]

file = args[5]

years <- as.character(year_start:year_finish)

if (month == "Todos") {
  months <- "Todos"
} else {
  months <- MONTHS
}

if (state == "Todos") {
  states <- "Todos"
} else {
  states <- STATES
}

options <-
  expand.grid(
    years,
    months,
    states,
    wait = 2L) %>%
  mutate(across(where(is.factor), as.character))

cat("Reading data...\n")

data <- options %>% 
  pmap_dfr(~arpenr::get_deaths(rd, ..1, ..2, ..3, ..4))

cat("Finish reading data, writing file...\n")

write.csv(data, file)

cat("File written...\n")

rd$close()

cat("Connection closed...\n")