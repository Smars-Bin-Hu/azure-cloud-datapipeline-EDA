# Databricks notebook source
from pyspark.sql.functions import current_timestamp

def add_ingestion_date(input_df):
  """
    Add ingestion date column to the input dataframe.
    
    Args:
        input_df: Input PySpark DataFrame
        
    Returns:
        PySpark DataFrame with ingestion_date column added
  """
  output_df = input_df.withColumn("ingestion_date", current_timestamp())
  return output_df

# COMMAND ----------

def re_arrange_partition_column(input_df, partition_column):
  """
    Rearrange columns in dataframe to put partition column at the end.
    
    Args:
        input_df: Input PySpark DataFrame
        partition_column: Name of the partition column
        
    Returns:
        PySpark DataFrame with reordered columns
  """
  column_list = []
  for column_name in input_df.schema.names:
    if column_name != partition_column:
      column_list.append(column_name)
  column_list.append(partition_column)
  output_df = input_df.select(column_list)
  return output_df

# COMMAND ----------

def overwrite_partition(input_df, db_name, table_name, partition_column):
  """
    Overwrite partition in existing table or create new table.
    
    Args:
        input_df: Input PySpark DataFrame
        db_name: Database name
        table_name: Table name
        partition_column: Name of the partition column
        
    Returns:
        None
  """
  output_df = re_arrange_partition_column(input_df, partition_column)
  spark.conf.set("spark.sql.sources.partitionOverwriteMode","dynamic")
  if (spark._jsparkSession.catalog().tableExists(f"{db_name}.{table_name}")):
    output_df.write.mode("overwrite").insertInto(f"{db_name}.{table_name}")
  else:
    output_df.write.mode("overwrite").partitionBy(partition_column).format("parquet").saveAsTable(f"{db_name}.{table_name}")

# COMMAND ----------

def df_column_to_list(input_df, column_name):
  """
    Convert a dataframe column to a list of distinct values.
    
    Args:
        input_df: Input PySpark DataFrame
        column_name: Name of the column to convert
        
    Returns:
        List of distinct values from the specified column
  """
  df_row_list = input_df.select(column_name) \
                        .distinct() \
                        .collect()
  
  column_value_list = [row[column_name] for row in df_row_list]
  return column_value_list

# COMMAND ----------

from delta.tables import DeltaTable

def merge_delta_data(input_df, db_name, table_name, folder_path, merge_condition, partition_column):
  """
    Merge data into existing delta table or create new one.
    
    Args:
        input_df: Input PySpark DataFrame
        db_name: Database name
        table_name: Table name
        folder_path: Path to the folder containing the table
        merge_condition: Condition for merging data
        partition_column: Name of the partition column
        
    Returns:
        None
  """
  spark.conf.set("spark.databricks.optimizer.dynamicPartitionPruning","true")

  if (spark._jsparkSession.catalog().tableExists(f"hive_metastore.{db_name}.{table_name}")):
    deltaTable = DeltaTable.forPath(spark, f"{folder_path}/{table_name}")
    deltaTable.alias("tgt").merge(
        input_df.alias("src"),
        merge_condition) \
      .whenMatchedUpdateAll()\
      .whenNotMatchedInsertAll()\
      .execute()
  else:
    input_df.write.partitionBy(partition_column).format("delta").saveAsTable(f"hive_metastore.{db_name}.{table_name}")

# COMMAND ----------

def mount_adls(storage_account_name, container_name):
    # # Get secrets from Key Vault
    account_key = dbutils.secrets.get(scope="smars-project-scope", key="smarsproject0datalake-access-key")

    # # Set spark configurations
    configs = {f"fs.azure.account.key.{storage_account_name}.blob.core.windows.net": f"{account_key}"}

    # Unmount the mount point if it already exists
    if any(mount.mountPoint == f"/mnt/{storage_account_name}/{container_name}" for mount in dbutils.fs.mounts()):
        dbutils.fs.unmount(f"/mnt/{storage_account_name}/{container_name}")
    
    # Mount the storage account container
    dbutils.fs.mount(
      source = f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net/",
      mount_point = f"/mnt/{storage_account_name}/{container_name}",
      extra_configs = configs
    )
    
    display(dbutils.fs.mounts())
  

# COMMAND ----------

from delta.tables import DeltaTable
dt = DeltaTable.forPath(spark, "/mnt/smarsproject0datalake/presentation/driver_standings")
dt.history(20).show(truncate=False)   # 最近 20 条

