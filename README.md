
![1](https://github.com/user-attachments/assets/6334082b-698b-43d4-92a6-d07617248896)
<p align="center"><em>👆 click the picture to see the presentation video! </em></p>

# Cloud Native Data Pipeline on Azure Databricks for Exploratory Data Analysis

<p align="center">
  <a href="https://github.com/Smars-Bin-Hu/EComDWH-BatchDataProcessingPlatform/blob/main/src/README/quick-start.md">
      <img src="https://img.shields.io/badge/project-🚀quick_start-blue?style=for-the-badge&logo=github" alt="Sublime's custom image"/>
  </a>
  <a href="https://github.com/Smars-Bin-Hu/EComDWH-Pipeline/tree/main/src">
      <img src="https://img.shields.io/badge/project-source_code-green?style=for-the-badge&logo=github" alt="Sublime's custom image"/>
  </a>
  <a href="https://github.com/Smars-Bin-Hu/EComDWH-BatchDataProcessingPlatform/wiki">
      <img src="https://img.shields.io/badge/project-all%20documents-red?style=for-the-badge&logo=github" image"/>
   </a>
</p>

<p align="center">
   <img src="https://img.shields.io/badge/Azure_cloud-66CCFF?style=for-the-badge"/>
   <img src="https://img.shields.io/badge/azure_data_factory-017CEE?style=for-the-badge&logoColor=white"/>
   <img src="https://img.shields.io/badge/ADLS_gen2-017CEE?style=for-the-badge&logoColor=white"/>
   <img src="https://img.shields.io/badge/unity_catelog-f2f2e8?style=for-the-badge&color=f2f2e8"/>
   <img src="https://img.shields.io/badge/databricks-252523?style=for-the-badge&logo=databricks&color=252523"/>
   <img src="https://img.shields.io/badge/delta_lake-red?style=for-the-badge&color=red"/>
   <img src="https://img.shields.io/badge/tableau-eceeea?style=for-the-badge&logo=tableau&logoColor=blue"/>
   <img src="https://img.shields.io/badge/python-blue?style=for-the-badge&logo=python&logoColor=yellow&logoSize=auto&color=blue"/>
   <img src="https://img.shields.io/badge/apache_spark-3.3.0-blue?style=for-the-badge&logo=apachespark&logoSize=auto&color=white"/>
</p>

This project presents an end-to-end data pipeline and analytics workflow centered around Formula 1 racing data, with a strong emphasis on exploratory data analysis (EDA) and visualization. It is structured into two core components: **cloud-native data engineering and analytical data visualization.**

On the **data engineering** side, we leverage Azure Cloud services to build a scalable and automated data pipeline following the **medallion architecture (bronze, silver, gold layers)**. Raw data is ingested and stored in **Azure Data Lake Storage Gen2**, processed and transformed using **Azure Databricks** with **PySpark** and **SparkSQL**, and managed through **Delta Lake** to ensure ACID transactions and schema enforcement. We incorporate **Unity Catalog** for data governance and access control, while **Azure Data Factory** orchestrates the workflow to achieve full automation. The architecture demonstrates cloud-native best practices such as decoupled storage and compute, batch-stream unification, and automated job triggering—effectively realizing a modern **Lakehouse** design.

On the **data analysis and visualization** front, we utilize both **Tableau** and **Python** for different analytical tasks. Tableau connects directly to the Databricks-backed gold layer, enabling real-time, **interactive BI dashboards** that cover historical driver and team rankings, national-level aggregations, and top driver trends over time. For deeper statistical insights, Python’s **Matplotlib** and **Seaborn** are used to explore multidimensional relationships, such as starting grid vs. final position, fastest lap vs. points, and stability of driver performance across seasons.

By integrating enterprise-grade data infrastructure with intuitive visual storytelling, this project not only showcases advanced data engineering capabilities but also delivers valuable insights into the world of Formula 1 through rich, interactive visualizations.

| ✅ Core Feature | 🔥 Core Highlights | 📦 Deliverables |
|----------------|--------------------|-----------------|
| **1. [Azure Data Pipeline Setup](#)** | - Production-grade pipeline using Azure services <br> - Step-by-step deployment guide with open-sourced code <br> - One-click deployment via Azure DevOps `.json` templates | - Azure DevOps `.json` templates: `/devops/` folder: pipeline configs <br> - `services_architecture.png` azure services architecture overview <br> |
| **2. [Databricks ETL Workflow](#)** | - End-to-end ETL with PySpark & SparkSQL <br> - Medallion architecture modeling (Bronze → Silver → Gold) <br> - Open-source Databricks Notebooks and scripts | - `/src/` and `/dbc/azure-cloud-datapipeline-EDA.dbc` files for direct import <br> - `medallion_diagram.png` architecture overview - Modular ETL: data_ingestion, data_transformation, data_modeling, data_analysis, config, utils |
| **3. [Data Orchestration via ADF](#)** | - Workflow automation with Azure Data Factory <br> - Scheduled, triggered pipelines <br> - Full `.json` export for reproducibility | - `/ADF/` folder with pipeline `.json` files <br> - Import-ready ADF workflow <br> - Setup & execution flow in `/docs/dev/ADF-development-steps.md` |
| **4. [BI Dashboard & EDA](#)** | - Tableau Public dashboard for interactive exploration <br> - Deep EDA with Python (Matplotlib, Seaborn) <br> - Accompanying analysis report in PDF format | - Tableau Public link & screenshots <br> - `/visualization/via_python/ADF-development-steps.md` for visual/statistical analysis <br> - `/visualization/f1_analysis_report.pdf` with insights |
| **5. [Documentation & Knowledge Sharing](#)** | - Azure-native data engineering tutorials <br> - Concepts explained: Lakehouse, Delta Lake, Unity Catalog, Medallion Layers <br> - Best practices & reusable code patterns | - `/docs/dev/*.md`: Step-by-step deployment guides <br> - `/docs/wiki/*.md`: Big data & Azure concepts explanations |

## Project Structure

```bash
/bigdata-datawarehouse-project
├── 📄 README.md                           # Project overview and documentation links
├── 📄 LICENSE                             # MIT License file
├── 📁 ADF/                                # Azure Data Factory Import-Ready Workflow .json Templates
├── 📁 devops/                             # Azure All Services Deployment .json Templates
│   ├── 📁 ADF_src/                        # Azure Data Factory Import-Ready Templates
│   ├── 📁 azure_deployment/               # Azure Cloud Services&Resources Import-Ready Templates
├── 📁 src/                                # Source code directory
│   ├── 📁 README.md                       # source code instruction overview
│   ├── 📁 data_ingestion/                 # Data ingestion layer
│   ├── 📁 data_transformation/            # Data transformation layer
│   │   ├── 📁 processed_layer/            # Processed data transformations
│   │   └──    presentation_layer/         # Presentation layer transformations
│   ├── 📁 data_analysis/                  # for Data analysis and BI visualization
│   ├── 📁 data_modeling/                  # Data modeling and schema design
│   │   ├── 📁 env_setup/                  # Environment setup scripts
│   │   ├── 📁 raw_layer/                  # Raw data layer schemas
│   │   ├── 📁 processed_layer/            # Processed data layer schemas
│   │   └──    presentation_layer/         # Presentation layer schemas
│   ├── 📁 config/                         # Configuration files
│   │   └── 📄 configuration.py            # Main configuration settings
│   ├── 📁 utils/                          # Utility functions and helpers
│   │   ├── 📁 2021-03-21/                 # March 21, 2021 dataset
│   │   ├── 📁 2021-03-28/                 # March 28, 2021 dataset
│   │   └── 📁 2021-04-18/                 # April 18, 2021 dataset
│   └── 📁 demo_code/                      # Demo and learning materials
├── 📁 visualization/                      # Data Visualization
│   ├── 📁 via_python/                     # jupyter notebooks for visualization via python
│   ├── 📁 via_tableau/                    # tableau dashboard .twb file
│   ├── 📁 f1_presentation(2021-04-18)/    # data source for BI
│   ├── 📁 generated_images/               # generated images via python
├── 📁 dataset/                            # Sample datasets (for incremental load)
└── 📁 docs/                               # Documentation directory
    ├── 📄 README.md                       # Documentation overview
    └── 📁 doc/
        └── 📁 wiki/                       # Technical documentation wiki
```

## Core Deliverables

### 1. deliverables I
### 2. deliverables II
### 3. deliverables III

## Tech Stack

This project sets up a high-availability big data platform, including the following components:

![Azure Cloud](https://img.shields.io/badge/Azure_cloud-66CCFF?style=for-the-badge) ![Azure Data Factory](https://img.shields.io/badge/azure_data_factory-017CEE?style=for-the-badge&logoColor=white) ![Azure Data Factory](https://img.shields.io/badge/ADLS_gen2-017CEE?style=for-the-badge&logoColor=white)  ![Unity Catelog](https://img.shields.io/badge/unity_catelog-f2f2e8?style=for-the-badge&color=f2f2e8) ![Databricks](https://img.shields.io/badge/databricks-252523?style=for-the-badge&logo=databricks&color=252523)  ![Delta Lake](https://img.shields.io/badge/delta_lake-red?style=for-the-badge&color=red)  ![Tableau](https://img.shields.io/badge/tableau-eceeea?style=for-the-badge&logo=tableau&logoColor=blue)  ![Python](https://img.shields.io/badge/python-blue?style=for-the-badge&logo=python&logoColor=yellow&logoSize=auto&color=blue) ![Spark](https://img.shields.io/badge/apache_spark-3.3.0-blue?style=for-the-badge&logo=apachespark&logoSize=auto&color=white)

| Components/Services             | Features                       | Version |
|------------------------|--------------------------------|---------|
| Azure          | Cloud Service Provider | -   |
| Azure Data Lake Storage Gen2       | Persistent Storage for dataset             | -   |
| Azure Data Factory       | ETL pipeline Scheduler              | -   |
| Python           | Programming for Core Spark Job Logic          | -   |
| Apache Spark           | Distributed Computing          | 3.3.0   |
| Azure Databricks            | Cluster Compute Workspace               | -   |
| Delta Lake            | Lakehouse Architecture               | -   |
| Unity Catelog            |                | -   |
| Power BI            | Data Visualization               | -   |



## [Source Code Instruction for Use](./src/README.md) `/src`

## Project Documents `/docs`

#### 1. wiki

Azure Databricks Cluster

- [Databricks Cluster](./docs/doc/wiki/databricks-cluster.md)
- [Databricks Cluster Configuration](./docs/doc/wiki/databricks-cluster-configuration.md)
- [Databricks Cluster Pool](./docs/doc/wiki/azure-databricks-cluster-pool.md)
- [Azure Databricks Pricing and Cost Control](./docs/doc/wiki/azure-databricks-pricing-calc.md)
- [Azure Databricks Utilities](./docs/doc/wiki/databricks-utilities.md)

Data Access Control

- [Authentication Configuration](./docs/doc/wiki/azure-databricks-authentication-configuration.md)
- [Authentication Service Principal](./docs/doc/wiki/azure-databricks-authentication-service-principal.md)
- [Azure Databricks Cluster Scoped Crendentials](./docs/doc/wiki/azure-databricks-cluster-scoped-credentials.md)

Mounting data lake container to databricks

- [Mounting data lake container to databricks](./docs/doc/wiki/mounting-data-lake-container-to-databricks.md)

Data Lakehouse Architecture

- [Data Lakehouse Architecture](./docs/doc/wiki/data-lakehouse-architecture.md)
- [3 Layer Model](./docs/doc/wiki/lakehouse-3-layers-model.md)
- [Lakehouse architecture](./docs/doc/wiki/solution-architecture.md)
- [Delta Lake Transaction Log](./docs/doc/wiki/delta-lake-transcation-log.md)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.  
Created and maintained by **Smars-Bin-Hu**.
