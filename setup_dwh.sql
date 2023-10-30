-- Create Staging Database
IF NOT EXISTS (SELECT *
FROM sys.databases
WHERE name = 'Staging')
BEGIN
    CREATE DATABASE Staging
    ON
    ( NAME = Staging_dat,
        FILENAME = '/var/opt/mssql/data/Staging.mdf',
        SIZE = 10GB,
        MAXSIZE = 50GB,
        FILEGROWTH = 1GB )
    LOG ON
    ( NAME = Staging_log,
        FILENAME = '/var/opt/mssql/data/Staging.ldf',
        SIZE = 1GB,
        MAXSIZE = 5GB,
        FILEGROWTH = 1GB );
END
GO

-- Create Datavarehus Database
IF NOT EXISTS (SELECT *
FROM sys.databases
WHERE name = 'Datavarehus')
BEGIN
    CREATE DATABASE Datavarehus
    ON
    ( NAME = Datavarehus_dat,
        FILENAME = '/var/opt/mssql/data/Datavarehus.mdf',
        SIZE = 10GB,
        MAXSIZE = 50GB,
        FILEGROWTH = 1GB )
    LOG ON
    ( NAME = Datavarehus_log,
        FILENAME = '/var/opt/mssql/data/Datavarehus.ldf',
        SIZE = 1GB,
        MAXSIZE = 5GB,
        FILEGROWTH = 1GB );
END
GO

-- Create Datamart Database
IF NOT EXISTS (SELECT *
FROM sys.databases
WHERE name = 'Datamart')
BEGIN
    CREATE DATABASE Datamart
    ON
    ( NAME = Datamart_dat,
        FILENAME = '/var/opt/mssql/data/Datamart.mdf',
        SIZE = 10GB,
        MAXSIZE = 50GB,
        FILEGROWTH = 1GB )
    LOG ON
    ( NAME = Datamart_log,
        FILENAME = '/var/opt/mssql/data/Datamart.ldf',
        SIZE = 1GB,
        MAXSIZE = 5GB,
        FILEGROWTH = 1GB );
END
GO