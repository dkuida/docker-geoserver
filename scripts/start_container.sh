#!/usr/bin/env bash
CONTAINER = "geoserver"
docker build -t dkuida/$CONTAINER .
docker stop $CONTAINER
docker rm $CONTAINER
docker run -p 8081:8080 --name=geo  -v /mnt/geoserver/data:/mnt/geoserver-data -v /mnt/geoserver/logs:/mnt/logs  -v /mnt/ortophoto:/mnt/ortophoto  --network=geo_nw  -d dkuida/$CONTAINER
