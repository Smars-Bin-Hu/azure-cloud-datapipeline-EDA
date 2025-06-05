-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##### Drop all the tables

-- COMMAND ----------

DROP DATABASE IF EXISTS f1_processed CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS f1_processed
LOCATION "/mnt/formula1dl/processed";

-- COMMAND ----------

DROP DATABASE IF EXISTS f1_presentation CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS f1_presentation 
LOCATION "/mnt/formula1dl/presentation";

-- COMMAND ----------

