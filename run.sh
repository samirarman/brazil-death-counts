#!/bin/bash

nohup /usr/local/bin/docker-compose up --build > docker.log &

OUT=$(/usr/local/bin/docker-compose ps --filter "status=stopped" --services)

while true

do

 SERVICE_STOPPED=$(/usr/local/bin/docker-compose ps --service --filter "status=stopped")

 if [[ "$SERVICE_STOPPED" == "scraper" ]] 
 then
   break
 fi

 sleep 1m

done

sleep 1m

/usr/local/bin/docker-compose down

