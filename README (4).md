# 🏥 Healthcare Data Analysis — SQL & Python

### Turning hospital data into actionable healthcare and business insights

## 🔎 Project Overview

**Healthcare Data Analysis** is a data analytics project that combines **MySQL, SQL, Python, Pandas, and SQLAlchemy** to analyze hospital operations.

The project connects Python to a MySQL healthcare database, imports multiple relational tables into Pandas DataFrames, performs basic data-quality checks, and uses SQL queries to answer practical healthcare business questions.

The analysis focuses on:

- Patients
- Doctors
- Appointments
- Treatments
- Billing and revenue
- Doctor and specialization performance
- Appointment trends and status
- Patient activity

---

## 🎯 Business Questions

The project answers questions such as:

1. How many patients are registered?
2. How many doctors work in the hospital?
3. What is the total revenue generated?
4. How many treatments have been performed?
5. What are the highest- and lowest-cost treatments?
6. How many doctors are available in each specialization?
7. How are doctors distributed across hospital branches?
8. How do appointments vary by month?
9. Which doctor handles the highest number of appointments?
10. Which specialization receives the most appointments?
11. What is the distribution of appointment statuses?
12. Which doctor generates the highest treatment revenue?
13. Which specialization generates the highest revenue?
14. Which patient has the highest average bill amount?
15. Which patient has the highest number of appointments?

---

## 🗂️ Database Structure

The MySQL database contains **five relational tables**:

```text
healthcare_analysis
│
├── patients
├── doctors
├── appointments
├── treatments
└── billing
```

### 👤 Patients

Contains patient-level information such as:

- Patient ID
- Name
- Gender
- Date of Birth
- Contact Number
- Address
- Registration Date
- Insurance Provider
- Insurance Number
- Email

### 👨‍⚕️ Doctors

Contains information about:

- Doctor ID
- Name
- Specialization
- Phone Number
- Years of Experience
- Hospital Branch
- Email

### 📅 Appointments

Contains:

- Appointment ID
- Patient ID
- Doctor ID
- Appointment Date
- Appointment Time
- Reason for Visit
- Appointment Status

### 💊 Treatments

Contains:

- Treatment ID
- Appointment ID
- Treatment Type
- Description
- Treatment Cost
- Treatment Date

### 💰 Billing

Contains:

- Bill ID
- Patient ID
- Treatment ID
- Bill Date
- Amount
- Payment Method
- Payment Status

---

## 🧹 Data Quality Checks

Before performing the analysis, the project checks the data using Pandas.

The following checks were performed:

- Missing-value analysis
- Duplicate-record analysis
- Basic table inspection using `.head()`

All five analyzed tables showed:

- **No missing values**
- **No duplicate records**

---

## 📊 Key Findings

Based on the analysis performed in the notebook:

| KPI | Result |
|---|---:|
| Total Patients | **50** |
| Total Doctors | **10** |
| Total Treatments | **200** |
| Total Billing Revenue | **551,249.85** |

### 👥 Patient Distribution

The dataset contains:

- **31 male patients**
- **19 female patients**

### 👨‍⚕️ Doctors by Specialization

| Specialization | Doctors |
|---|---:|
| Pediatrics | 5 |
| Dermatology | 3 |
| Oncology | 2 |

### 🏥 Doctors by Hospital Branch

| Hospital Branch | Doctors |
|---|---:|
| Central Hospital | 4 |
| Westside Clinic | 3 |
| Eastside Clinic | 3 |

### 📅 Monthly Appointments

The highest number of appointments occurred in **April with 25 appointments**.

The monthly appointment counts were:

| Month | Appointments |
|---|---:|
| January | 20 |
| February | 14 |
| March | 19 |
| April | 25 |
| May | 19 |
| June | 18 |
| July | 16 |
| August | 15 |
| September | 11 |
| October | 14 |
| November | 17 |
| December | 12 |

### 👨‍⚕️ Doctor with the Most Appointments

**Sarah Taylor** handled the highest number of appointments with **29 appointments**.

### 🩺 Appointments by Specialization

| Specialization | Appointments |
|---|---:|
| Pediatrics | 98 |
| Dermatology | 70 |
| Oncology | 32 |

**Pediatrics** had the highest appointment volume.

