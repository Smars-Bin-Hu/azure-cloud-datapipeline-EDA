# Databricks Enterprise Credential and Permission Management Configuration Guide

Create Date: Jun 5 2025

Create by: Smars Hu

This guide summarizes the security best practices for production environments: controlling permissions via **Service Principal + RBAC**, storing sensitive credentials with **Databricks Secret Scope + Key Vault**, and centrally configuring Spark credentials at the **cluster level**.

---

## 1. Use Service Principal + RBAC for Permission Control

### Concept
A Service Principal is an application identity registered in Azure AD, used for programs or services to access Azure resources as a non-human identity.

RBAC (Role-Based Access Control) allows fine-grained control over this identity’s access to Azure resources.

### Steps
1. Register an application in Azure AD to generate a Service Principal.
2. Assign the minimum required permissions. For example:
   - Assign the SP to the `Storage Blob Data Contributor` role of the Storage Account.
3. Ensure the SP’s `client_id` and `client_secret` are properly secured and not exposed in code.

---

## 2. Use Databricks Secret Scope + Key Vault to Store Sensitive Credentials

### Concept
Secret Scope is a mechanism in Databricks for storing sensitive information (such as SP secrets, access tokens, etc.), supporting two modes:
- Databricks-managed Scope
- Azure Key Vault-backed Scope (recommended)

### Recommended Practice
1. Create and configure a Key Vault in Azure to store the SP’s `client_secret`.
2. Create a Secret Scope in Databricks that is bound to the Key Vault:
   ```bash
   databricks secrets create-scope --scope kv-scope --scope-backend-type AZURE_KEYVAULT \
     --resource-id <keyvault-resource-id> --dns-name https://<kv-name>.vault.azure.net/
   ```
3. Access credentials using `dbutils.secrets.get()`:

   ```python
   dbutils.secrets.get(scope="kv-scope", key="sp-client-secret")
   ```

---

## 3. Centrally Configure Spark Credential at the Cluster Level to Enhance Security and Maintainability

### Reason

Centralized cluster-level credential configuration avoids repetitive setup in notebooks and improves security and consistency.

### Implementation

Configure the following items in the `Spark Config` of the Databricks cluster to access ADLS using OAuth + SP:

```bash
spark.hadoop.fs.azure.account.auth.type.<storage>.dfs.core.windows.net OAuth
spark.hadoop.fs.azure.account.oauth.provider.type.<storage>.dfs.core.windows.net org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider
spark.hadoop.fs.azure.account.oauth2.client.id.<storage>.dfs.core.windows.net <client-id>
spark.hadoop.fs.azure.account.oauth2.client.secret.<storage>.dfs.core.windows.net {{secrets/kv-scope/sp-client-secret}}
spark.hadoop.fs.azure.account.oauth2.client.endpoint.<storage>.dfs.core.windows.net https://login.microsoftonline.com/<tenant-id>/oauth2/token
```

Once configured, all notebooks connected to the cluster can seamlessly access ADLS.

---

## 4. Avoid Hardcoding Credentials in Notebooks

### Reason

* Credentials hardcoded in code are easily leaked if accidentally uploaded to Git or other version control systems.
* Updating credentials requires manual modification of all notebooks, which is hard to maintain.
* This does not comply with enterprise information security policies.

### Countermeasures

* All sensitive information should be managed via Secret Scope.
* All permission control should be implemented via RBAC, not by granting broad access through keys.

---

## 5. Role Relationship Summary

| Component                | Responsibility                                              |
| ------------------------ | ---------------------------------------------------------- |
| Service Principal        | Azure AD identity for accessing protected resources         |
| RBAC                     | Controls SP’s access to resources (least privilege)         |
| Azure Key Vault          | Securely stores SP secrets and other sensitive information  |
| Databricks Secret Scope  | Connects to Key Vault and securely references secrets in notebooks or cluster configs |
| Spark Config in Cluster  | Globally configures credentials so all notebooks connected to the cluster have access automatically |

---

## 6. Recommended Architecture Diagram (Text Description)

```
[Notebook]
   ↓ (connect)
[Databricks Cluster] —— Spark Config reads ——> [Secret Scope (KeyVault-backed)]
                                            ↓
                                [Service Principal Credentials]
                                            ↓
                            Accesses [Storage Account] via OAuth
                                            ↑
                           Access granularity controlled by Azure RBAC
```

---

## 7. Summary

* Use Service Principal + RBAC for fine-grained permission control
* Store all credentials in Key Vault and inject them securely via Secret Scope
* Credential configuration should be centralized at the cluster level, not scattered in notebooks
* All notebook users should access storage systems through the cluster, and no plaintext passwords or keys should appear in code

This configuration pattern is the current standard practice for enterprises running Databricks on Azure, meeting requirements for security, maintainability, and compliance.

---


# Databricks 企业级凭证与权限管理配置指南

