#!/bin/bash

nohup docker-compose up --build > docker.log &

OUT=$(docker-compose ps --filter "status=stopped" --services)

while true

do

 SERVICE_STOPPED=$(docker-compose ps --service --filter "status=stopped")

 if [[ "$SERVICE_STOPPED" == "scraper" ]] 
 then
   break
 fi

 sleep 1m

done

sleep 1m

docker-compose down

