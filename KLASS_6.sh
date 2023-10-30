curl -o ./tmp/ssb_klass_6_utf.csv -H "Accept: text/csv; charset=utf-8" "https://data.ssb.no/api/klass/v1/classifications/6/codes?from=2023-01-01"


# Extract column names from the first line of the CSV
COLUMNS=$(head -n 1 /tmp/data.csv | tr ',' '\n' | sed 's/^/[/; s/$/]/' | tr '\n' ',' | sed 's/,$//')

# Transform column names into SQL table columns
SQL_COLUMNS=$(echo $COLUMNS | sed 's/,/, NVARCHAR(255),/g')
TABLE_COLUMNS="${SQL_COLUMNS}, NVARCHAR(255)"

# Generate SQL CREATE TABLE statement
echo "USE StagingDB;" > /tmp/setup.sql
echo "CREATE TABLE StagingTable (${TABLE_COLUMNS});" >> /tmp/setup.sql
echo "BULK INSERT StagingTable FROM '/tmp/data.csv' WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);" >> /tmp/setup.sql
