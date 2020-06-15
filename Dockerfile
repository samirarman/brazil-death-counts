FROM r-base:3.6.2
RUN apt-get update &&\
 apt-get install -y libxml2-dev &&\
 apt-get install -y libcurl4-openssl-dev &&\
 apt-get install -y libssl-dev

RUN R -e "options(repos = \
  list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2020-05-01/')); \
  install.packages('drake'); \
  install.packages('tidyverse')"

RUN mkdir /home/brazil-death-counts && \
 mkdir /home/brazil-death-counts/scraped_data && \
 mkdir /home/brazil-death-counts/.drake

COPY scraped_data/ /home/brazil-death-counts/scraped_data/
COPY R/ /home/brazil-death-counts/R/
COPY sanity_checks.Rmd /home/brazil-death-counts/sanity_checks.Rmd

CMD cd /home/brazil-death-counts && \
  R -e "source('make.R')"
