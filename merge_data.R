source("R/constants.R")

library(drake)
library(tidyverse)
library(visNetwork)
library(rmarkdown)
library(stringi)

merge_files <- function(dir, filename) {
    data <- list.files(path = dir,
                       pattern = "*.csv",
                       full.names = TRUE) %>%
        map_dfr(read_csv) %>%
        select(-c(1))
}

plan <- drake_plan(
    cities_monthly_files = target("./scraped_data/cities_monthly/",
                                  format = "file"),
    cities_yearly_files = target("./scraped_data/cities_yearly/",
                                 format = "file"),
    states_monthly_files = target("./scraped_data/states_monthly/",
                                  format = "file"),
    states_yearly_files = target("./scraped_data/states_yearly/",
                                 format = "file"),
    by_city_monthly = cities_monthly_files %>%
        merge_files() %>%
        write_csv(path = file_out("./merged_data/by_city_monthly.csv")),
    by_city_yearly = cities_yearly_files %>%
        merge_files() %>%
        write_csv(path = file_out("./merged_data/by_city_yearly.csv")),
    by_state_monthly = states_monthly_files %>%
        merge_files() %>%
        write_csv(path = file_out("./merged_data/by_state_monthly.csv")),
    by_state_yearly = states_yearly_files %>%
        merge_files() %>%
        write_csv(path = file_out("./merged_data/by_state_yearly.csv")),
    scrape_report = render(
        knitr_in("scrape_results_checker.Rmd"),
        output_file = file_out("scrape_results_checker.html")
    )
)

print(plan)
make(plan)
visSave(vis_drake_graph(plan), "merge_data.html")
