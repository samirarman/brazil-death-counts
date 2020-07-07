library(arpenr)
library(RSelenium)
library(purrr)
library(dplyr)

source("R/constants.R")


system("java -Dwebdriver.gecko.driver=/usr/bin/geckodriver -jar ~/.local/share/binman_seleniumserver/generic/3.141.59/selenium-server-standalone-3.141.59.jar  -port 4545", wait =  FALSE)
rs <- rsDriver(port = 4567L, browser = "firefox", extraCapabilities = list("moz:firefoxOptions" = list(
  args = list('--headless')
)))

rs <- RSelenium::rsDriver(port = 4567L, browser = "firefox")


rd <- rs$client
rd$open()

options <-
  expand.grid(
    year = as.character(2015:2020),
    month = "Todos",
    state = "Todos",
    wait = 2L) %>% 
  as_tibble() %>%
  mutate(across(where(is.factor), as.character))

# Launch scripts in background    
options %>% 
  pmap_dfr(~arpenr::get_deaths(rd, ..1, ..2, ..3, ..4)) %>% 
  write.csv("merged_data/by_state_yearly.csv")

options <-
  expand.grid(
    year = as.character(2015:2020),
    month = MONTHS,
    state = "Todos",
    wait = 2L) %>% 
  as_tibble() %>%
  mutate(across(where(is.factor), as.character))

# Launch scripts in background    
options %>% 
  pmap_dfr(~arpenr::get_deaths(rd, ..1, ..2, ..3, ..4)) %>% 
  write.csv("merged_data/by_state_monthly.csv")


options <-
  expand.grid(
    year = as.character(2015:2020),
    month = "Todos",
    state = STATES,
    wait = 2L
  ) %>%
  as_tibble() %>%
  mutate(across(where(is.factor), as.character))

# Launch scripts in background
options %>%
  pmap_dfr( ~ arpenr::get_deaths(rd, ..1, ..2, ..3, ..4)) %>%
  write.csv("merged_data/by_city_yearly.csv")

Sys.sleep(100)

for (i in seq_along(MONTHS)) {
  options <-
    expand.grid(
      year = as.character(2015),
      month = MONTHS[i],
      state = STATES,
      wait = 2L
    ) %>%
    as_tibble() %>%
    mutate(across(where(is.factor), as.character))
  
  # Launch scripts in background
  options %>%
    pmap_dfr( ~ arpenr::get_deaths(rd, ..1, ..2, ..3, ..4)) %>%
    write.csv(paste0("merged_data/by_city_monthly", i, ".csv"))
  
  Sys.sleep(120)
  
}


# Clean up
rd$quit()
