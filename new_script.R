library(arpenr)
library(RSelenium)

system("java -Dwebdriver.gecko.driver=/usr/bin/geckodriver -jar ~/.local/share/binman_seleniumserver/generic/3.141.59/selenium-server-standalone-3.141.59.jar  -port 4545", wait =  FALSE)

rd <- RSelenium::remoteDriver(port = 4545L, browser = "firefox")

rd$open()

arpenr::get_deaths(rd, "2020",  "Todos", "Todos", wait = 5L)

rd$quit()
