-- Databricks notebook source
CREATE DATABASE IF NOT EXISTS hive_metastore.f1_processed
LOCATION "/mnt/smarsproject0datalake/processed"

-- COMMAND ----------

DESC DATABASE hive_metastore.f1_processed;
