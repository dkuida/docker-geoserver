#!/bin/bash
CONTAINER="geo"
IMAGE="dkuida/geoserver"
docker build -t ${IMAGE} .
docker stop ${CONTAINER}
docker rm ${CONTAINER}
docker run -p 8081:8080 --name=geo -v /mnt/geoserver/data:/mnt/geoserver-data -v /mnt/geoserver/logs:/mnt/logs  -v /mnt/ortophoto:/mnt/ortophoto  --network=geo_nw -d ${IMAGE}

