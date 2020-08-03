#!/bin/sh

sleep 1m

nohup Rscript make_data.R 2015 2020 "Todos" "" "Todos" "./merged_data/by_state_yearly.csv" > /home/brazil-death-data/merged_data/by_state_yearly.out &
job1=$!
echo "Starting job $job1"


