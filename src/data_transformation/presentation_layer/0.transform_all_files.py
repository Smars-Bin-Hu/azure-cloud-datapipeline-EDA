# Databricks notebook source
dbutils.widgets.text("p_file_date", "2021-03-21")
p_file_date = dbutils.widgets.get("p_file_date")

# COMMAND ----------

v_result = dbutils.notebook.run("1.race_results", 0, {"p_file_date": p_file_date})

# COMMAND ----------

v_result = dbutils.notebook.run("2.driver_standings", 0, {"p_file_date": p_file_date})

# COMMAND ----------

v_result = dbutils.notebook.run("3.constructor_standings", 0, {"p_file_date": p_file_date})

# COMMAND ----------

v_result = dbutils.notebook.run("4.calculated_race_results", 0, {"p_file_date": p_file_date})

# COMMAND ----------

v_result
