#!/bin/bash

HDP_CONTAINER_ID=$(docker ps -qf "name=sandbox-hdp")
docker cp ./all.zip $HDP_CONTAINER_ID:/tmp/all.zip
docker cp ./load_data_into_hive.sh $HDP_CONTAINER_ID:/tmp/load_data_into_hive.sh
docker cp ./schema.sql $HDP_CONTAINER_ID:/tmp/schema.sql
docker exec -it $HDP_CONTAINER_ID /bin/bash /tmp/load_data_into_hive.sh
