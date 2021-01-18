#!/bin/bash

# Give time to selenium standalone to start up
sleep 1m

# by_state_yearly and by_state_monthly
nohup Rscript make_data.R 2015 2021 "Todos" "" "Todos" "./merged_data/by_state_yearly.csv" > /home/brazil-death-data/merged_data/by_state_yearly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2015 2021 "1" "12" "Todos" "./merged_data/by_state_monthly.csv" > /home/brazil-death-data/merged_data/by_state_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $job1"

wait $job2
echo "Finished job $job2"

# by_city_yearly
nohup Rscript make_data.R 2015 2021 "Todos" "" "" "./merged_data/by_city_yearly.csv" > /home/brazil-death-data/merged_data/by_city_yearly.out &
job=$!
echo "Starting job $job"

wait $job
echo "Finished job $job"

# by_city_monthly from month 1 to 3
nohup Rscript make_data.R 2015 2017 "1" "3" "" "./merged_data/by_city_monthly1.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2018 2021 "1" "3" "" "./merged_data/by_city_monthly2.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $job1"
wait $job2
echo "Finished job $job2"

# by_city_monthly from month 4 to 6
nohup Rscript make_data.R 2015 2017 "4" "6" "" "./merged_data/by_city_monthly3.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2018 2021 "4" "6" "" "./merged_data/by_city_monthly4.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $job1"
wait $job2
echo "Finished job $job2"


# by_city_monthly from month 7 to 9
nohup Rscript make_data.R 2015 2017 "7" "9" "" "./merged_data/by_city_monthly5.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2018 2021 "7" "9" "" "./merged_data/by_city_monthly6.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $job1"
wait $job2
echo "Finished job $job2"

# by_city_monthly 10 to 12
nohup Rscript make_data.R 2015 2017 "10" "12" "" "./merged_data/by_city_monthly7.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job1=$!
echo "Starting job $job1"

nohup Rscript make_data.R 2018 2021 "10" "12" "" "./merged_data/by_city_monthly8.csv" > /home/brazil-death-data/merged_data/by_city_monthly.out &
job2=$!
echo "Starting job $job2"

wait $job1
echo "Finished job $job1"

wait $job2
echo "Finished job $job2"

# merge all by_city_monthly files
nohup Rscript merge_data.R > /home/brazil-death-data/merged_data/merge_data.out

# remove unnecessary files
for i in {1..8}
do
 rm /home/brazil-death-data/merged_data/by_city_monthly$i.csv
done

Rscript last_run_check.R >> /home/brazil-death-data/merged_data/last_run.txt
