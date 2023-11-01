#!/bin/bash

# Create the network
docker network create --attachable --driver bridge sql_network

# Build the custom SQL image (assuming you have a Dockerfile in the current directory)
#docker build --build-arg SQL_SERVER_ROOT=$SQL_SERVER_ROOT -t dev_sqlserver:2019 .
docker build -t dev_sqlserver:2019 .

# Give user mssql the rights to write to bound disk:
sudo chown -R 10001 ./mssql
sudo chown -R 10001 ./init


# Use docker-compose to deploy (assuming you have a docker-compose.yaml in the current directory)
docker-compose up -d
