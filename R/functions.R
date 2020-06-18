# AUXILIARY FUNCTIONS AND SCRIPTS----------------------------------------------

# This file contains auxiliary scripts and functions used by
# the main script (scraper.R)

is_next_btn_avail <- function() {
  btn <- tryCatch(
    rd$findElement(using = "xpath",
                   value = "//a[@aria-label= 'Goto next page']"),
    error = function(x) {
      return(NULL)
    }
  )
  ! is.null(btn)
}

is_table_correct <- function() {
  table <- read_html(rd$getPageSource()[[1]]) %>%
    html_node("table") %>%
    html_table()
  ! table[1, 1] == "Não há resultados a serem exibidos."
}

is_table_avail <- function() {
  table <- tryCatch(
    rd$findElement(using = "class",
                   value = "table-responsive"),
    error = function(x) {
      return(NULL)
    }
  )
  ! is.null(table)
}

wait_for_table <- function() {
  while (!is_table_avail()) {
    Sys.sleep(10)
  }
}

scrape_table <- function(year, month, region, state) {
  data <- read_html(rd$getPageSource()[[1]]) %>%
    html_node("table") %>%
    html_table() %>%
    tibble() %>%
    mutate(
      Ano = as.character(year),
      Mês = as.character(month),
      Região = as.character(region)
    )
  if (state != "Todos") {
    data <- mutate(data, Estado = as.character(state))
  }
  data
}

set_clean_state <-
  function(year_field,
           month_field,
           region_field,
           state_field) {
    year_field$sendKeysToElement(list("2020"))
    year_field$sendKeysToElement(list("", key = "enter"))

    month_field$sendKeysToElement(list("Janeiro"))
    month_field$sendKeysToElement(list("", key = "enter"))

    region_field$sendKeysToElement(list("Todas"))
    region_field$sendKeysToElement(list("", key = "enter"))

    state_field$sendKeysToElement(list("Todos"))
    state_field$sendKeysToElement(list("", key = "enter"))
  }

scrape_deaths <-
  function(year, month, region, state, write = TRUE, path) {
    data <- tibble()

    if (state != "Mato Grosso") {
      set_clean_state(year_field, month_field, region_field, state_field)
    }

    year_field$sendKeysToElement(list(year))
    year_field$sendKeysToElement(list("", key = "enter"))

    month_field$sendKeysToElement(list(month))
    month_field$sendKeysToElement(list("", key = "enter"))

    region_field$sendKeysToElement(list(region))
    region_field$sendKeysToElement(list("", key = "enter"))

    # Sending keys to Mato Grosso state won't work.
    # When scraping Mato Grosso state, select it
    # manually on the website.
    if (state != "Mato Grosso") {
      state_field$sendKeysToElement(list(paste(state, " ", sep = "")))
      state_field$sendKeysToElement(list("", key = "enter"))
    }
    Sys.sleep(1)

    search_btn$highlightElement()
    search_btn$clickElement()
    Sys.sleep(2)


    # if table is available and correct
    # scrape the first generated page
    if (!is_table_avail()) {
      wait_for_table()
    } else if (is_table_correct()) {
      Sys.sleep(0.75)
      table <-
        rd$findElement(using = "class",
                       value = "table-responsive")
      print("First table found.")
      print("Scraping table")
      data <- scrape_table(year, month, region, state) %>%
        bind_rows(data)
    }
    print(data)

    # if the table has more pages,
    # cycle through the pages and
    # scrape the table
    while (is_next_btn_avail()) {
      print("Next button found")

      next_btn <-
        rd$findElement(using = "xpath",
                       value = "//a[@aria-label= 'Goto next page']")
      next_btn$highlightElement()
      next_btn$clickElement()

      print("clicking on next button")

      if (!is_table_avail()) {
        wait_for_table()
      } else if (is_table_correct()) {
        Sys.sleep(0.75)
        table <-
          rd$findElement(using = "class",
                         value = "table-responsive")
        print("Scraping table")
        print(data)
        data <- scrape_table(year, month, region, state) %>%
          bind_rows(data)
      }
    }

    # Give feedback and write the csv file
    print(data)

    if (write == TRUE) {
      file_name <- paste(path,
                         paste(year, month, state, sep = "-"),
                         ".csv",
                         sep = "")
      write.csv(data, file_name)
      print(paste("Written:", file_name))
      Sys.sleep(1)
    }
    invisible(data)
  }