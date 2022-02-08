#!/bin/bash

QUERY_PATH=$1
QUERY_NAME=$(basename "$QUERY_PATH")
HDP_CONTAINER_ID=$(docker ps -qf "name=sandbox-hdp")
docker cp $QUERY_PATH $HDP_CONTAINER_ID:/tmp/$QUERY_NAME
docker exec -it $HDP_CONTAINER_ID beeline -f /tmp/$QUERY_NAME
