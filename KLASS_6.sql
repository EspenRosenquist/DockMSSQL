USE Staging;

-- create a staging table to hold the data
-- SSB klass 6 - næringsinndelinger
CREATE TABLE KLASS_6
(
    Column1 INT,
    Column2 NVARCHAR(255),
    ...);
    -- Match the columns of your CSV
    BULK INSERT KLASS_6

   FROM '/tmp/klass6.csv'
   WITH
    (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2); 