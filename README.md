# Data Warehouse and Analytics Project

Welcome to my **Data Warehouse and Analytics Project** repository! 🚀  
This project demonstrates how I designed and built a complete data warehouse system from scratch, including data ingestion, modeling, ETL pipelines, and analytical reporting. It serves as a practical end-to-end project that showcases my skills in data engineering and analytics using SQL.

---

## 🏗️ Data Architecture

For this project, I implemented a modern Medallion-style data architecture with **Bronze**, **Silver**, and **Gold** layers:

1. **Bronze Layer** – Raw data is loaded directly from CSV files into SQL Server without any modifications.  
2. **Silver Layer** – Data is cleaned, standardized, validated, and prepared for modeling.  
3. **Gold Layer** – Final business-ready tables modeled using a star schema, optimized for reporting and analytics.

I have also included a full architecture diagram inside the `docs/` folder.

---

## 📖 Project Overview

This project includes the following major components:

1. **Data Architecture** – Designing a structured warehouse environment using the Medallion approach.  
2. **ETL Pipelines** – Building SQL-based ETL processes that extract, clean, transform, and load data into the warehouse layers.  
3. **Data Modeling** – Creating dimensional models using fact and dimension tables to support analysis.  
4. **Analytics & Reporting** – Writing SQL queries and building analyses to uncover insights and support business decision-making.

🎯 This project highlights my skills in:
- SQL development  
- Data warehousing  
- Data modeling  
- ETL design  
- Data analytics  

---

## 🛠️ Tools Used

- **SQL Server Express** – Database engine for storing and processing the data warehouse.  
- **SSMS** – For writing SQL queries and monitoring the database.  
- **DrawIO** – For architecture diagrams, data models, and ETL data flows.  
- **GitHub** – Version control and project hosting.  
- **CSV datasets** – Used as source data for the warehouse.

All files, scripts, and diagrams required to reproduce the project are included in the repository.

---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

**Goal:**  
Create a SQL-based data warehouse that integrates multiple datasets (ERP + CRM) into a unified model.

**Key Tasks:**
- Import raw CSV data into SQL Server.  
- Clean, validate, and standardize the data.  
- Merge data from both systems into a single analytical model.  
- Use a star schema to support reporting needs.  
- Document the full data model and processing steps.

---

### BI: Analytics & Reporting (Data Analysis)

**Goal:**  
Write analytical SQL queries to generate insights on:
- Customer behavior  
- Product performance  
- Sales trends and KPIs  

These insights help understand business performance and support decision-making.

Detailed requirements are documented in `docs/requirements.md`.

---




