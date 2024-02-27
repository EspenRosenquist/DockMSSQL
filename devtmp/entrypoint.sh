#!/bin/bash

# Start SQL Server
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
sleep 30s

# Run the setup script to create the DWH databases
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -d master -i /tmp/setup_dwh.sql

# Keep the container running
tail -f /dev/null
