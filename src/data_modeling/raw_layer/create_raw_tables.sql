-- Databricks notebook source
CREATE DATABASE IF NOT EXISTS hive_metastore.f1_raw 
LOCATION "/mnt/smarsproject0datalake/raw"

-- COMMAND ----------

DESC DATABASE hive_metastore.f1_raw;
