-- Databricks notebook source
-- MAGIC %python
-- MAGIC html = """<h1 style="color:Black;text-align:center;font-family:Ariel">Dominant Formula 1 Teams of All Time</h1>"""
-- MAGIC displayHTML(html)

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW v_dominant_teams
AS
SELECT team_name,
       COUNT(1) AS total_races,
       SUM(calculated_points) AS total_points,
       AVG(calculated_points) AS avg_points,
       RANK() OVER(ORDER BY AVG(calculated_points) DESC) team_rank
  FROM f1_presentation.calculated_race_results
GROUP BY team_name
HAVING COUNT(1) >= 100
ORDER BY avg_points DESC

-- COMMAND ----------

SELECT * FROM v_dominant_teams;

-- COMMAND ----------

SELECT race_year, 
       team_name,
       COUNT(1) AS total_races,
       SUM(calculated_points) AS total_points,
       AVG(calculated_points) AS avg_points
  FROM f1_presentation.calculated_race_results
 WHERE team_name IN (SELECT team_name FROM v_dominant_teams WHERE team_rank <= 5)
GROUP BY race_year, team_name
ORDER BY race_year, avg_points DESC

-- COMMAND ----------

SELECT race_year, 
       team_name,
       COUNT(1) AS total_races,
       SUM(calculated_points) AS total_points,
       AVG(calculated_points) AS avg_points
  FROM f1_presentation.calculated_race_results
 WHERE team_name IN (SELECT team_name FROM v_dominant_teams WHERE team_rank <= 5)
GROUP BY race_year, team_name
ORDER BY race_year, avg_points DESC

-- COMMAND ----------

