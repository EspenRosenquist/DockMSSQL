#!/bin/bash

# Create the network
docker network create --attachable --driver bridge sql_network

# Build the custom SQL image (assuming you have a Dockerfile in the current directory)
docker build -t SQLserver:2019 .

# Use docker-compose to deploy (assuming you have a docker-compose.yaml in the current directory)
docker-compose up -d
