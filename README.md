# Healthcare Operations & Revenue Analytics

> SQL + Python analysis of hospital operations, appointment demand, doctor workload, treatment activity, and billing performance.

![MySQL](https://img.shields.io/badge/MySQL-Database-blue)
![SQL](https://img.shields.io/badge/SQL-Analytics-orange)
![Python](https://img.shields.io/badge/Python-Analytics-yellow)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-purple)

---

## 📌 Business Problem

Healthcare organizations generate large volumes of operational and financial data across patients, doctors, appointments, treatments, and billing.

This project analyzes these interconnected datasets to identify patterns in:

- Patient activity
- Appointment demand
- No-show behavior
- Doctor workload
- Treatment activity
- Billing performance
- Specialization-level demand

The goal is to transform raw relational data into **business KPIs, actionable insights, and data-driven recommendations**.

---

## 🎯 Project Objective

The objective of this project is to use **SQL and Python** to:

- Analyze hospital operations
- Measure key healthcare KPIs
- Identify appointment and treatment trends
- Evaluate doctor workload
- Analyze billing performance
- Compare specialization-level demand
- Identify operational inefficiencies
- Translate analysis into business recommendations

---

## 🗂️ Dataset & Data Model

The project contains five related tables:

| Table | Description |
|---|---|
| `patients` | Patient demographics, registration and insurance information |
| `doctors` | Doctor details, specialization and branch |
| `appointments` | Appointment dates, doctors and appointment status |
| `treatments` | Treatment type, doctor and treatment cost |
| `billing` | Patient/doctor billing transactions and billed amount |

### Data Relationships

```text
Patients
   │
   ├────────── Appointments
   │                │
   │                └──── Doctors
   │                         │
   │                         └──── Treatments
   │
   └────────── Billing
                    │
                    └──── Doctors
```

The analysis uses SQL joins to connect operational activity with treatment and billing information.

---

## 🛠️ Tools & Technologies

- **MySQL** — Database management and SQL analysis
- **SQL** — Data extraction, transformation and business analysis
- **Python** — Analytical workflow
- **Pandas** — Data manipulation and validation
- **SQLAlchemy** — Python-to-MySQL connection
- **Jupyter Notebook** — Analysis and documentation

---

# ❓ Business Questions

## Patient & Hospital Overview

1. How many patients are recorded?
2. How many doctors are available across specializations and branches?
3. How many appointments and treatments are recorded?
4. What is the total and average billing amount?
5. How are patients distributed across gender and insurance providers?

## Appointment & Operations

6. What is the distribution of appointment statuses?
7. What is the monthly appointment trend?
8. Which doctors handle the highest appointment volume?
9. Which specializations receive the most appointments?
10. What is the hospital's no-show rate?
11. Which specializations have the highest appointment demand?

## Treatment Analysis

12. Which treatment types have the highest treatment volume?
13. Which treatment types have the highest treatment costs?
14. Which doctors have the highest treatment activity?
15. Which doctors contribute the highest treatment costs?

## Financial Analysis

16. Which patients have the highest billing amounts?
17. Which doctors generate the highest billed amounts?
18. Which specializations contribute the most billed revenue?
19. How does billing change over time?
20. Which specializations generate the highest billed amount per appointment?

## Advanced Business Analysis

21. Which doctors combine high appointment workload with high billing contribution?
22. How does revenue change month over month?
23. Which doctors rank highest by revenue?
24. Which specializations show high demand relative to available doctor capacity?

---

# 📊 KPI Snapshot

Based on the current project dataset and existing analysis:

| KPI | Result |
|---|---:|
| Total Patients | **50** |
| Total Doctors | **10** |
| Total Appointments | **200** |
| Total Treatments | **200** |
| Total Billing | **₹551,249.85** |
| No-Show Appointments | **52** |
| No-Show Rate | **26%** |
| Highest Appointment Specialization | **Pediatrics — 98 appointments** |
| Highest Appointment Volume by Doctor | **Sarah Taylor — 29 appointments** |
| Highest Treatment Revenue by Doctor | **Sarah Taylor — ₹82,696.48** |
| Highest Average Patient Bill | **Robert Taylor — ₹4,662.05** |
| Highest Monthly Appointment Volume | **April — 25 appointments** |
| Lowest Monthly Appointment Volume | **December — 12 appointments** |

> **Dataset Disclaimer:** These figures are based on the sample dataset used for this portfolio project and do not represent actual hospital performance.

---

# 🔎 Key Insights

## 1. Pediatrics has the highest appointment demand

Pediatrics recorded **98 out of 200 appointments**, representing approximately **49% of all appointments** in the dataset.

This makes Pediatrics the largest appointment-demand specialization in the analysis.

### Business Implication

High appointment concentration in one specialization may require closer monitoring of staffing, scheduling capacity, and patient wait times.

---

## 2. No-shows represent a significant operational issue

The dataset contains **52 no-show appointments**, resulting in a **26% no-show rate**.

This means more than one-quarter of appointment records were classified as no-shows.

### Business Implication

A high no-show rate can reduce doctor utilization and create unused appointment capacity.

---

## 3. Pediatrics shows strong financial contribution

Pediatrics generated **₹258,937.83** in billed revenue in the existing project analysis.

This makes Pediatrics important from both an appointment-demand and financial perspective.

### Business Implication

High-demand and high-revenue specializations should be monitored closely when making resource allocation and capacity planning decisions.

---

## 4. Sarah Taylor has the highest appointment workload

Sarah Taylor handled **29 appointments**, the highest appointment volume among the doctors analyzed.

### Business Implication

Doctors with high appointment volumes should be evaluated alongside treatment activity and billing contribution to understand workload concentration and resource requirements.

---

## 5. Sarah Taylor has the highest treatment revenue contribution

Sarah Taylor generated **₹82,696.48** in treatment revenue, the highest among the doctors analyzed.

### Business Implication

Doctor-level performance should be evaluated using multiple metrics rather than appointment volume alone.

---

## 6. Appointment demand varies across months

April recorded the highest appointment volume with **25 appointments**, while December recorded the lowest with **12 appointments**.

### Business Implication

Monthly demand patterns can help organizations plan staffing, scheduling capacity, and resource allocation.

---

## 7. Patient billing varies considerably

Robert Taylor had the highest average billing amount at **₹4,662.05**.

### Business Implication

Patient-level billing analysis can help identify high-value patient segments and understand variation in billing patterns.

---

# 💼 Business Recommendations

## 1. Reduce Appointment No-Shows

With a **26% no-show rate**, the organization could evaluate:

- Appointment reminder systems
- Confirmation messages
- Rescheduling mechanisms
- No-show tracking
- Follow-up processes

The objective would be to improve appointment utilization.

---

## 2. Monitor High-Demand Specializations

Pediatrics accounts for approximately **49% of appointment records**.

Management could monitor:

- Doctor availability
- Appointment capacity
- Scheduling efficiency
- Patient waiting times
- Demand-to-capacity ratios

---

## 3. Monitor Doctor Workload

Doctors handling unusually high appointment volumes should be monitored alongside:

- Appointment count
- Treatment count
- Revenue contribution
- Revenue per appointment

This can help identify workload concentration and potential capacity constraints.

---

## 4. Track Revenue Alongside Appointment Volume

Revenue should not be evaluated independently.

A more useful performance framework is:

```text
Appointment Volume
        +
Treatment Activity
        +
Revenue
        +
Revenue per Appointment
        ↓
Better Performance Evaluation
```

This provides a more complete picture of specialization and doctor performance.

---

## 5. Monitor Monthly Trends

Monthly appointment and billing trends should be tracked regularly to identify:

- Seasonal demand
- High-demand periods
- Low-demand periods
- Revenue fluctuations
- Capacity requirements

---

# 🧮 SQL Analysis

The project demonstrates the following SQL techniques:

### Core SQL

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`

### Aggregation

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

### Data Analysis

- `CASE WHEN`
- Multiple-table `JOIN`
- Date functions
- Conditional KPI calculations
- Subqueries

### Advanced SQL

- Common Table Expressions (`CTE`)
- `RANK()`
- `LAG()`
- Month-over-month analysis
- Revenue-per-appointment analysis
- Doctor workload analysis

The repository contains a dedicated SQL file:

```text
sql/hospital_analysis.sql
```

This file organizes the main business queries into a structured SQL analysis workflow.

---

# 🐍 Python Analysis

Python was used as a supporting analytical layer to:

- Connect MySQL with SQLAlchemy
- Load relational tables into Pandas
- Inspect data structure
- Check missing values
- Check duplicate records
- Support exploratory analysis
- Validate analytical results

---

# 🔄 Analysis Workflow

```text
Raw Healthcare Data
        ↓
MySQL Database
        ↓
Five Relational Tables
        ↓
Data Quality Checks
        ↓
SQL Exploration
        ↓
Table Joins
        ↓
KPI Calculation
        ↓
Operational Analysis
        ↓
Revenue Analysis
        ↓
Business Insights
        ↓
Recommendations
```

---

# 📁 Project Structure

```text
Hospital-Data-Analysis/
│
├── README.md
│
├── data/
│   ├── patients.csv
│   ├── doctors.csv
│   ├── appointments.csv
│   ├── treatments.csv
│   └── billing.csv
│
├── notebook/
│   └── Hospital_Data_Analysis.ipynb
│
├── sql/
│   └── hospital_analysis.sql
│
└── requirements.txt
```

---

# 🚀 How to Reproduce the Analysis

### 1. Clone the repository

```bash
git clone https://github.com/yatijaiswal435-collab/Hospital-Data-Analysis.git
```

### 2. Create the MySQL database

```sql
CREATE DATABASE healthcare_analysis;
```

### 3. Load the datasets

Import the following files into MySQL:

```text
patients.csv
doctors.csv
appointments.csv
treatments.csv
billing.csv
```

### 4. Run the SQL analysis

Open:

```text
sql/hospital_analysis.sql
```

Run the queries using MySQL Workbench or another MySQL client.

### 5. Explore the Python analysis

Open:

```text
notebook/Hospital_Data_Analysis.ipynb
```

---

# 🔐 Data & Credential Security

This project uses a sample dataset created for analytical and portfolio purposes.

No real patient information is intended to be represented.

**Database credentials should never be committed to GitHub.**

Store credentials locally using environment variables or a `.env` file that is excluded through `.gitignore`.

---

# 📌 Key Takeaway

This project demonstrates how raw relational healthcare data can be transformed into:

```text
Data
  ↓
KPIs
  ↓
Analysis
  ↓
Insights
  ↓
Business Recommendations
```

The analysis goes beyond basic SQL querying by connecting:

- Patient activity
- Appointment demand
- Doctor workload
- Treatment activity
- Billing performance

to provide a structured view of healthcare operations and financial performance.

The project demonstrates my ability to approach data from a **business perspective**, identify meaningful patterns, quantify operational performance, and communicate analytical findings in a way that supports decision-making.

---

# 👤 About Me

## Yati Jaiswal

**Data Analyst | Business Analytics**

I use SQL, Python, Excel, and Power BI to transform data into meaningful insights and support data-driven business decisions.

### Connect With Me

**Portfolio:**  
https://yatijaiswal435-collab.github.io/Yati_Jaiswal_Portfolio/

**LinkedIn:**  
https://www.linkedin.com/in/yati-jaiswal

**Email:**  
yatijaiswal435@gmail.com
