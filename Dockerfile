FROM rocker/r-ver:4.0.0-ubuntu18.04

RUN apt-get update && apt-get install -y libxml2-dev

RUN R -e "install.packages(c('purrr', 'dplyr', 'devtools', 'RSelenium')); \
 devtools::install_github('samirarman/arpenr')"


RUN mkdir /home/brazil-death-data && \
 mkdir /home/brazil-death-data/merged_data

COPY constants.R /home/brazil-death-data/constants.R
COPY make_data.R /home/brazil-death-data/make_data.R
COPY merge_data.R /home/brazil-death-data/merge_data.R

COPY entrypoint.sh /home/brazil-death-data/entrypoint.sh

RUN chmod +x /home/brazil-death-data/entrypoint.sh 

CMD cd /home/brazil-death-data && ./entrypoint.sh
 
