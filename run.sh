#!/bin/bash


nohup java -Dwebdriver.gecko.driver=/usr/bin/geckodriver -jar /home/.local/share/binman_seleniumserver/generic/3.141.59/selenium-server-standalone-3.141.59.jar -port 4545 > ./merged_data/out/server.out &

sleep 30

nohup Rscript make_data.R 2015 2020 "Todos" "" "Todos" "./merged_data/by_state_yearly.csv" > ./merged_data/out/by_state_yearly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2015 2020 "1" "12" "Todos" "./merged_data/by_state_monthly.csv" > ./merged_data/out/by_state_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $job1"

wait $job2
echo "Finished job $job2"


nohup Rscript make_data.R 2015 2020 "Todos" "" "" "./merged_data/by_city_yearly.csv" > ./merged_data/out/by_city_yearly.out &
job=$!
echo "Starting job $job"

wait $job
echo "Finished job $job"


nohup Rscript make_data.R 2015 2020 "1" "3" "" "./merged_data/by_city_monthly1.csv" > ./merged_data/out/by_city_monthly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2015 2020 "4" "6" "" "./merged_data/by_city_monthly2.csv" > ./merged_data/out/by_city_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $j0b1"
wait $job2
echo "Finished job $job2"



nohup Rscript make_data.R 2015 2020 "7" "9" "" "./merged_data/by_city_monthly3.csv" > ./merged_data/out/by_city_monthly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2015 2020 "10" "12" "" "./merged_data/by_city_monthly4.csv" > ./merged_data/out/by_city_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $job1"

wait $job2
echo "Finished job $job2"


nohup Rscript merge_data.R > ./merged_data/out/merge_data.out

for i in {1..4}
do
 rm ./merged_data/by_city_monthly$i.csv
done

# Clean up
# =====================================================
pkill firefox
pkill geckodriver
pkill java
