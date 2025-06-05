# Databricks Utilities (`dbutils`)

Create Date: Jun 4 2025

Create by: Smars Hu

Databricks Utilities (`dbutils`) is a Python-based toolset that helps manage files, secrets, parameters, and workflows in Databricks notebooks. It provides essential functions to streamline development and automation within a notebook environment.

---

## 📚 Common Utility Modules

| Module Name        | Description                                                                                                |
| ------------------ | ---------------------------------------------------------------------------------------------------------- |
| `dbutils.fs`       | **File System Utilities**: Manage files and directories in the Databricks File System (DBFS).              |
| `dbutils.secrets`  | **Secrets Utilities**: Securely access credentials stored in Azure Key Vault or Databricks Secrets.        |
| `dbutils.widgets`  | **Widget Utilities**: Create interactive input controls (e.g., textboxes, dropdowns) for parameterization. |
| `dbutils.notebook` | **Notebook Workflow Utilities**: Call and chain other notebooks with arguments and receive outputs.        |

---

## 📁 File System Utilities (`dbutils.fs`)

### List Files in a Folder

```python
dbutils.fs.ls('/mnt/my-folder')
```

Returns a list of files and directories, including name, size, and type.

### View Method Documentation

```python
dbutils.fs.help('ls')
```

Displays documentation for the `ls` method, including usage and return structure.

### Other Common Operations

```python
# Create a directory
dbutils.fs.mkdirs('/mnt/my-folder')

# Delete a file or folder
dbutils.fs.rm('/mnt/my-folder/file.csv', recurse=True)

# Copy a file
dbutils.fs.cp('/mnt/source.txt', '/mnt/destination.txt')
```

> ⚠️ Note: Uploading local files to DBFS must be done through the Databricks UI or REST API, not via `dbutils`.

---

## 🔐 Secrets Utilities (`dbutils.secrets`)

### Retrieve a Secret

```python
dbutils.secrets.get(scope="my-scope", key="db-password")
```

* `scope` must be pre-configured in the Databricks UI.
* Commonly used for securely managing credentials like database passwords or API keys.

---

## 🎛️ Widget Utilities (`dbutils.widgets`)

### Create a Text Input Widget

```python
dbutils.widgets.text("input1", "default_value", "Please enter a parameter")
```

### Retrieve Widget Value

```python
input_val = dbutils.widgets.get("input1")
```

> Supported widget types: `text`, `dropdown`, `combobox`, `multiselect`.

---

## 🧩 Notebook Workflow Utilities (`dbutils.notebook`)

### Run Another Notebook with Parameters

```python
result = dbutils.notebook.run(
  "/Users/myuser/my-notebook",
  timeout_seconds=60,
  arguments={"input": "abc"}
)
```

### Exit a Notebook and Return a Result

```python
dbutils.notebook.exit("success")
```

> These utilities allow you to build notebook-based workflows with argument passing and result handling.

---


# Databricks Utilities（dbutils 工具）

Databricks Utilities 是一组用于在 notebook 中执行常见任务的工具函数，提供了对文件系统、参数传递、机密管理和 notebook 工作流的便捷控制接口。

Create Date: Jun 3 2025

Create by: Smars Hu

## 📚 常用工具模块（Commonly Used Modules）

| 中文模块名          | 英文模块名              | 简介说明（中英文）                                                                                                        |
| -------------- | ------------------ | ---------------------------------------------------------------------------------------------------------------- |
| 文件系统工具         | `dbutils.fs`       | 操作 DBFS（Databricks File System）进行文件读取、写入、移动、删除等操作。<br>Used to read, write, list, move, and delete files in DBFS. |
| 密钥管理工具         | `dbutils.secrets`  | 安全访问存储在 Azure Key Vault 或 Databricks Secrets 中的凭据。<br>Used to securely access secrets like passwords or keys.    |
| 小组件工具          | `dbutils.widgets`  | 在 Notebook 中添加用户交互输入控件（如文本框、下拉框）。<br>Adds interactive input widgets to parameterize notebooks.                   |
| Notebook 工作流工具 | `dbutils.notebook` | 调用其他 notebook，进行任务链式执行。<br>Run and chain multiple notebooks together.                                            |

---

## 📁 文件系统工具（File System Utilities）

### 示例：列出某个路径下的文件

```python
dbutils.fs.ls('/mnt/my-folder')
```

返回的是一个包含文件路径、大小和是否为目录的列表。

### 示例：查看某方法的使用说明

```python
dbutils.fs.help('ls')
```

显示 `ls` 方法的文档说明，包括参数与返回值格式。

### 其他常见命令

```python
# 创建目录
dbutils.fs.mkdirs('/mnt/my-folder')

# 删除文件或目录
dbutils.fs.rm('/mnt/my-folder/file.csv', recurse=True)

# 复制文件
dbutils.fs.cp('/mnt/source.txt', '/mnt/destination.txt')

# 将本地文件上传到 DBFS（在 UI 中用 Upload 功能）
# dbutils 无法直接上传本地文件，需用 UI 或 REST API
```

---

## 🔐 密钥管理工具（Secrets Utilities）

```python
# 获取密钥值（例如数据库密码）
dbutils.secrets.get(scope="my-scope", key="db-password")
```

* 需先在 Databricks UI 中设置 scope 和 key。
* 通常用于数据库连接、API 凭据管理。

---

## 🎛️ 小组件工具（Widgets Utilities）

```python
# 添加文本输入框
dbutils.widgets.text("input1", "default_value", "请输入参数")

# 读取输入框的值
input_val = dbutils.widgets.get("input1")
```

支持文本框（text）、下拉菜单（dropdown）、组合框（combobox）、多选框（multiselect）。

---

## 🧩 Notebook 工作流工具（Notebook Workflow Utilities）

```python
# 运行另一个 notebook，并传递参数
result = dbutils.notebook.run("/Users/myuser/my-notebook", timeout_seconds=60, arguments={"input": "abc"})

# 结束 notebook 并返回结果
dbutils.notebook.exit("success")
```

用于将多个 notebook 串联为一个工作流，支持参数传递与结果返回。

---
