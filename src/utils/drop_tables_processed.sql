-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##### Drop all the tables for `f1_processed` databases

-- COMMAND ----------

DROP DATABASE IF EXISTS f1_processed CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS f1_processed
LOCATION "/mnt/formula1dl/processed";

-- COMMAND ----------