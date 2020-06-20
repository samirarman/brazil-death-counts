source("R/constants.R")

library(drake)
library(tidyverse)
library(readxl)
library(visNetwork)
library(DT)
library(stringi)
library(plotly)

ibge_url <-
    "ftp://geoftp.ibge.gov.br/organizacao_do_territorio/estrutura_territorial/divisao_territorial/2019/DTB_2019.zip"

get_ibge_file <- function(url) {
    download.file(url, "ibge_file.zip")
    unzip("ibge_file.zip",
          "RELATORIO_DTB_BRASIL_MUNICIPIO.xls",
          unzip = "internal")
    
}

# arguments included to fool drake
generate_site <- function(index_page,
                          sanity_check_report,
                          about_page,
                          config_file) {
    rmarkdown::render_site("./site_files/", quiet = TRUE)
}

plan <- drake_plan(
    by_city_monthly = target(
        read_csv(
            file_in("./merged_data/by_city_monthly.csv")
        )
    ),
    by_city_yearly = target(
        read_csv(
            file_in("./merged_data/by_city_yearly.csv")
        )
    ),
    by_state_monthly = target(
        read_csv(
            file_in("./merged_data/by_state_monthly.csv")
        )
    ),
    by_state_yearly = target(
        read_csv(file_in("./merged_data/by_state_yearly.csv")
        )
    ),
    ibge_file = get_ibge_file(ibge_url),
    ibge_data = ibge_file %>% read_xls,
    site = generate_site(
        index_page = knitr_in("./site_files/sanity_checks.Rmd"),
        sanity_check_report = knitr_in("./site_files/index.Rmd"),
        about_page = knitr_in("./site_files/about.Rmd"),
        config_file = file_in("./site_files/_site.yml")
    )
)

print(plan)
make(plan, lock_envir = FALSE)
visSave(vis_drake_graph(plan), "plan.html")