Create Date: Jun 5 2025

Create by: Smars Hu

本指南总结了在生产环境中通过 **Service Principal + RBAC** 控制权限、结合 **Databricks Secret Scope + Key Vault** 存储敏感凭证，并在 **集群层统一配置 Spark 凭证** 的安全实践模式。

---

## 1. 使用 Service Principal + RBAC 控制权限

### 概念
Service Principal（服务主体）是注册在 Azure AD 中的应用身份，用于程序或服务以非人类身份访问 Azure 资源。

RBAC（Role-Based Access Control）允许精细地控制该身份对 Azure 资源的访问权限。

### 步骤
1. 在 Azure AD 中注册应用，生成 Service Principal。
2. 分配最小必要的权限。例如：
   - 将 SP 分配给 Storage Account 的 `Storage Blob Data Contributor` 角色。
3. 确保该 SP 的 `client_id` 和 `client_secret` 被妥善保管，不在代码中明文暴露。

---

## 2. 使用 Databricks Secret Scope + Key Vault 存储敏感凭证

### 概念
Secret Scope 是 Databricks 中用来存储敏感信息（如 SP 密钥、访问令牌等）的机制，支持两种方式：
- Databricks-managed Scope（托管）
- Azure Key Vault-backed Scope（推荐）

### 推荐做法
1. 在 Azure 中创建并配置 Key Vault，存储 SP 的 `client_secret`。
2. 在 Databricks 中创建与 Key Vault 绑定的 Secret Scope：
   ```bash
   databricks secrets create-scope --scope kv-scope --scope-backend-type AZURE_KEYVAULT \
     --resource-id <keyvault-resource-id> --dns-name https://<kv-name>.vault.azure.net/
    ```
3. 使用 `dbutils.secrets.get()` 方式访问凭证：

   ```python
   dbutils.secrets.get(scope="kv-scope", key="sp-client-secret")
   ```

---

## 3. 在集群层统一配置 Spark Credential 提升安全性与可维护性

### 原因

统一配置集群层凭证可以避免在 notebook 中重复配置，提高安全性与一致性。

### 实现方式

在 Databricks 集群的 `Spark Config` 中配置如下项，使用 OAuth + SP 的方式访问 ADLS：

```bash
spark.hadoop.fs.azure.account.auth.type.<storage>.dfs.core.windows.net OAuth
spark.hadoop.fs.azure.account.oauth.provider.type.<storage>.dfs.core.windows.net org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider
spark.hadoop.fs.azure.account.oauth2.client.id.<storage>.dfs.core.windows.net <client-id>
spark.hadoop.fs.azure.account.oauth2.client.secret.<storage>.dfs.core.windows.net {{secrets/kv-scope/sp-client-secret}}
spark.hadoop.fs.azure.account.oauth2.client.endpoint.<storage>.dfs.core.windows.net https://login.microsoftonline.com/<tenant-id>/oauth2/token
```

上述配置一经设定，所有连接该集群的 notebook 均可无缝访问 ADLS。

---

## 4. 避免在 Notebook 中写死凭证

### 原因

* 凭证写在代码中极易被误上传到 Git 等版本库，造成泄露。
* 凭证更新需手动修改所有 notebook，不易维护。
* 不符合企业信息安全政策。

### 应对策略

* 所有敏感信息应通过 Secret Scope 管理。
* 所有权限控制应通过 RBAC 实施，而非通过密钥暴力授权。

---

## 5. 角色关系总结

| 组件                      | 职责                                  |
| ----------------------- | ----------------------------------- |
| Service Principal       | Azure AD 身份，用于访问受保护资源               |
| RBAC                    | 控制 SP 对资源的访问权限（最小权限）                |
| Azure Key Vault         | 安全存储 SP 密钥等敏感信息                     |
| Databricks Secret Scope | 连接 Key Vault，并在 notebook 或集群配置中安全引用 |
| Spark Config in Cluster | 全局配置凭证，使所有连接该集群的 notebook 自动具备访问权限  |

---

## 6. 推荐架构图（文字描述）

```
[Notebook]
   ↓ (连接)
[Databricks Cluster] —— Spark Config 读取 ——> [Secret Scope (KeyVault-backed)]
                                            ↓
                                [Service Principal 凭证]
                                            ↓
                            以 OAuth 方式访问 [Storage Account]
                                            ↑
                           权限由 Azure RBAC 控制访问粒度
```

---

## 7. 总结

* 使用 Service Principal + RBAC 实现细粒度权限控制
* 所有凭证存储于 Key Vault，通过 Secret Scope 安全注入
* 凭证配置应在集群层集中设置，避免分散在 notebook 中
* 所有 notebook 用户应通过集群统一访问存储系统，代码中不应出现明文密码或密钥

该配置模式是当前主流企业在 Azure 上运行 Databricks 的标准实践，符合安全、可维护、合规性要求。