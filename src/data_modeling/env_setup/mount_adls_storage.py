# Databricks notebook source
# MAGIC %run "../utils/common_functions"

# COMMAND ----------

storage_account_name = "formula1dl"
client_id            = dbutils.secrets.get(scope="formula1-scope", key="databricks-app-client-id")
tenant_id            = dbutils.secrets.get(scope="formula1-scope", key="databricks-app-tenant-id")
client_secret        = dbutils.secrets.get(scope="formula1-scope", key="databricks-app-client-secret")

# mount configuration dictionary
configs = {"fs.azure.account.auth.type": "OAuth",
           "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
           "fs.azure.account.oauth2.client.id": f"{client_id}",
           "fs.azure.account.oauth2.client.secret": f"{client_secret}",
           "fs.azure.account.oauth2.client.endpoint": f"https://login.microsoftonline.com/{tenant_id}/oauth2/token"}

# COMMAND ----------

mount_adls("raw", storage_account_name, configs)

# COMMAND ----------

mount_adls("processed", storage_account_name, configs)

# COMMAND ----------

mount_adls("presentation", storage_account_name, configs)

# COMMAND ----------

mount_adls("demo", storage_account_name, configs)

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

# COMMAND ----------

