# 🔐 Azure Authentication Methods: Service Principal vs Access Key vs SAS Token

Create Date: Jun 5 2025

Create by: Smars Hu

## 1. What is a Service Principal?

A **Service Principal** is a security identity used by applications, services, or automation tools to access Azure resources. It is **created in Azure Active Directory (AAD)** and enables non-human identity authentication in a secure and manageable way.

> Think of it as a "user account" for your application.

### Key Components:
- `tenant_id` – Azure AD tenant ID
- `client_id` – App (Service Principal) ID
- `client_secret` – Password or certificate
- `subscription_id` – Azure subscription where resources exist

---

## 2. How Does Service Principal-Based Access Work?

1. **Register an app** in Azure AD to create a Service Principal.
2. **Assign RBAC roles** (e.g., `Storage Blob Data Contributor`) to the SP for specific resource scopes (subscription, resource group, or resource).
3. Use the credentials (`client_id`, `client_secret`, etc.) to **authenticate via Azure SDK or CLI** and programmatically access resources.

✅ Supports:
- Role-Based Access Control (RBAC)
- Least privilege access
- Identity separation

---

## 3. Comparing Authentication Methods

| Method              | Service Principal              | Access Key                        | SAS Token                           |
|---------------------|---------------------------------|------------------------------------|--------------------------------------|
| **Source of Trust** | Azure Active Directory         | Storage Account master key         | Generated from master key            |
| **Granular Control**| ✅ Role assignment via RBAC     | ❌ Full access (read/write/delete) | ✅ Fine-grained (path, time, method) |
| **Security Level**  | 🔐 High (supports certificates) | ⚠️ Low (exposes full account)       | 🔒 Medium (time-limited, scoped)     |
| **Best For**        | Automation, CI/CD, backend apps| Quick PoC, manual tasks            | Temporary file access, client upload |
| **Revocability**    | ✅ Easy via role removal        | ❌ Must regenerate key              | ✅ Expire token or revoke key        |
| **Use in Code**     | Recommended                    | Not recommended                    | Acceptable for short-term            |

---

## 4. When to Use Each Method?

| Scenario                                    | Recommended Method     |
|---------------------------------------------|------------------------|
| Secure automation (e.g., Databricks, Airflow)| ✅ Service Principal    |
| Manual upload testing                        | ⚠️ Access Key (short-term only) |
| Grant temporary access to third parties      | ✅ SAS Token            |
| CI/CD pipeline deploys to Azure              | ✅ Service Principal    |

---

## 5. Summary

- Use **Service Principals** for secure, scalable, and manageable automation access.
- Avoid using **Access Keys** in production; they are powerful and risky.
- **SAS Tokens** are useful for **temporary, scoped access**, such as uploading files.

> 🔐 **Service Principals + RBAC = Recommended Enterprise-Grade Authentication Model in Azure**

---

## 6. Useful CLI Commands

```bash
# Create a Service Principal
az ad sp create-for-rbac --name my-app --role Contributor --scopes /subscriptions/<sub-id>/resourceGroups/<rg-name>

# Log in using Service Principal
az login --service-principal -u <client_id> -p <client_secret> --tenant <tenant_id>
```