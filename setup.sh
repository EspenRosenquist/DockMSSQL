#!/bin/bash

# Create the network
docker network create --attachable --driver bridge sql_network

# Build the custom SQL image (assuming you have a Dockerfile in the current directory)
#docker build --build-arg SQL_SERVER_ROOT=$SQL_SERVER_ROOT -t dev_sqlserver:2019 .
docker build -t dev_sqlserver:2019 .

# Use docker-compose to deploy (assuming you have a docker-compose.yaml in the current directory)
docker-compose up -d


docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourPassword' -p 1433:1433 -p 1434:1434/udp --name mssql_container -d mcr.microsoft.com/mssql/server
