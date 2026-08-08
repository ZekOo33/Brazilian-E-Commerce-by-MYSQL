# 🛒 DOTPY — Olist E-Commerce Business Intelligence Project

![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi&logoColor=black)
![Google Colab](https://img.shields.io/badge/Google%20Colab-Notebook-F9AB00?logo=googlecolab&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> An end-to-end data analytics project using the **Olist Brazilian E-Commerce dataset** — from raw MySQL tables to a fully interactive 6-dashboard Power BI report with Python-powered data preparation in Google Colab.

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Pipeline Walkthrough](#-pipeline-walkthrough)
- [Key Findings](#-key-findings)
- [Dashboards](#-dashboards)
- [How to Run](#-how-to-run)
- [Dataset](#-dataset)

---

## 📌 Project Overview

This project performs a full business intelligence analysis on the **Olist Brazilian E-Commerce** dataset covering **~100K orders** across 2016–2018.

The pipeline covers:
- **MySQL** — Database creation, foreign key setup, and SQL export
- **Python (Google Colab)** — Data cleaning, feature engineering, and CSV exports
- **Power BI** — 6 interactive dashboards with DAX measures and derived columns

---

## 🛠 Tech Stack

| Layer | Tool |
|---|---|
| Database | MySQL 8.0 |
| Data Preparation | Python 3.10, Pandas, NumPy (Google Colab) |
| Visualization | Power BI Desktop |
| Export Format | CSV → Power BI |
| Report | PDF (ReportLab) |

---

## 📁 Project Structure

```
olist-bi-project/
│
├── sql/
│   ├── Database_creation.sql       # Schema + table definitions
│   └── alter_fk.sql                # Foreign key constraints + data cleanup
│
├── python/
│   └── olist_analysis.ipynb        # Full Google Colab pipeline (Steps 1–13)
│
├── exports/                        # CSV files exported from Colab → loaded into Power BI
│   ├── orders_items_export.csv
│   ├── final_monthly_sales.csv
│   ├── final_customer_segments.csv
│   ├── final_product_summary.csv
│   ├── final_delivery_summary.csv
│   ├── final_location_summary.csv
│   └── final_orders_with_reviews.csv
│
├── powerbi/
│   └── DOTPY.pbix                  # Power BI report (6 dashboards)
│
├── report/
│   └── DOTPY_Findings.pdf          # 1-page executive findings report
│
└── README.md
```

---

## 🔄 Pipeline Walkthrough

### Stage 1 — MySQL Database Setup
- Created schema `retailco_olist` with 5 tables: `olist_orders`, `olist_order_items`, `olist_customers`, `olist_reviews`, `olist_geolocation`
- Added foreign key constraints with orphan review cleanup
- Exported joined data as `orders_items_export.csv` via SQL JOIN across 3 tables

### Stage 2 — Python Data Preparation (Google Colab)

**Step 1 — Data Loading & Inspection**
Loaded 3 CSVs into `df_orders_items`, `df_reviews`, `df_geo` and built a `dataset_info` dictionary.

**Step 2 — Custom Functions Defined**

| Function | Purpose |
|---|---|
| `clean_location_text(x)` | Standardizes city (Title Case) and state (UPPERCASE) text |
| `calc_delivery_days(purchase, delivered)` | Returns delivery duration in days; NaN for invalid/missing |
| `classify_review(score)` | Maps score → Positive / Neutral / Negative / Unknown |
| `segment_customer(spend, orders, recency)` | Assigns VIP / Loyal / New / At Risk / Regular |
| `classify_delivery_risk(avg_days)` | Maps avg days → Low / Medium / High Delay |

**Steps 3–7 — Cleaning & Feature Engineering**
- Standardized all column names (lowercase + underscores)
- Fixed dtypes: numeric (`price`, `freight_value`, `review_score`) and datetime fields
- Applied `clean_location_text()` to city and state columns
- Created business columns: `order_month`, `order_year`, `delivery_days`, `delivery_status`, `late_delivery_flag`
- Built `df_order_revenue` — order-level revenue summary

**Step 8 — Review Merge**
Left-joined `df_order_revenue` with `df_reviews`; applied `classify_review()` to create `review_level`.

**Steps 9–12 — Analytical Summaries**

| DataFrame | Description |
|---|---|
| `df_customer_summary` | Segmentation via `segment_customer()` using a for loop |
| `df_product_summary` | Revenue, orders, Top/Mid/Low class via `numpy.percentile` |
| `df_month_delivery` | Monthly delivery KPIs + `classify_delivery_risk()` |
| `df_location_summary` | Revenue and customers by state + city |

**Step 13 — Export**
6 clean CSVs exported for Power BI ingestion.

### Stage 3 — Power BI Dashboards

**Derived Columns (DAX Calculated Columns)**

| Column | Table | Logic |
|---|---|---|
| `Revenue_Band` | `final_orders_with_reviews` | < 100 → Small, 100–500 → Medium, > 500 → High |
| `Delivery_Band` | `final_delivery_summary` | ≤ 5 days → On Time, > 5 → Late |
| `Customer_Type` | `final_customer_segments` | total_orders > 1 → Repeat, else One-Time |

**DAX Measures**

```dax
Total Revenue       = SUM(final_orders_with_reviews[total_order_value])
Total Orders        = DISTINCTCOUNT(final_orders_with_reviews[order_id])
Avg Order Value     = DIVIDE([Total Revenue], [Total Orders], 0)
Avg Delivery Days   = AVERAGE(final_delivery_summary[avg_delivery_days])
Avg Review Score    = AVERAGE(final_orders_with_reviews[review_score])
Repeat Customer %   = DIVIDE(COUNTROWS(FILTER(...Customer_Type = "Repeat")), COUNTROWS(...), 0) * 100
Late Delivery %     = DIVIDE(COUNTROWS(FILTER(...Delivery_Band = "Late")), COUNTROWS(...), 0) * 100
MoM Growth %        = DIVIDE(CurrentMonth - PrevMonth, PrevMonth, 0) * 100
```

---

## 📊 Key Findings

| Area | Finding |
|---|---|
| 💰 Revenue | R$ 16M total revenue; Q4 2017 peak driven by Black Friday |
| 👥 Customers | Regular segment is largest; VIP customers drive outsized revenue |
| 📦 Products | Top 20% of products generate the majority of revenue |
| 🚚 Delivery | Avg 12–15 days — classified as High Delay; correlates with lower reviews |
| 📍 Location | São Paulo dominates; northern states are untapped markets |
| ⭐ Reviews | Avg score 4.09 exceeds 4.0 target; late deliveries score ~0.8 pts lower |

---

## 📈 Dashboards

| # | Dashboard | Key Visuals |
|---|---|---|
| 1 | Executive Overview | Revenue cards, MoM trend, KPI indicator |
| 2 | Customer Dashboard | Segment donut, Top 10 customers, Repeat vs One-Time |
| 3 | Product Dashboard | Top 10 products, revenue treemap, class distribution |
| 4 | Delivery Dashboard | Monthly trend, freight scatter, risk donut |
| 5 | Location Dashboard | Filled map by state, top cities bar chart |
| 6 | Review Dashboard | Score trend, review level donut, delivery vs review scatter |

---

## ▶ How to Run

### 1. MySQL Setup
```sql
-- Run in order:
source sql/Database_creation.sql
-- Import CSVs into tables via MySQL Workbench
source sql/alter_fk.sql
```

### 2. Export orders_items_export.csv
Run the JOIN query from `alter_fk.sql` and export result as CSV from MySQL Workbench.

### 3. Google Colab
```
1. Upload orders_items_export.csv, olist_reviews.csv, olist_geolocation.csv
2. Open notebooks/olist_analysis.ipynb
3. Run all cells in order (Steps 1 → 13)
4. Download the 6 exported CSVs from /content/
```

### 4. Power BI
```
1. Open powerbi/DOTPY.pbix
2. If prompted, update data source paths to your local exports/ folder
3. Refresh all tables
4. All DAX measures and derived columns are pre-built
```

---

## 📂 Dataset

- **Source:** [Olist Brazilian E-Commerce — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Size:** ~100K orders, 2016–2018
- **Tables used:** orders, order_items, customers, reviews, geolocation

---

<p align="center">
  Built with Python, MySQL & Power BI &nbsp;|&nbsp; August 2026
</p>
