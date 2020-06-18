library(rstudioapi)

# DO NOT USE source() ON THIS FILE

# This file is intended a sample of how to take
# advantage o RStudio Jobs functionality to
# start multiple scraping scripts at once.

# Each job should be manually configured before launching,
# even though the scripts are pre-configured for the tasks.

wd <- getwd()

# Job scripts should be mannualy configured before launching
cities_monthly_scripts <-
    list.files(
        path = "./jobs/pre_configured_jobs/produce_cities_monthly",
        pattern = "*.R",
        full.names = TRUE
    )

cities_yearly_scripts <-
    list.files(
        path = "./jobs/pre_configured_jobs/produce_cities_yearly",
        pattern = "*.R",
        full.names = TRUE
    )

states_monthly_scripts <-
    list.files(
        path = "./jobs/pre_configured_jobs/produce_states_monthly",
        pattern = "*.R",
        full.names = TRUE
    )

states_yearly_scripts <-
    list.files(
        path = "./jobs/pre_configured_jobs/produce_states_yearly",
        pattern = "*.R",
        full.names = TRUE
    )

update_jobs <-
    list.files(
        path = "./jobs/single_jobs",
        pattern = "*.R",
        full.names = TRUE
    )

# Scrape cities monthly
# Divide the work in order not to be cut from server
lapply(cities_monthly_scripts[1:6], jobRunScript, workingDir = wd)
lapply(cities_monthly_scripts[7:12], jobRunScript, workingDir = wd)

# Scrape cities yearly
lapply(cities_yearly_scripts, jobRunScript, workingDir = wd)

# Scrape states monthly
lapply(states_monthly_scripts[1:6], jobRunScript, workingDir = wd)
lapply(states_monthly_scripts[7:12], jobRunScript, workingDir = wd)

# Scrape states yearly
lapply(states_yearly_scripts, jobRunScript, workingDir = wd)

# Update data
lapply(update_jobs, jobRunScript, workingDir = wd)