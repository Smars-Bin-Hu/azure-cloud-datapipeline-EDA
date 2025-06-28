-- Databricks notebook source
CREATE DATABASE IF NOT EXISTS hive_metastore.f1_presentation 
LOCATION "/mnt/smarsproject0datalake/presentation"

-- COMMAND ----------

DESC DATABASE hive_metastore.f1_presentation;

-- COMMAND ----------

SHOW TABLES FROM hive_metastore.f1_presentation;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## create tables under database `f1_presentation`

-- COMMAND ----------

-- restore schema hive_metastore.f1_presentation.calculated_race_results in the hive metastore
CREATE TABLE hive_metastore.f1_presentation.calculated_race_results (
  race_year INT,
  team_name STRING,
  driver_id INT,
  driver_name STRING,
  race_id INT,
  position INT,
  points INT,
  calculated_points INT,
  created_date TIMESTAMP,
  updated_date TIMESTAMP)
USING delta 
LOCATION '/mnt/smarsproject0datalake/presentation/calculated_race_results'
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------


-- restore schema hive_metastore.f1_presentation.constructor_standings in the hive metastore
CREATE TABLE hive_metastore.f1_presentation.constructor_standings (
  race_year INT,
  team STRING,
  total_points DOUBLE,
  wins BIGINT,
  rank INT)
USING delta
PARTITIONED BY (race_year) 
LOCATION '/mnt/smarsproject0datalake/presentation/constructor_standings'
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------


-- restore schema hive_metastore.f1_presentation.driver_standings in the hive metastore
CREATE TABLE hive_metastore.f1_presentation.driver_standings (
  race_year INT,
  driver_name STRING,
  driver_nationality STRING,
  total_points DOUBLE,
  wins BIGINT,
  rank INT)
USING delta
PARTITIONED BY (race_year)
LOCATION '/mnt/smarsproject0datalake/presentation/driver_standings'
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------

DROP TABLE IF EXISTS hive_metastore.f1_presentation.driver_standings;

CREATE TABLE hive_metastore.f1_presentation.driver_standings
USING DELTA
LOCATION '/mnt/smarsproject0datalake/presentation/driver_standings';

select * from hive_metastore.f1_presentation.driver_standings;

-- COMMAND ----------


-- restore schema hive_metastore.f1_presentation.race_results in the hive metastore
CREATE TABLE hive_metastore.f1_presentation.race_results (
  race_id INT,
  race_year INT,
  race_name STRING,
  race_date TIMESTAMP,
  circuit_location STRING,
  driver_name STRING,
  driver_number INT,
  driver_nationality STRING,
  team STRING,
  grid INT,
  fastest_lap INT,
  race_time STRING,
  points FLOAT,
  position INT,
  file_date STRING,
  created_date TIMESTAMP)
USING delta
PARTITIONED BY (race_id)
LOCATION '/mnt/smarsproject0datalake/presentation/race_results'
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------

select * from hive_metastore.f1_presentation.race_results;
