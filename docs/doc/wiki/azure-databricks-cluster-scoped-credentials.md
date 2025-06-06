# Databricks Cluster Scope Credentials Explained

Create Date: Jun 5 2025

Create by: Smars Hu

## 1. What are Cluster Scope Credentials?

**Cluster Scope Credentials** refer to credentials for accessing external resources (such as Azure Storage Account) that are **directly configured in the Spark configuration of a Databricks cluster**, so that all notebooks connected to the cluster can automatically use these credentials to access the corresponding resources.

✅ Common scenarios include:
- Reading ADLS Gen2 or Blob Storage data via Spark
- Unified management of Key Vault secrets
- Connecting to JDBC data sources

---

## 2. How to Implement: Where to Configure?

### ✅ Method 1: Cluster-level Configuration (Recommended)
Add the following configuration in the **“Spark Config”** section when creating a Databricks cluster:

```bash
spark.hadoop.fs.azure.account.auth.type.<storage-account>.dfs.core.windows.net OAuth
spark.hadoop.fs.azure.account.oauth.provider.type.<storage-account>.dfs.core.windows.net org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider
spark.hadoop.fs.azure.account.oauth2.client.id.<storage-account>.dfs.core.windows.net <application-id>
spark.hadoop.fs.azure.account.oauth2.client.secret.<storage-account>.dfs.core.windows.net {{secrets/<scope>/<key-name>}}
spark.hadoop.fs.azure.account.oauth2.client.endpoint.<storage-account>.dfs.core.windows.net https://login.microsoftonline.com/<tenant-id>/oauth2/token
```

You can also directly reference Azure Key Vault secrets in the cluster settings.

---

### ⚠️ Method 2: Dynamic Configuration in Notebook (Temporary)

At the beginning of each notebook, write the following code:

```python
spark.conf.set("spark.hadoop.fs.azure.account.key.<storage-account>.blob.core.windows.net", "<access-key>")
```

or

```python
spark.conf.set("spark.hadoop.fs.azure.account.oauth2.client.secret.<storage-account>.dfs.core.windows.net", dbutils.secrets.get(scope="kv", key="sp-secret"))
```

---

## 3. Benefits of Cluster Scope Credentials

| Advantage            | Description                                                                                  |
| -------------------- | -------------------------------------------------------------------------------------------- |
| ✅ Centralized Security Management | Store credentials (such as client secret) in Azure Key Vault, use Databricks Secret Scope to call, no need to hardcode secrets in code |
| ✅ Simplified Notebook Code        | All notebooks connected to the cluster can automatically access storage resources, reducing repetitive configuration |
| ✅ Supports Least Privilege Control| Can control SP permissions via Azure AD + RBAC                                  |
| ✅ Easy Maintenance               | When updating credentials, just update the secret, no need to modify code        |

---

## 4. Suitable Scenarios

* Multiple users sharing a compute cluster (each running their own notebook)
* Multiple notebooks need to access the same data source
* Automated ETL jobs, avoiding sensitive information scattered in scripts

---

## 5. Recommended Configuration for Production

| Method                                 | Recommended | Reason                                                      |
| --------------------------------------- | ----------- | ----------------------------------------------------------- |
| **Set credentials in cluster Spark Config** | ✅ Yes      | Secure, centralized, reusable; with Secret Scope, secrets are not exposed |
| Set credentials in notebook                | ❌ No       | Easy to leak secrets, hard to maintain, every notebook needs repeated setup |
| Use Access Key                             | ⚠️ Caution | Overly broad permissions, recommend using Service Principal + RBAC instead |
| Use SAS Token                              | ✅ Optional | Suitable for temporary access, not for long-term deployment |

---

## 6. Best Practice Summary

* ✅ Use **Service Principal + RBAC** for permission control
* ✅ Use **Databricks Secret Scope + Key Vault** to store sensitive credentials
* ✅ Configure **Spark Credential at the cluster level** for better security and maintainability
* ❌ Avoid hardcoding credentials in notebooks

---

## 7. Reference Example (OAuth + KeyVault)

```bash
spark.hadoop.fs.azure.account.auth.type.smarsstorageaccount0328.dfs.core.windows.net OAuth
spark.hadoop.fs.azure.account.oauth.provider.type.smarsstorageaccount0328.dfs.core.windows.net org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider
spark.hadoop.fs.azure.account.oauth2.client.id.smarsstorageaccount0328.dfs.core.windows.net <client-id>
spark.hadoop.fs.azure.account.oauth2.client.secret.smarsstorageaccount0328.dfs.core.windows.net {{secrets/kv-scope/sp-client-secret}}
spark.hadoop.fs.azure.account.oauth2.client.endpoint.smarsstorageaccount0328.dfs.core.windows.net https://login.microsoftonline.com/<tenant-id>/oauth2/token
```

---

## 📎 Summary

> **Cluster Scope Credentials are the recommended approach for accessing cloud storage in production environments.** Combined with Service Principal and Key Vault, you can achieve secure, stable, and highly reusable data access configuration, avoiding the spread of sensitive information in notebooks.

