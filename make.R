source("R/constants.R")

library(drake)
library(tidyverse)
library(stringi)
library(readxl)
library(visNetwork)

read_files <- function(dir) {
    data <- list.files(
        path = dir,
        pattern = "*.csv",
        full.names = TRUE
    ) %>%
        map_dfr(
            read_csv,
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

    write_csv(
        data,
        paste(
            "./merged_data/",
            str_split(dir, "/") %>% last() %>% last(),
            ".csv",
            sep = ""
        )
    )
    return(data)
}


# arguments included to fool drake
generate_site <- function(site_files,
                          cities_df,
                          cities_summary_df,
                          states_df,
                          states_summary_df,
                          ibge_data) {
    rmarkdown::render_site(site_files, quiet = TRUE)
}

plan <- drake_plan(
    cities_files = target("./scraped_data/cities/",
        format = "file"
    ),
    cities_summary_files = target("./scraped_data/cities_summary/",
        format = "file"
    ),
    states_files = target("./scraped_data/states/",
        format = "file"
    ),
    states_summary_files = target("./scraped_data/states_summary/",
        format = "file"
    ),
    ibge_file = target("RELATORIO_DTB_BRASIL_MUNICIPIO.xls",
        format = "file"
    ),
    ibge_data = ibge_file %>% read_xls,
    cities_df = read_files(cities_files),
    cities_summary_df = read_files(cities_summary_files),
    states_df = read_files(states_files),
    states_summary_df = read_files(states_summary_files),
    site_files = target("./site_files/",
        format = "file"
    ),
    site = generate_site(
        site_files,
        cities_df,
        cities_summary_df,
        states_df,
        states_summary_df,
        ibge_data
    )
)
print(plan)
make(plan)
visSave(vis_drake_graph(plan), "plan.html")
