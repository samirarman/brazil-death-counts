library(arpenr)
library(RSelenium)
library(purrr)
library(dplyr)

source("constants.R")


rd <- 
  remoteDriver(
    browser = "firefox", 
    port = 4545L, 
    extraCapabilities = 
      list(
        "moz:firefoxOptions" = 
          list(
            args = 
              list('--headless')
          )
      )
   )

rd$open()

cat("Browser opened...\n")

args <- commandArgs(trailingOnly = TRUE)

year_start = args[1]
year_finish = args[2]

month_start <- args[3]
month_finish <- args[4]

state = args[5]

file_name = args[6]

years <- as.character(year_start:year_finish)

if (month_start == "Todos") {
  months <- "Todos"
} else {
  months <- MONTHS[month_start:month_finish]
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

head(data)

cat("Finish reading data, writing file...\n")

write.csv(data, file_name)

cat("File written...\n")

rd$close()

cat("Connection closed...\n")
