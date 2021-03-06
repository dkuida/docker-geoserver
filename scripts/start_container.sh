#!/bin/bash
set -e
CONTAINER="geo"
IMAGE="dkuida/geoserver"
docker build -t ${IMAGE} .
set +e
docker stop ${CONTAINER}
docker rm ${CONTAINER}
docker run -p 8081:8080 --name=${CONTAINER} \
-v /mnt/geoserver/data:/mnt/geoserver-data \
-v /mnt/1Tb/geoserver-cache:/mnt/cache \
-v /mnt/geoserver/logs:/mnt/logs  \
-v /mnt/ortophoto:/mnt/ortophoto  \
-v /mnt/geoserver-cache:/mnt/geoserver-data/gwc  \
--network=geo_nw -d ${IMAGE}