### 📌 Appointment Status

| Status | Count |
|---|---:|
| No-show | 52 |
| Scheduled | 51 |
| Cancelled | 51 |
| Completed | 46 |

The analysis shows that **No-show appointments were the most frequent status** in the dataset.

### 💰 Revenue by Specialization

| Specialization | Revenue |
|---|---:|
| Pediatrics | 258,937.83 |
| Dermatology | 202,709.29 |
| Oncology | 89,602.73 |

**Pediatrics generated the highest treatment revenue** among the three specializations.

### 🏆 Doctor with Highest Treatment Revenue

**Sarah Taylor** generated the highest treatment revenue at **82,696.48**.

### 💳 Highest Average Patient Bill

**Robert Taylor** had the highest average billing amount at **4,662.05**.

### 📅 Patient with the Most Appointments

**Laura Davis** had the highest number of appointments with **10 appointments**.

---

## 💻 Technologies Used

- **Python**
- **Pandas**
- **SQLAlchemy**
- **MySQL**
- **SQL**
- **Jupyter Notebook**

---

## 🧠 SQL Concepts Demonstrated

This project demonstrates practical use of:

- `SELECT`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MAX()`
- `MIN()`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- `LIMIT`
- Subqueries
- Aggregate functions
- `INNER JOIN`
- Filtering and sorting
- Date functions such as `MONTH()`
- Multi-table relational analysis

---

## 🐍 Python & Pandas Skills Demonstrated

Python was used to connect to the MySQL database and work with the extracted data.

Key techniques include:

```python
from sqlalchemy import create_engine
import pandas as pd

engine = create_engine("mysql+pymysql://...")

query = "SELECT * FROM patients;"
patients_df = pd.read_sql(query, engine)

patients_df.head()
patients_df.isna().sum()
patients_df.duplicated().sum()
```

This workflow demonstrates how Python can be used alongside SQL for data analysis.

---

## 🔄 Analysis Workflow

```text
MySQL Healthcare Database
          ↓
     SQLAlchemy
          ↓
   Python Connection
          ↓
      SQL Queries
          ↓
    Pandas DataFrames
          ↓
   Data Quality Checks
          ↓
    Exploratory Analysis
          ↓
 Business Questions
          ↓
     Key Insights
```

---

## 💼 Business Value

This project demonstrates how healthcare data can be used to support operational and business decisions.

The analysis can help hospital stakeholders understand:

- Patient volume
- Doctor workload
- Appointment demand
- Appointment cancellations and no-shows
- Treatment activity
- Revenue contribution by doctor
- Revenue contribution by specialization
- Patient billing patterns
- Hospital branch staffing distribution

These insights can support further investigation into **resource planning, appointment management, doctor workload, and revenue performance**.

> **Note:** The findings represent the specific dataset analyzed in this project and should not be generalized to real-world healthcare operations without additional data and validation.

---

## 🚀 Learning Outcomes

Through this project, I strengthened my ability to:

- Connect Python to a MySQL database
- Work with relational healthcare data
- Write SQL queries for business questions
- Perform joins across multiple tables
- Use aggregate functions
- Analyze time-based appointment trends
- Perform data-quality checks with Pandas
- Combine SQL and Python in an analytics workflow
- Extract business insights from structured data
- Translate business questions into analytical queries

---

## 📁 Repository Structure

```text
Healthcare-Data-Analysis/
│
├── healthcare_data_analysis.ipynb
├── README.md
└── screenshots/
    └── analysis_preview.png
```

The notebook contains the complete SQL and Python analysis.

---

## 📌 Project Skills

**SQL • MySQL • Python • Pandas • SQLAlchemy • Data Cleaning • Data Analysis • Relational Databases • Business Analysis • Healthcare Analytics**

---

## 🧠 Key Takeaway

> **Good data analysis is not just about writing SQL queries. It is about using data to answer meaningful business questions and turn the results into actionable insights.**

This project demonstrates an end-to-end analytical workflow using **MySQL + SQL + Python + Pandas** on a healthcare dataset.

---

## 👩‍💻 About

This project is part of my **Data Analytics Portfolio** and demonstrates my practical skills in **SQL, Python, Pandas, MySQL, data analysis, and business problem-solving**.

**Created by: Yati Jaiswal**
