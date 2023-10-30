# Installation path of server
# Default: /opt/mssql
# ARG SQL_SERVER_ROOT=/opt/mssql

# https://github.com/microsoft/mssql-docker/blob/master/linux/preview/examples/mssql-server-linux-non-root/Dockerfile-2019
# Use the official Microsoft SQL Server 2019 Linux image as a starting point
FROM mcr.microsoft.com/mssql/server:2019-latest

# Switch to user root for permission changes
USER root

# Create directories
RUN mkdir -p -m 770 /var/opt/mssql/data && \
    mkdir -p -m 770 /var/opt/mssql/log && \
    mkdir -p -m 770 /var/opt/mssql/backup && \
    mkdir -p -m 770 /var/opt/mssql/secrets
RUN chgrp -R 0 /var/opt/mssql

# Update permissions for mssql user
RUN chown -R mssql /var/opt/mssql

# Grant sql the permissions to connect to ports <1024 as a non-root user
RUN setcap 'cap_net_bind_service+ep' /opt/mssql/bin/sqlservr && \
    # Allow dumps from the non-root process
    setcap 'cap_sys_ptrace+ep' /opt/mssql/bin/paldumper && \
    setcap 'cap_sys_ptrace+ep' /usr/bin/gdb

# Add an ldconfig file because setcap causes the os to remove LD_LIBRARY_PATH
# and other env variables that control dynamic linking
RUN mkdir -p /etc/ld.so.conf.d && touch /etc/ld.so.conf.d/mssql.conf && \
    echo -e "# mssql libs\n/opt/mssql/lib" >> /etc/ld.so.conf.d/mssql.conf && \
    ldconfig

# Expose SQL Server port
EXPOSE 1433

# Copy the database setup script to the container
COPY setup_dwh.sql /tmp/setup_dwh.sql

# Copy the entrypoint script to the container
COPY entrypoint.sh /tmp/entrypoint.sh

# Grant execute permissions to the entrypoint script
RUN chmod +x /tmp/entrypoint.sh

# Switch back to mssql user for runtime
USER mssql

# Command to run SQL Server
# Use the entrypoint script as the default command to execute
CMD ["/tmp/entrypoint.sh"]