---


# Databricks 集群作用域凭证（Cluster Scope Credentials）详解

## 一、什么是 Cluster Scope Credentials？

**Cluster Scope Credentials** 指的是将访问外部资源（如 Azure Storage Account）的身份凭证，**直接配置在 Databricks 集群的 Spark 配置中**，从而使所有连接该集群的 notebook 都可以自动使用这些凭证访问对应资源。

✅ 常见场景包括：
- 通过 Spark 读取 ADLS Gen2、Blob Storage 数据
- 统一管理 Key Vault 密钥
- 连接 JDBC 数据源

---

## 二、实现方式：在哪配置？

### ✅ 方法 1：集群层配置（推荐）
在创建 Databricks 集群时的 **“Spark Config”** 区域添加如下配置：

```bash
spark.hadoop.fs.azure.account.auth.type.<storage-account>.dfs.core.windows.net OAuth
spark.hadoop.fs.azure.account.oauth.provider.type.<storage-account>.dfs.core.windows.net org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider
spark.hadoop.fs.azure.account.oauth2.client.id.<storage-account>.dfs.core.windows.net <application-id>
spark.hadoop.fs.azure.account.oauth2.client.secret.<storage-account>.dfs.core.windows.net {{secrets/<scope>/<key-name>}}
spark.hadoop.fs.azure.account.oauth2.client.endpoint.<storage-account>.dfs.core.windows.net https://login.microsoftonline.com/<tenant-id>/oauth2/token
```

你也可以直接在集群设置中引用 Azure Key Vault 的 secret。

---

### ⚠️ 方法 2：Notebook 中动态配置（临时）

在每个 notebook 的开头写如下代码：

```python
spark.conf.set("spark.hadoop.fs.azure.account.key.<storage-account>.blob.core.windows.net", "<access-key>")
```

或

```python
spark.conf.set("spark.hadoop.fs.azure.account.oauth2.client.secret.<storage-account>.dfs.core.windows.net", dbutils.secrets.get(scope="kv", key="sp-secret"))
```

---

## 三、集群作用域凭证的好处

| 优点               | 说明                                                                              |
| ---------------- | ------------------------------------------------------------------------------- |
| ✅ 安全集中管理         | 将凭证（如 client secret）存放于 Azure Key Vault，配合 Databricks Secret Scope 调用，无需将密钥写入代码 |
| ✅ 简化 notebook 代码 | 所有连接该集群的 notebook 可自动访问存储资源，减少重复配置                                              |
| ✅ 支持最小权限控制       | 可通过 Azure AD + RBAC 控制 SP 权限                                                    |
| ✅ 易于维护           | 更换凭证时只需更新 secret，无需修改代码                                                         |

---

## 四、适合场景

* 多用户共享一个计算集群（每人运行自己的 Notebook）
* 多个 Notebook 需要访问相同的数据源
* 自动化 ETL 作业，避免敏感信息散落在脚本中

---

## 五、生产环境推荐配置方式

| 方式                        | 是否推荐  | 理由                                 |
| ------------------------- | ----- | ---------------------------------- |
| **集群 Spark Config 中设置凭证** | ✅ 推荐  | 安全、集中、可复用，结合 Secret Scope 不暴露敏感信息  |
| Notebook 中设置凭证            | ❌ 不推荐 | 容易泄露密钥、不易维护、每个 notebook 都需重复设置     |
| 使用 Access Key             | ⚠️ 谨慎 | 权限过大，推荐改用 Service Principal + RBAC |
| 使用 SAS Token              | ✅ 可选  | 适用于临时访问场景，但不适合长期部署                 |

---

## 六、最佳实践小结

* ✅ 使用 **Service Principal + RBAC** 控制权限
* ✅ 使用 **Databricks Secret Scope + Key Vault** 存储敏感凭证
* ✅ 在 **集群层统一配置 Spark Credential**，提升安全性与可维护性
* ❌ 避免把凭证写死在 Notebook 里

---

## 七、参考示例（OAuth + KeyVault）

```bash
spark.hadoop.fs.azure.account.auth.type.smarsstorageaccount0328.dfs.core.windows.net OAuth
spark.hadoop.fs.azure.account.oauth.provider.type.smarsstorageaccount0328.dfs.core.windows.net org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider
spark.hadoop.fs.azure.account.oauth2.client.id.smarsstorageaccount0328.dfs.core.windows.net <client-id>
spark.hadoop.fs.azure.account.oauth2.client.secret.smarsstorageaccount0328.dfs.core.windows.net {{secrets/kv-scope/sp-client-secret}}
spark.hadoop.fs.azure.account.oauth2.client.endpoint.smarsstorageaccount0328.dfs.core.windows.net https://login.microsoftonline.com/<tenant-id>/oauth2/token
```

---

## 📎 总结

> **Cluster Scope Credentials 是在生产环境中访问云存储的推荐做法**，结合 Service Principal 和 Key Vault 可实现安全、稳定、高复用的数据访问配置，避免敏感信息在 notebook 中传播。