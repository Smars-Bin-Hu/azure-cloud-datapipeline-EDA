# Databricks notebook source
# MAGIC %md
# MAGIC # Mount Azure Data Lake Container for the project
# MAGIC Steps to follow
# MAGIC 1. Get client_id, tenant_id and client_secret from key vault.
# MAGIC 2. Set Spark Config with App/ Client Id, Directory/Tenant Id & Secret
# MAGIC 3. Call file system utility mount the storage
# MAGIC 4. Explore other file system utilities related to mount (list all mounts, unmount)

# COMMAND ----------

# MAGIC %run "../../utils/common_functions"

# COMMAND ----------

mount_adls('formula1dl', 'raw')

# COMMAND ----------

mount_adls('formula1dl', 'processed')

# COMMAND ----------

mount_adls('formula1dl', 'presentation')

# COMMAND ----------

mount_adls('formula1dl', 'demo')

# COMMAND ----------

dbutils.fs.unmount("/mnt/formula1dl/demo")

# COMMAND ----------

dbutils.fs.ls("/mnt/formula1dl/raw")

# COMMAND ----------

dbutils.fs.ls("/mnt/formula1dl/processed")

# COMMAND ----------

dbutils.fs.ls("/mnt/formula1dl/presentation")

# COMMAND ----------

dbutils.fs.ls("/mnt/formula1dl/demo")
