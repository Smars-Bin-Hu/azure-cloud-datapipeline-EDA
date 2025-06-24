-- Databricks notebook source
CREATE DATABASE IF NOT EXISTS hive_metastore.f1_presentation 
LOCATION "/mnt/smarsproject0datalake/presentation"

-- COMMAND ----------

DESC DATABASE hive_metastore.f1_presentation;
