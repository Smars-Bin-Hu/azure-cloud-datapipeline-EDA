# Databricks notebook source
# MAGIC %md
# MAGIC # Mount Azure Data Lake Container for the project

# COMMAND ----------

# MAGIC %run "./common_functions"

# COMMAND ----------

storage_account_name = 'smarsproject0datalake'

# COMMAND ----------

mount_adls(storage_account_name, 'raw')

# COMMAND ----------

mount_adls(storage_account_name, 'processed')

# COMMAND ----------

mount_adls(storage_account_name, 'presentation')

# COMMAND ----------

dbutils.fs.ls(f"/mnt/{storage_account_name}/raw")

# COMMAND ----------

dbutils.fs.ls(f"/mnt/{storage_account_name}/processed")

# COMMAND ----------

dbutils.fs.ls(f"/mnt/{storage_account_name}/presentation")
