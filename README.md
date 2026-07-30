# 🚀 Azure Data Migration & ETL Pipeline using Azure Data Factory

## 📌 Project Overview

This project demonstrates an end-to-end Azure Data Engineering solution that migrates data from CSV files into Azure SQL Database using Azure Data Factory (ADF), Azure Data Lake Storage Gen2 (ADLS Gen2), and Azure SQL Database.

The solution follows the Medallion Architecture (Bronze, Silver, Gold) to transform raw data into clean, business-ready data for reporting and analytics.

---

## 🎯 Project Objectives

- Build a metadata-driven ETL pipeline.
- Dynamically ingest multiple CSV files.
- Implement Bronze, Silver, and Gold architecture.
- Clean and transform raw data.
- Generate business summary tables.
- Implement ETL Logging.
- Implement ETL Auditing.
- Implement Watermark tracking.
- Archive processed files automatically.

---

# ☁️ Azure Services Used

- Azure Data Factory
- Azure Data Lake Storage Gen2
- Azure SQL Database
- Azure Storage Account
- Microsoft Entra ID

---

# 📂 Dataset

*AdventureWorks Dataset*

Source Files

- SalesCustomer.csv
- Product.csv
- ProductCategory.csv
- Address.csv
- SalesOrderHeader.csv
- SalesOrderDetail.csv

---

# 🏗️ Solution Architecture


CSV Files
     │
     ▼
Azure Data Lake Storage Gen2 (Landing)
     │
     ▼
Azure Data Factory
     │
     ▼
Azure SQL Database
     │
 ┌──────────────┐
 │ Bronze Layer │
 └──────────────┘
        │
        ▼
 ┌──────────────┐
 │ Silver Layer │
 └──────────────┘
        │
        ▼
 ┌──────────────┐
 │ Gold Layer   │
 └──────────────┘
        │
        ▼
Business Reporting
(Power BI)


---

# 🥉 Bronze Layer

The Bronze layer stores raw data exactly as received from the source files.

Tables:

- SalesCustomer
- Product
- ProductCategory
- Address
- SalesOrderHeader
- SalesOrderDetail

---

# 🥈 Silver Layer

The Silver layer performs data cleansing and standardization.

Tables:

- DimCustomer
- DimProduct
- DimProductCategory
- DimAddress
- FactSalesOrderHeader
- FactSalesOrderDetail

---

# 🥇 Gold Layer

The Gold layer contains business-ready summary tables.

Tables:

- SalesSummary
- ProductSalesSummary
- CustomerSalesSummary
- MonthlySalesSummary
- TerritorySalesSummary

---

# 🔄 ETL Features

- Dynamic Metadata Pipeline
- Lookup Activity
- ForEach Activity
- Copy Activity
- Stored Procedures
- Incremental MERGE
- ETL Logging
- ETL Auditing
- Watermark Tracking
- File Archiving

---

# 🛠️ Technologies

- Azure Data Factory
- Azure SQL Database
- Azure Data Lake Storage Gen2
- SQL
- Stored Procedures
- Microsoft Entra ID
- Git & Github

---

## Project Flow

1. Source CSV files are uploaded to the Landing container in Azure Data Lake Storage Gen2.
2. Azure Data Factory dynamically reads metadata and loads the data into Bronze tables.
3. Silver stored procedures clean, validate, and transform the data.
4. Gold stored procedures create business-ready reporting tables.
5. Audit, Logging, and Watermark tables monitor and track every pipeline execution.
6. The Gold layer is ready for Power BI dashboards and business reporting.

---

## Project Structure


Azure-Data-Migration-ETL-Project
│
├── README.md
├── Architecture
├── Screenshots
└── SQL Scripts
    ├── Audit
    ├── Logging
    ├── Watermark
    ├── Bronze
    ├── Silver
    └── Gold


---

# 🚀 Future Enhancements

- Power BI Dashboard
- Azure Key Vault Integration
- CI/CD using Azure DevOps
- Azure Monitor Alerts
- Automated Scheduling

---

# 👨‍💻 Author

Kulavardhan Vantigari
Azure Data Engineering Portfolio Project
