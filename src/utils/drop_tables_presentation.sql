-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##### Drop all the tables for `f1_presentation` databases

-- COMMAND ----------

DROP DATABASE IF EXISTS f1_presentation CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS f1_presentation 
LOCATION "/mnt/formula1dl/presentation";

-- COMMAND ----------

