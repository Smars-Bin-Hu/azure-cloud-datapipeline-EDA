# Databricks Cluster Configuration

Create Date: Jun 4 2025

Create by: Smars Hu

## 1. Single / Multi Node

* **Single Node**
  Suitable for lightweight tasks such as basic data analysis and small-scale machine learning training.
  Cannot horizontally scale, so it’s ideal for development, testing, or educational purposes.

* **Multi Node**
  Supports horizontal scaling by adding worker nodes dynamically.
  Suitable for large-scale data processing, ETL pipelines, and complex machine learning training.
  Preferred option for most production environments.

---

## 2. Access Mode

* **Single User**
  Only one user can access the cluster.
  Supports Python, Scala, SQL, and R. Resources are not shared.

* **Shared**
  Multi-user access.
  Requires **Databricks Premium**.
  Enables collaborative development among users.

* **No-isolation Shared**
  Multi-user mode **without isolation** between users.
  May result in resource conflicts or shared logs.
  Not suitable for sensitive workloads.

* **Custom**
  Legacy configuration mode, mainly for backward compatibility.
  Not recommended for new projects.

---

## 3. Databricks Runtime

Databricks offers multiple runtime environments for different workloads:

* **Databricks Runtime**
  Includes Apache Spark, support for Python/R/Java/Scala, Ubuntu system libraries, GPU libraries, Delta Lake, and integration with other Databricks services.

* **Databricks Runtime ML**
  Includes all standard runtime features + popular machine learning libraries like PyTorch, TensorFlow, XGBoost, MLflow, etc.

* **Photon Runtime**
  Enhanced with **Photon Engine**, a C++-based vectorized query engine.
  Significantly boosts SQL and Delta Lake performance for OLAP workloads.

* **Databricks Runtime Light**
  A minimal runtime version for jobs that don’t require advanced features.
  Lightweight and faster to start.

---

## 4. Auto Termination

* Automatically shuts down the cluster after **X minutes of inactivity**.
* Default timeout: 120 minutes.
* Configurable between **10 and 10000 minutes**.
* Strongly recommended to avoid unnecessary costs during idle times (e.g., nights or weekends).

---

## 5. Auto Scaling

* Automatically adjusts the number of worker nodes between **user-defined min and max**.
* Ideal for fluctuating ETL workloads.
* **Not recommended for streaming workloads** due to potential instability (e.g., message loss, latency).

---

## 6. Cluster VM Type / Size

Choose the VM type based on your workload:

* **Memory Optimized**: Suitable for memory-intensive tasks like large joins, window functions, or ML model training.
* **Compute Optimized**: Good for CPU-heavy transformations and batch computation.
* **Storage Optimized**: High I/O throughput for tasks involving large files or frequent writes (e.g., Delta Lake).
* **General Purpose**: Balanced resources for most moderate workloads.
* **GPU Accelerated**: Required for deep learning models and high-performance computing tasks.

---

## 7. Cluster Policy

Cluster policies define **restrictions and templates** for creating clusters, improving governance and cost control:

* Admins can assign policies to specific users or groups.
* Restricts users from selecting high-cost configurations.
* Simplifies the UI for non-admin users.
* Enforces cost-saving best practices.
* **Only available on Premium tier**.

# Databricks 集群配置说明笔记（Databricks Cluster Configuration）

## 一、Single / Multi Node（单节点 / 多节点）

* **Single Node（单节点）**
  适用于轻量级任务，如简单的数据分析和小规模机器学习模型训练。
  无法水平扩展（horizontally scale），因此性能有限，通常用于开发测试环境或教学目的。

* **Multi Node（多节点）**
  支持水平扩展，可根据需求动态添加工作节点（Worker Nodes），适合大型数据处理、ETL流程、复杂机器学习训练等。是大多数生产环境的首选。

## 二、Access Mode（访问模式）

* **Single User**
  仅支持一个用户访问，适用于开发测试。支持 Python、Scala、SQL、R 等语言。资源不会与其他用户共享。

* **Shared**
  多用户共享访问，需要 Databricks Premium 等级。资源由多个用户共用，支持协作开发。

* **No-isolation Shared**
  无隔离的多用户共享模式，不建议用于包含敏感数据或需强隔离的任务。用户之间运行的任务可能互相影响（如内存冲突、日志混杂等）。

* **Custom（自定义）**
  旧版本配置方式，通常用于向后兼容，不建议新项目使用。

## 三、Databricks Runtime（运行时环境）

Databricks 提供多种运行时环境用于不同类型的工作负载：

* **Databricks Runtime**
  标准 Spark 运行时，包含支持 Python/R/Java/Scala 的库、Ubuntu 系统库、GPU 库、Delta Lake、以及 Databricks 的其他服务集成。

* **Databricks Runtime ML**
  在标准 Runtime 的基础上增加机器学习库（如 PyTorch、TensorFlow、XGBoost、MLflow 等），适用于机器学习和深度学习任务。

* **Photon Runtime**
  加入 Databricks Photon 引擎（基于 C++ 重写的矢量化执行引擎），提升 SQL 和 Delta Lake 的性能，特别适合 OLAP 查询和高性能计算。

* **Databricks Runtime Light**
  轻量版运行时，适用于无高级功能需求的作业，例如简单的批处理任务，启动速度快，资源消耗小。

## 四、Auto Termination（自动终止）

* 启用自动终止功能后，集群在**X 分钟无活动**后自动释放资源。
* 默认值为 120 分钟，可设置范围为 10 到 10000 分钟。
* 避免夜间或周末因忘记关集群而造成资源浪费，**强烈建议启用**。

## 五、Auto Scaling（自动扩缩容）

* 用户设置最小和最大工作节点数，Databricks 根据负载动态扩缩容。
* 可有效节省资源成本，应对波动性强的 ETL 任务。
* **不建议用于流式计算（Streaming Workloads）**，因为流处理对节点数量的变化不敏感或不稳定，可能导致丢包、处理延迟等问题。

## 六、Cluster VM Type / Size（虚拟机类型 / 规格）

根据不同的任务负载选择合适的虚拟机类型：

* **Memory Optimized（内存优化型）**：适合内存密集型应用，如大型 Join、窗口函数、ML 模型训练等。
* **Compute Optimized（计算优化型）**：适合 CPU 密集型任务，如数据转换、批量计算。
* **Storage Optimized（存储优化型）**：用于高 I/O 吞吐任务，如读取大型 Parquet 文件或频繁写入 Delta 表。
* **General Purpose（通用型）**：适合大多数中等规模的数据处理任务。
* **GPU Accelerated（GPU 加速型）**：适用于深度学习模型训练、图像处理等高计算强度任务。

## 七、Cluster Policy（集群策略）

集群策略（Cluster Policies）用于限制集群配置，便于统一管理和成本控制。

* 管理员可为用户或用户组创建策略模板，限制可选的 VM 类型、运行时、访问模式等。
* 限制用户自定义集群配置的权限，避免误操作导致资源浪费。
* 简化 UI，使普通用户可直接在限制范围内创建集群。
* 需要 **Databricks Premium 计划** 才能使用。

---