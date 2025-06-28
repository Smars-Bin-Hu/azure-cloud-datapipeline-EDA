-- Databricks notebook source
CREATE DATABASE IF NOT EXISTS hive_metastore.f1_processed
LOCATION "/mnt/smarsproject0datalake/processed"

-- COMMAND ----------

DESC DATABASE hive_metastore.f1_processed;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## create tables under database `f1_processed`

-- COMMAND ----------

-- restore schema hive_metastore.f1_processed.circuits in the hive metastore
CREATE TABLE hive_metastore.f1_processed.circuits (
  circuit_id INT,
  circuit_ref STRING,
  name STRING,
  location STRING,
  country STRING,
  latitude DOUBLE,
  longitude DOUBLE,
  altitude INT,
  data_source STRING,
  file_date STRING,
  ingestion_date TIMESTAMP)
USING delta
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------


-- restore schema hive_metastore.f1_processed.constructors in the hive metastore
CREATE TABLE hive_metastore.f1_processed.constructors (
  constructor_id INT,
  constructor_ref STRING,
  name STRING,
  nationality STRING,
  data_source STRING,
  file_date STRING,
  ingestion_date TIMESTAMP)
USING delta
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);


-- COMMAND ----------

-- restore schema hive_metastore.f1_processed.drivers in the hive metastore
CREATE TABLE hive_metastore.f1_processed.drivers (
  driver_id INT,
  driver_ref STRING,
  number INT,
  code STRING,
  name STRING,
  dob DATE,
  nationality STRING,
  ingestion_date TIMESTAMP,
  data_source STRING,
  file_date STRING)
USING delta
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------

-- restore schema hive_metastore.f1_processed.lap_times in the hive metastore
CREATE TABLE hive_metastore.f1_processed.lap_times (
  race_id INT,
  driver_id INT,
  lap INT,
  position INT,
  time STRING,
  milliseconds INT,
  ingestion_date TIMESTAMP,
  data_source STRING,
  file_date STRING)
USING delta
PARTITIONED BY (race_id)
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------

-- restore schema hive_metastore.f1_processed.pit_stops in the hive metastore
CREATE TABLE hive_metastore.f1_processed.pit_stops (
  race_id INT,
  driver_id INT,
  stop STRING,
  lap INT,
  time STRING,
  duration STRING,
  milliseconds INT,
  ingestion_date TIMESTAMP,
  data_source STRING,
  file_date STRING)
USING delta
PARTITIONED BY (race_id)
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);


-- COMMAND ----------

-- restore schema hive_metastore.f1_processed.qualifying in the hive metastore
CREATE TABLE hive_metastore.f1_processed.qualifying (
  qualify_id INT,
  race_id INT,
  driver_id INT,
  constructor_id INT,
  number INT,
  position INT,
  q1 STRING,
  q2 STRING,
  q3 STRING,
  ingestion_date TIMESTAMP,
  data_source STRING,
  file_date STRING)
USING delta
PARTITIONED BY (race_id)
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------


-- restore schema hive_metastore.f1_processed.races in the hive metastore
CREATE TABLE hive_metastore.f1_processed.races (
  race_id INT,
  race_year INT,
  round INT,
  circuit_id INT,
  name STRING,
  ingestion_date TIMESTAMP,
  race_timestamp TIMESTAMP)
USING delta
PARTITIONED BY (race_year)
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);

-- COMMAND ----------


-- restore schema hive_metastore.f1_processed.results in the hive metastore
CREATE TABLE hive_metastore.f1_processed.results (
  result_id INT,
  race_id INT,
  driver_id INT,
  constructor_id INT,
  number INT,
  grid INT,
  position INT,
  position_text STRING,
  position_order INT,
  points FLOAT,
  laps INT,
  time STRING,
  milliseconds INT,
  fastest_lap INT,
  rank INT,
  fastest_lap_time STRING,
  fastest_lap_speed FLOAT,
  data_source STRING,
  file_date STRING,
  ingestion_date TIMESTAMP)
USING delta
PARTITIONED BY (race_id)
TBLPROPERTIES (
  'delta.minReaderVersion' = '1',
  'delta.minWriterVersion' = '2'
);
