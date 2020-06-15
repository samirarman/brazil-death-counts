source("R/constants.R")
library(drake)
library(tidyverse)
library(stringi)
library(readxl)



read_files <- function(dir) {
    list.files(path = dir, pattern = "*.csv", full.names = TRUE) %>%
        map_dfr(read_csv,
            col_types = c(
                X1 = col_double(),
                Estado = col_character(),
                Registros = col_double(),
                Ano = col_integer(),
                Mês = col_character(),
                Região = col_character()
            )
        ) %>%
        select(-c(1)) %>%
        mutate(Mês = factor(Mês, levels = MONTHS))
}

plan <- drake_plan(
    cities_files = target(
        "./scraped_data/cities/",
        format = "file"
    ),
    cities_summary_files = target(
        "./scraped_data/cities_summary/",
        format = "file"
    ),
    states_files = target(
        "./scraped_data/states",
        format = "file"
    ),
    states_summary_files = target(
        "./scraped_data/states_summary",
        format = "file"
    ),
    ibge_file = target(
        "RELATORIO_DTB_BRASIL_MUNICIPIO.xls",
        format = "file"
    ),
    cities_df = read_files(cities_files),
    cities_summary_df = read_files(cities_summary_files),
    states_df = read_files(states_files),
    states_summary_df = read_files(states_summary_files),
    report = rmarkdown::render(
        knitr_in("sanity_checks.Rmd"),
        output_file = file_out("sanity_checks.html"),
        quiet = TRUE
    )
)
print(plan)
make(plan)
print(vis_drake_graph(plan))
