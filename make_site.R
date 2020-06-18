source("R/constants.R")

library(drake)
library(tidyverse)
library(readxl)
library(visNetwork)
library(DT)
library(stringi)

ibge_url <-
    "ftp://geoftp.ibge.gov.br/organizacao_do_territorio/estrutura_territorial/divisao_territorial/2019/DTB_2019.zip"

get_ibge_file <- function(url) {
    download.file(url, "ibge_file.zip", method = "curl")
    unzip("ibge_file.zip",
          "RELATORIO_DTB_BRASIL_MUNICIPIO.xls",
          unzip = "internal")
    
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
    by_city_monthly = read_csv(
        "https://query.data.world/s/tgqb4vp652rhplabohhjrnncc4r3bm"
    ),
    by_city_yearly = read_csv(
        "https://query.data.world/s/6jxjjskfglcbfkso347a2vn2xvze5u"
    ),
    by_state_monthly = read_csv(
        "https://query.data.world/s/7msyylv3oppksvqyhybwvykp54jfzl"
    ),
    by_state_yearly = read_csv(
        "https://query.data.world/s/vq33w7b7fomtns4quojg24qup5emb7"
    ),
    ibge_file = get_ibge_file(ibge_url),
    ibge_data = ibge_file %>% read_xls,
    site_files = target("./site_files/",
                        format = "file"),
    site = generate_site(
        site_files,
        by_city_monthly,
        by_city_yearly,
        by_state_monthly,
        by_state_yearly,
        ibge_data
    )
)

print(plan)
make(plan, lock_envir = FALSE)
visSave(vis_drake_graph(plan), "plan.html")
