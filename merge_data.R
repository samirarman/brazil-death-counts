library(purrr)

file_list <- vector("character", 4)
for (i in seq_along(1:4)) {
  file_list[i] <- paste0("./merged_data/by_city_monthly", i, ".csv")
}

file_list %>%
  map_dfr(read.csv) %>%
  write.csv("./merged_data/by_city_monthly.csv")
