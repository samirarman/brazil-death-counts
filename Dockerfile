FROM rocker/verse:3.6.2

RUN R -e "options(repos = \
  list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2020-05-01/')); \
  install.packages('drake'); \
  install.packages('visNetwork')"

RUN mkdir /home/brazil-death-data && \
 mkdir /home/brazil-death-data/.drake && \
 mkdir /home/brazil-death-data/site_files && \
 mkdir /home/brazil-death-data/merged_data && \
 mkdir /home/brazil-death-data/docs && \
 mkdir /home/brazil-death-data/scraped_data && \
 mkdir /home/brazil-death-data/R

COPY R/ /home/brazil-death-data/R/
COPY scraped_data /home/brazil-death-data/scraped_data
COPY merge_data.R /home/brazil-death-data/merge_data.R
COPY site_files/ /home/brazil-death-data/site_files
COPY make_site.R /home/brazil-death-data/make_site.R
COPY scrape_results_checker.Rmd /home/brazil-death-data/scrape_results_checker.Rmd


CMD cd /home/brazil-death-data && \
  R -e "source('merge_data.R')" && \
  R -e "source('make_site.R')"
