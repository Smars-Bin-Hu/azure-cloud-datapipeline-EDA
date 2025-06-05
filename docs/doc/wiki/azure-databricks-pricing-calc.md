# Azure Databricks Pricing Calculation

Create Date: Jun 4 2025

Create by: Smars Hu

## 📊 Cost Formula Overview

To estimate the cost of using Azure Databricks, consider the following components:

```
Total Cluster Cost = DBU Cost + Driver Node VM Cost + Worker Node VM Cost
```

* **DBU Cost** = Number of DBUs × DBU price (based on workload type and pricing tier)
* **Driver Node Cost** = 1 (driver node) × VM price (e.g., Standard\_DS3\_v2)
* **Worker Node Cost** = Number of workers × VM price

> 💡 *DBU (Databricks Unit)* is a unit of processing capability per hour, billed separately from VM infrastructure costs. Different workloads (Standard, ML, Photon) and tiers (Standard, Premium) have different DBU rates.

---

## 🧾 Estimated Cost for Doing the Course

The following services are used throughout the course. Here's a breakdown of their estimated costs and behaviors:

| Service                                  | Description                                                                              |
| ---------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Azure Data Lake Storage**              | Used to store small-scale input/output data. Usage is minimal and cost is negligible.    |
| **Azure Data Factory**                   | Billed per pipeline run. Used to trigger or orchestrate data movements and jobs.         |
| **Azure Databricks Job Cluster**         | Auto-terminates after job completion. No idle cost. Budget-friendly for short tasks.     |
| **Azure Databricks Cluster Pool**        | Pool VMs are reused for fast startup. Should be deleted after course to avoid idle cost. |
| **Azure Databricks All Purpose Cluster** | Interactive usage (e.g., notebooks). More costly. Set auto-termination to control cost.  |

> 💰 **Estimated All-Purpose Cluster Cost:**
>
> * \$0.76/hour for a single **small node** (Premium tier)
> * Usage estimate: **20–30 hours** to complete course
> * Approximate total: **\$15 – \$25 USD**

---

## 💡 Cost Control Tips

| Service                                  | Cost Control Action                                                         |
| ---------------------------------------- | --------------------------------------------------------------------------- |
| **Azure Data Lake Storage**              | None needed – negligible data size                                          |
| **Azure Data Factory**                   | None – only billed per pipeline execution                                   |
| **Azure Databricks Job Cluster**         | None – auto-destroys after job completion                                   |
| **Azure Databricks Cluster Pool**        | **Delete the pool** after training to avoid idle VM costs                   |
| **Azure Databricks All Purpose Cluster** | **Set auto-termination** (e.g., 20 mins) to limit idle billing              |

plus, **Set budget alerts** via Azure Cost Management to monitor and notify usage.

---

## ✅ Recommendations

* Prefer **Job Clusters** for running batch jobs to avoid long-running idle charges.
* Enable **Auto-Termination** on all-purpose clusters to prevent costs when inactive.
* **Delete unused cluster pools** to avoid VM reservation charges.
* Regularly check the **Azure Pricing Calculator** or **Cost Analysis Dashboard** to monitor expenses.
