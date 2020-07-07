#!/bin/bash

#java -Dwebdriver.gecko.driver=/usr/bin/geckodriver -jar ~/.local/share/binman_seleniumserver/generic/3.141.59/selenium-server-standalone-3.141.59.jar -port 4545 &

nohup Rscript test_script.R 2015 2020 "Todos" "Todos" "./merged_data/by_state_yearly.csv" &
p1=$!
echo "Starting job $p1"

nohup Rscript test_script.R 2015 2020 "Todos" "" "./merged_data/by_state_monthly.csv" &
p2=$!
echo "Starting job $p2"

wait $p1
echo "Finished job $p1"

wait $p2
echo "Finished job $p2"