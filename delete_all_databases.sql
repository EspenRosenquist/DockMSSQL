USE master;
GO

DECLARE @dbname NVARCHAR(128), @query NVARCHAR(MAX);
DECLARE db_cursor CURSOR FOR 
SELECT name
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @dbname;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @query = 'DROP DATABASE [' + @dbname + ']';
    EXEC(@query);
    FETCH NEXT FROM db_cursor INTO @dbname;
END;

CLOSE db_cursor;
DEALLOCATE db_cursor;
