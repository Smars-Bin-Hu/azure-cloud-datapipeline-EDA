-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##### Drop all the tables for `f1_processed` databases

-- COMMAND ----------

DROP DATABASE IF EXISTS hive_metastore.f1_processed CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS hive_metastore.f1_processed
LOCATION "/mnt/smarsproject0datalake/processed";
