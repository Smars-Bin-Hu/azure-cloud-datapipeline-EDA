# Databricks notebook source
v_result = dbutils.notebook.run("1.race_results", 0, {"p_data_source": "Ergast API", "p_file_date": "2021-04-18"})

# COMMAND ----------

v_result

# COMMAND ----------

v_result = dbutils.notebook.run("2.driver_standings", 0, {"p_data_source": "Ergast API", "p_file_date": "2021-04-18"})

# COMMAND ----------

v_result

# COMMAND ----------

v_result = dbutils.notebook.run("3.constructor_standings", 0, {"p_data_source": "Ergast API", "p_file_date": "2021-04-18"})

# COMMAND ----------

v_result

# COMMAND ----------

v_result = dbutils.notebook.run("4.calculated_race_results", 0, {"p_data_source": "Ergast API", "p_file_date": "2021-04-18"})

# COMMAND ----------

v_result