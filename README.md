# 🏥 Healthcare Data Analytics Project

![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-blue)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![Excel](https://img.shields.io/badge/Excel-Dataset-green)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 Project Overview

An end-to-end data analytics project on a real-world healthcare dataset with **10,000+ patient records**.  
The project covers data cleaning, SQL analysis, and an interactive Power BI dashboard.

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| SQL Server (T-SQL) | Data Cleaning & Analysis |
| Power BI | Dashboard & Visualization |
| Microsoft Excel | Raw Dataset |

---

## 📁 Repository Structure

```
📁 Healthcare-Data-Analysis
   ├── 📄 HealthcareAnalysis.sql
   ├── 📊 Healthcare.pbix
   ├── 📂 healthcare_data.xlsx
   └── 📄 README.md
```

---

## 🔍 SQL Analysis

### ✅ Data Cleaning
- Removed NULL values from `Billing_Amount`
- Detected duplicates using `ROW_NUMBER()` with `PARTITION BY`
- Engineered `Length_of_Stay` column using `DATEDIFF`

### 📊 Business Insights (15+ Queries)

| # | Insight | SQL Concept |
|---|---------|-------------|
| 1 | Total Patients & Revenue | Aggregation |
| 2 | Average Billing by Hospital | GROUP BY |
| 3 | Top Medical Conditions by Cost | ORDER BY |
| 4 | Age Group Segmentation | CASE WHEN |
| 5 | Gender Distribution | GROUP BY |
| 6 | Doctor Performance Ranking | DENSE_RANK() |
| 7 | Running Revenue Over Time | SUM() OVER() |
| 8 | Insurance Revenue Analysis | Aggregation |
| 9 | Top 10 High Billing Patients | CTE + TOP N |
| 10 | Hospital Summary | CREATE VIEW |

### 🏆 Key SQL Queries

```sql
-- Running Revenue using Window Function
SELECT Date_of_Admission,
  SUM(Billing_Amount) AS daily_revenue,
  SUM(SUM(Billing_Amount)) OVER (ORDER BY Date_of_Admission) AS running_revenue
FROM healthcare_data
GROUP BY Date_of_Admission;

-- Doctor Performance Ranking
SELECT Doctor,
  SUM(Billing_Amount) AS total_bill,
  DENSE_RANK() OVER (ORDER BY SUM(Billing_Amount) DESC) AS ranking
FROM healthcare_data
GROUP BY Doctor;

-- Age Group Segmentation
SELECT
  CASE
    WHEN Age < 18 THEN 'Child'
    WHEN Age BETWEEN 18 AND 35 THEN 'Young'
    WHEN Age BETWEEN 36 AND 60 THEN 'Adult'
    ELSE 'Senior'
  END AS age_group,
  COUNT(*) AS total_patients
FROM healthcare_data
GROUP BY
  CASE
    WHEN Age < 18 THEN 'Child'
    WHEN Age BETWEEN 18 AND 35 THEN 'Young'
    WHEN Age BETWEEN 36 AND 60 THEN 'Adult'
    ELSE 'Senior'
  END;

-- Hospital Summary View
CREATE VIEW hospitalsummary AS
SELECT Hospital,
  COUNT(*) AS total_patients,
  SUM(Billing_Amount) AS total_bill,
  AVG(Length_of_Stay) AS avg_stay
FROM healthcare_data
GROUP BY Hospital;
```

---

## 📊 Power BI Dashboard

### 4-Page Interactive Dashboard

| Page | Content |
|------|---------|
| Page 1 — Overview | KPI Cards, Gender Split, Age Group, Admission Type |
| Page 2 — Revenue | Revenue by Condition, Insurance Donut, Revenue Trend |
| Page 3 — Patient Insights | Patients by Condition, Avg Stay, Test Results, Gender Split |
| Page 4 — Performance | Top Hospitals, Doctor Rankings, Hospital Summary, Scatter Chart |

### ⚙️ DAX Measures Used

```dax
Total Revenue = SUM(healthcare_data[Billing_Amount])
Total Patients = COUNT(healthcare_data[Name])
Avg Billing = AVERAGE(healthcare_data[Billing_Amount])
Avg Stay = AVERAGE(healthcare_data[Length_of_Stay])
Doctor Rank = RANKX(ALLSELECTED(healthcare_data[Doctor]),SUM(healthcare_data[Billing_Amount]),,DESC,DENSE)
```

---

## 💡 Key Insights

- 🔴 **Cancer & Diabetes** topped the billing charts
- 💙 **Medicare** leads all insurance providers by revenue
- 🏥 **Average patient stay** is **15.5 days** across all conditions
- 👥 **Adult & Senior** age groups dominate admissions
- ⚕️ **Test Results** — Abnormal (33.5%), Normal (33.4%), Inconclusive (33.1%)

---

## 📸 Dashboard Screenshots

### Page 1 — Overview
<img width="575" height="322" alt="Page 1 — Overview (KPIs, Gender, Age Group, Admission Type)" src="https://github.com/user-attachments/assets/b13770b7-7e60-4429-84a7-72c2146d1445" />


### Page 2 — Revenue Analysis
<img width="479" height="300" alt="Page 2 — Revenue Analysis (Treemap, Donut, Revenue Trend)" src="https://github.com/user-attachments/assets/84b59300-f8c1-4896-9782-0550461cd21d" />


### Page 3 — Patient Insights
<img width="478" height="298" alt="Page 3 — Patient Insights (Conditions, Avg Stay, Test Results)" src="https://github.com/user-attachments/assets/fc572994-5855-4bc1-9535-f73ea29c5ec0" />


### Page 4 — Doctor & Hospital Performance
<img width="480" height="299" alt="Page 4 — Doctor   Hospital Performance (Rankings, Scatter Chart)" src="https://github.com/user-attachments/assets/1e874f4e-8dd2-4982-9d51-5350d0924379" />


---

## 👤 Author

**Keshav Sarwade**  
QC Microbiologist & Data Analyst  
📧 Connect on [LinkedIn](https://www.linkedin.com/in/)  
🐙 GitHub: [Keshavsaravade8](https://github.com/Keshavsaravade8)

---

⭐ If you found this project helpful, please give it a star!
