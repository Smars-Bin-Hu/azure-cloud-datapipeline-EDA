-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##### Drop all the tables for `f1_presentation` databases

-- COMMAND ----------

DROP DATABASE IF EXISTS hive_metastore.f1_presentation CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS hive_metastore.f1_presentation 
LOCATION "/mnt/smarsproject0datalake/presentation";
