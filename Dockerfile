# Use the official Microsoft SQL Server 2019 Linux image as a starting point
FROM mcr.microsoft.com/mssql/server:2019-latest-ubuntu

# Set environment variables for SQL Server
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Password123
ENV PATH="/opt/ssis/bin:${PATH}"

# Update the system and install necessary tools
RUN apt-get update && apt-get install -y curl software-properties-common

# Import the public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the SQL Server Ubuntu repository
# SQL Server 2019
RUN add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)"

# Install SQL Server Integration Services
RUN apt-get update && apt-get install -y mssql-server-is

# Configure SSIS in silent mode
RUN /opt/ssis/bin/ssis-conf -n setup && ssis-conf unattended

# Expose SQL Server port
EXPOSE 1433

# Set the default log directory
RUN /opt/mssql/bin/mssql-conf set filelocation.defaultlogdir /var/opt/mssql/log

# Command to run SQL Server
CMD ["sqlservr"]
