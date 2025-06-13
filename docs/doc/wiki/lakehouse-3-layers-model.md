# Lakehouse 3 layer model

Raw - Processed - Presentation




## Data Ingestion Requirements

- Ingest all data files into Data lake
- Ingested data must have the schema applied
- Ingested data must have audit columns
- Ingested data must be stored in columnar fomart (i.e. Parquet)
- Must be able to analyze the ingested data via SQL
- Ingestion logic must be able to handle incremental load

## Data Transformation Requirements

- Join the key information required for reporting to create a new table
- Join the key information required for analysis to create a new table
- transformed tables must have audit columns
- must be able to analyze the transformed data via SQL
- Transformed data must be stored in columnar format (i.e. Parquet)
- Transformation logic must be able to handle increamental load

## Reporting & Analysis Requirements

- Driver Standings
- Constructor Standings
- Dominant Drivers
- Dominant Teams
- Visualize the outputs
- Create Databricks Dashboard

## Scheduling Requirements

- Scheduled to run every Sunday 10PM
- Ability to monitor pipelines
- Ability to re-run failed pipelines
- Ability to setup alerts on failure

## Other Requirements

- Ability to delete individual records
- Ability to see history and time travel
- Ability to roll back to a previous version