library(dplyr)
library(purrr)
library(tidyr)


by_city_monthly <- read.csv("./merged_data/by_city_monthly.csv")
by_city_yearly <- read.csv("./merged_data/by_city_yearly.csv")
by_state_monthly <- read.csv("./merged_data/by_state_monthly.csv")
by_state_yearly <- read.csv("./merged_data/by_state_yearly.csv")

list_df <- list(
  city_monthly = by_city_monthly,
  city_yearly = by_city_yearly,
  state_monthly = by_state_monthly,
  state_yearly = by_state_yearly
)

rows_count <- map(list_df, nrow)

print_compare <- function(rows, should_have) {
  cat("Number of rows: ", rows, "\n",
      "Should have: ", should_have , "\n")
}

current_month <- format(Sys.Date(), "%m") %>% as.integer
current_year <- format(Sys.Date(), "%Y") %>% as.integer
year_span <- current_year - 2015 + 1

cat("\n======================================================")
cat("\n<<<<<RUN ON :", format(Sys.time(), "%Y-%m-%d-%H-%M"), ">>>>>", "\n")
print("CITIES MONTHLY COUNTS")
count <- unique(list_df$city_monthly$Cidade) %>% length
should_have <- count * (current_year - 2015) * 12 + count * current_month 
print_compare(rows_count$city_monthly, should_have)
cat("", "\n")

print("CITIES YEARLY COUNTS")    
count <- unique(list_df$city_yearly$Cidade) %>% length
should_have <- count * (current_year - 2015 + 1) 
print_compare(rows_count$city_yearly, should_have)
cat("", "\n")

print("STATES MONTHLY COUNTS")
count <- unique(list_df$state_monthly$Estado) %>% length
should_have <- count * (current_year - 2015) * 12 + count * current_month 
print_compare(rows_count$state_monthly, should_have)
cat("", "\n")

print("STATES YEARLY COUNTS")
count <- unique(list_df$state_yearly$Estado) %>% length
should_have <- count * (current_year - 2015 + 1) + count * current_month
print_compare(rows_count$state_yearly, should_have)
cat("", "\n")


summary <- list_df %>%
  map(. %>%
        group_by(Ano, Estado) %>%
        summarise(Registros = sum(Registros)))

for (i in seq_along(summary)) {
  summary[[i]]$table <- rep(names(summary[i]), nrow(summary[[i]]))
}

print("AGGREGATE REGISTRIES COUNT PER TABLE")
summary %>%
  bind_rows %>%
  pivot_wider(names_from = table, values_from = Registros) %>%
  print(n = Inf)
