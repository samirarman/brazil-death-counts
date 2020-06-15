
# SHOULD CHANGE YEAR FOR EACH SCRAPING ROUND

source("packages.R", local = TRUE)
source("constants.R", local = TRUE)
source("functions.R", local = TRUE)

# SETUP -----------------------------------------------------------------------
rs <- rsDriver(browser = "firefox", port = 2006L)
rd <- rs$client
rd$navigate("https://transparencia.registrocivil.org.br/registros")
Sys.sleep(10)

deaths_radio_button <- rd$findElements(using = "class",
                                       value = "custom-control")[[4]]
deaths_radio_button$clickElement()

fields <-
  rd$findElements(using = "class", value = "multiselect__input")
year_field <- fields[[1]]
month_field <- fields[[2]]
region_field <- fields[[3]]
state_field <- fields[[4]]

search_btn <-
  rd$findElement(using = "class", value = "btn-success")

options <-
  expand_grid(
    year = "2020",
    month = "Junho",
    region = "Todas",
    state = "Todos",
    write = TRUE,
    path = "scraped_data/states/"
  ) %>%
  as_tibble()

# SCRAPING ---------
data <- options %>%
  pmap_dfr(scrape_deaths)

# CLEAN-UP -----
rd$quit()
rs$server$stop()
gc()
