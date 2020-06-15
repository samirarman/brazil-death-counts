library(rstudioapi)

# DO NOT USE source() ON THIS FILE

# This file is intended a sample of how to take
# advantage o RStudio Jobs functionality to 
# start multiple scraping scripts at once.

# Each job should be manually configured before launching,
# even though the scripts are pre-configured for the tasks.

wd <- getwd()

# Job scripts should be mannualy configured before launching
cities_scripts <- list.files(path = "./jobs/produce_cities", pattern = "*.R", full.names = TRUE)
cities_summary_scripts <- list.files(path = "./jobs/produce_cities_summary", pattern = "*.R", full.names = TRUE)
states_scripts <- list.files(path = "./jobs/produce_states", pattern = "*.R", full.names = TRUE)
states_summary_scripts <- list.files(path = "./jobs/produce_states_summary", pattern = "*.R", full.names = TRUE)
update_jobs <- list.files(path = "./jobs/update", pattern = "*.R", full.names = TRUE)

# Scrape cities
# Divide the work in order not to be cut from server
lapply(cities_scripts[1:6], jobRunScript, workingDir = wd)
lapply(cities_scripts[7:12], jobRunScript, workingDir = wd)

# Scrape cities summary
lapply(cities_summary_scripts, jobRunScript, workingDir = wd)

# Scrape states
lapply(states_scripts[1:6], jobRunScript, workingDir = wd)
lapply(states_scripts[7:12], jobRunScript, workingDir = wd)

# Scrape states summary
lapply(states_summary_scripts, jobRunScript, workingDir = wd)

# Update data
lapply(update_jobs, jobRunScript, workingDir = wd)


