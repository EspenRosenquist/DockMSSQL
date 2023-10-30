# Use the official Microsoft SQL Server 2019 Linux image as a starting point
FROM mcr.microsoft.com/mssql/server:2019-latest

# Set environment variables for SQL Server
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Password123
ENV PATH="/opt/ssis/bin:${PATH}"

# If we use volumes, the owner of this directory
# is root.  So we need to set them to mssql, but
# at this point they do not yet exist.
# Create the directory first, and set the permissions.
USER root
RUN mkdir -p /var/opt/mssql/data
RUN chown -R mssql: /var/opt/mssql/data

USER mssql

# Update the system and install necessary tools
USER root
RUN apt-get update && apt-get install -y curl software-properties-common

# Import the public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the SQL Server Ubuntu repository
# SQL Server 2019 does not have SSIS repo for Ubuntu 20.04
RUN add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"

# Install SQL Server Integration Services
# It is not possible to run SSIS in a Windows container
RUN apt-get update 
RUN apt-get install -y mssql-server-is

# Configure SSIS in silent mode
# Forego this step for this first installation and rather get the conf file after manual 
# RUN /opt/ssis/bin/ssis-conf -n setup && ssis-conf unattended

# Expose SQL Server port
EXPOSE 1433

# Set the default log directory
# RUN /opt/mssql/bin/mssql-conf set filelocation.defaultlogdir /var/opt/mssql/log

# Command to run SQL Server
CMD ["sqlservr"]
