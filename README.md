# Healthcare Operations & Revenue Analytics

> **SQL + Python portfolio project analyzing hospital operations, appointment demand, no-shows, doctor workload, treatment activity, and billing performance.**

![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue)
![SQL](https://img.shields.io/badge/SQL-Analytics-orange)
![Python](https://img.shields.io/badge/Python-Analytics-yellow)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-purple)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange)

---

## Executive Summary

This project analyzes five related healthcare datasets — **patients, doctors, appointments, treatments, and billing** — to turn operational data into measurable KPIs and business insights.

The analysis focuses on appointment demand, no-show behavior, doctor workload, treatment activity, billing performance, revenue per appointment, and monthly revenue movement.

The project demonstrates an end-to-end analytics workflow using **MySQL, SQL, Python, Pandas, SQLAlchemy, and Jupyter Notebook**.

## Business Problem

Healthcare operations generate multiple connected datasets. Looking at each table independently makes it difficult to understand how patient activity, appointment demand, treatment activity, and financial performance relate to one another.

This project connects those datasets to answer practical questions such as:

- Which specializations receive the highest appointment demand?
- What is the hospital's no-show rate?
- Which doctors handle the highest appointment workload?
- Which treatment types have the highest cost?
- Which doctors and specializations generate the highest revenue?
- What is revenue per appointment?
- How is revenue changing month over month?

## Project Objectives

- Measure core hospital KPIs
- Validate data quality and table relationships
- Analyze appointment demand and appointment outcomes
- Identify no-show patterns by specialization and doctor
- Evaluate doctor workload
- Analyze treatment volume and cost
- Measure billing and revenue performance
- Compare specialization-level demand and revenue
- Calculate revenue per appointment
- Rank doctors by revenue
- Translate findings into business recommendations

---

# Dataset & Data Model

| Table | Purpose |
|---|---|
| `patients` | Patient demographics, registration, contact and insurance information |
| `doctors` | Doctor information, specialization, experience and branch |
| `appointments` | Appointment date, patient, doctor and status |
| `treatments` | Treatment type, appointment, doctor and treatment cost |
| `billing` | Billing transactions, treatment reference, bill date and amount |

### Relationship used for revenue analysis

```text
Billing
   ↓
Treatment
   ↓
Appointment
   ↓
Doctor
   ↓
Specialization
```

This is important because it avoids incorrectly joining appointments and billing directly at the doctor level and inflating revenue through row multiplication.

---

# KPI Framework

The notebook calculates these **actual KPIs** rather than hard-coding values in the README.

### Hospital KPIs

- Total Patients
- Total Doctors
- Total Appointments
- Total Treatments
- Total Billing Revenue
- Average Bill Amount
- Highest Bill
- Lowest Bill

### Appointment KPIs

- No-Show Appointments
- No-Show Rate
- Completed Appointments
- Completed Rate
- Cancelled Appointments
- Cancellation Rate

### Operational KPIs

- Appointment Volume by Specialization
- Appointment Volume by Doctor
- No-Show Rate by Specialization
- No-Show Rate by Doctor
- Treatment Volume by Type
- Average Treatment Cost by Type
- Total Treatment Cost by Type

### Financial KPIs

- Total Billing Revenue
- Total Billed Amount by Patient
- Revenue by Doctor
- Revenue by Specialization
- Monthly Revenue
- Month-over-Month Revenue Change
- Revenue per Appointment
- Doctor Revenue Rank
- Doctor Workload vs Revenue

> **Why no KPI numbers are hard-coded here:** the notebook and SQL file calculate the values directly from the database. This prevents the README from becoming outdated when the dataset or calculations change.

---

# Business Questions

These questions correspond directly to analyses implemented in the notebook and SQL file.

## Hospital & Patient Analysis

1. How many patients are recorded?
2. How many doctors are recorded?
3. How many appointments are recorded?
4. How many treatments are recorded?
5. What is the total billing revenue?
6. What is the average billing amount?
7. What are the highest and lowest billing amounts?
8. How are patients distributed by gender?
9. How are patients distributed by insurance provider?

## Appointment & Operations

10. What is the distribution of appointment statuses?
11. How does appointment volume change by month?
12. Which specializations receive the most appointments?
13. Which doctors handle the highest appointment volume?
14. What is the overall no-show rate?
15. Which specializations have the highest no-show rates?
16. Which doctors have the highest no-show rates?

## Treatment Analysis

17. Which treatment types have the highest volume?
18. Which treatment types have the highest average cost?
19. Which treatment types have the highest total cost?
20. Which doctors have the highest treatment activity?

## Revenue Analysis

21. Which patients have the highest total billed amount?
22. Which doctors generate the highest revenue?
23. Which specializations generate the highest revenue?
24. How does revenue change by month?
25. Which specializations generate the highest revenue per appointment?
26. Which doctors combine high appointment workload with high revenue?
27. How are doctors ranked by revenue?
28. What is the month-over-month revenue change?

---

# Data Quality & Validation

The analysis includes checks for:

- Missing primary-key values
- Invalid billing amounts
- Invalid treatment costs
- Unexpected appointment statuses
- Appointment → Patient relationships
- Appointment → Doctor relationships
- Treatment → Appointment relationships
- Billing → Patient relationships
- Billing → Treatment relationships

This makes the project stronger than a simple collection of SELECT/GROUP BY queries because the analytical results are preceded by basic data validation.

---

# Revenue Methodology

A major analytical consideration is avoiding duplicated revenue.

### Risky approach

Joining a doctor's appointments and billing records together before aggregation can create repeated billing rows.

Using `SUM(DISTINCT amount)` is **not** a valid general fix because two legitimate transactions can have the same amount.

### Approach used in this project

Revenue is connected through the actual relational path:

```text
billing → treatment → appointment → doctor
```

Appointment volume and revenue are aggregated independently before calculating **revenue per appointment** or comparing doctor workload with revenue.

This makes the financial metrics more defensible and reproducible.

---

# SQL Skills Demonstrated

- SELECT / WHERE / GROUP BY / ORDER BY
- INNER and LEFT JOIN
- COUNT / SUM / AVG / MIN / MAX
- CASE expressions
- COALESCE and NULLIF
- Common Table Expressions (CTEs)
- Window functions
- RANK()
- LAG()
- Date formatting and monthly aggregation
- KPI calculations
- No-show and cancellation rates
- Revenue-per-appointment analysis
- Doctor workload and revenue analysis
- Month-over-month revenue analysis

# Python Skills Demonstrated

- MySQL connectivity with SQLAlchemy
- Pandas data extraction
- Missing-value validation
- Duplicate checks
- Referential-integrity validation
- KPI calculation
- Grouped analysis
- Trend analysis
- Matplotlib visualization

---

# Business Recommendations

### 1. Reduce appointment no-shows

If the no-show rate is high, evaluate appointment reminders, confirmation workflows, rescheduling options, and targeted follow-up for high-no-show segments.

### 2. Improve capacity planning

Use appointment demand and doctor workload to identify high-demand specializations and doctors with concentrated workloads.

### 3. Monitor revenue efficiency

Evaluate revenue together with appointment volume, treatment activity, and revenue per appointment rather than relying on total revenue alone.

### 4. Monitor monthly movement

Track appointment and revenue trends to support staffing, scheduling, and resource-planning decisions.

### 5. Maintain data quality

Continue validating key relationships and financial fields before using the data for operational reporting.

---

# Project Workflow

```text
Healthcare Data
      ↓
MySQL Database
      ↓
Data Quality Checks
      ↓
Relationship Validation
      ↓
SQL Analysis
      ↓
Python / Pandas Analysis
      ↓
KPIs
      ↓
Operational & Revenue Analysis
      ↓
Business Questions
      ↓
Business Recommendations
```

---

# Repository Structure

```text
Healthcare-Operations-Revenue-Analytics/
│
├── README.md
├── data/
│   ├── patients.csv
│   ├── doctors.csv
│   ├── appointments.csv
│   ├── treatments.csv
│   └── billing.csv
│
├── notebook/
│   └── hospital_data_analysis.ipynb
│
├── sql/
│   └── hospital_analysis.sql
│
└── requirements.txt
```

---

# How to Run

### 1. Open the repository

Open the project repository and use the files described below.

### 2. Create the database

```sql
CREATE DATABASE healthcare_analysis;
```

### 3. Load the five datasets into MySQL

```text
patients.csv
doctors.csv
appointments.csv
treatments.csv
billing.csv
```

### 4. Install Python dependencies

```bash
pip install pandas numpy matplotlib sqlalchemy pymysql cryptography jupyter
```

### 5. Configure the password locally

The notebook does **not** contain the database password.

Windows PowerShell:

```powershell
$env:MYSQL_PASSWORD="your_password"
```

The notebook reads the password with:

```python
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
```

### 6. Run the notebook

```text
notebook/hospital_data_analysis.ipynb
```

### 7. Run the SQL analysis

```text
sql/hospital_analysis.sql
```

---

# Security

**Never commit database credentials to GitHub.**

Use a local environment variable or another secret-management method. Do not place your MySQL password directly inside the public notebook.

---

# Project Outcome

This project demonstrates an end-to-end analytical workflow:

**Relational Data → Validation → SQL/Python Analysis → KPIs → Business Questions → Insights → Recommendations**

The focus is on **correct, reproducible and business-relevant analysis**, not adding complexity for the sake of complexity.

---

# About Me

## Yati Jaiswal

**Data Analyst | Business Analytics**

I use SQL, Python, Excel, and Power BI to transform data into meaningful insights and support data-driven decision-making.

**Portfolio:** https://yatijaiswal435-collab.github.io/Yati_Jaiswal_Portfolio/

**LinkedIn:** https://www.linkedin.com/in/yati-jaiswal

**Email:** yatijaiswal@gmail.com
