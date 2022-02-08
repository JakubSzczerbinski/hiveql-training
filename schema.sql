CREATE DATABASE raw;

CREATE EXTERNAL TABLE IF NOT EXISTS raw.employee
   (
       id String,
       name String,
       birthday Timestamp,
       dt String,
       salary String,
       extras String,
       actual String,
       city String,
       company_id String,
       position String
   )
   ROW FORMAT DELIMITED
   FIELDS TERMINATED BY ','
   STORED AS TEXTFILE
   LOCATION '/user/hive/employee';

CREATE EXTERNAL TABLE IF NOT EXISTS raw.company
   (
       id Int,
       name String,
       industry String,
       city String,
       owner_id String,
       logo String,
       phrase String
   )
   ROW FORMAT DELIMITED
   FIELDS TERMINATED BY ','
   STORED AS TEXTFILE
   LOCATION '/user/hive/company';

CREATE EXTERNAL TABLE IF NOT EXISTS raw.exchange_rate
   (
       from_currency String,
       to_currency String,
       dt Date,
       rate Double
   )
   ROW FORMAT DELIMITED
   FIELDS TERMINATED BY ','
   STORED AS TEXTFILE
   LOCATION '/user/hive/exchange';
