FROM r-base:3.6.2
RUN apt-get update &&\
 apt-get install -y libxml2-dev &&\
 apt-get install -y libcurl4-openssl-dev &&\
 apt-get install -y libssl-dev && \
 apt-get install -y pandoc

RUN R -e "options(repos = \
  list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2020-05-01/')); \
  install.packages('drake'); \
  install.packages('tidyverse'); \
  install.packages('visNetwork'); \
  install.packages('stringi'); \
  install.packages('readxl'); \
  install.packages('visNetwork'); \
  install.packages('DT')"

RUN mkdir /home/brazil-death-data && \
 mkdir /home/brazil-death-data/.drake && \
 mkdir /home/brazil-death-data/site_files && \
 mkdir /home/brazil-death-data/merged_data

COPY R/ /home/brazil-death-data/R/
COPY site_files/ /home/brazil-death-data/site_files
COPY make_site.R /home/brazil-death-data/make_site.R

CMD cd /home/brazil-death-data&& \
  R -e "source('make_site.R')"
