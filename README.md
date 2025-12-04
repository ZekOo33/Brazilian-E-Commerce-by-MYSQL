# 📊 Brazilian E-Commerce Data Analysis Using MySQL  
A full SQL-based analysis of the **Olist Brazilian E-Commerce Public Dataset** (+100k record) , focusing on sales, customers, delivery performance, product insights, and business KPIs.

---

## 📘 Project Overview  
This project analyzes real e-commerce data from Brazil using **pure SQL queries** (no views).  
All insights are generated through a single SQL file:  


The analysis includes sales trend patterns, product revenue, customer behavior, delivery times, review analysis, geographic purchasing behavior, and repeat customer metrics.

---

## 📦 Dataset Source  
This project uses the official dataset published on Kaggle:

🔗 **Brazilian E-Commerce Public Dataset by Olist**  
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---
## 🔍 Business Insights Included  
The SQL queries in this project answer the following:

### ✔ Monthly sales revenue  
### ✔ Top revenue-generating products  
### ✔ Average delivery time per month  
### ✔ Months with low review scores   
### ✔ Average revenue per customer per state  
### ✔ Freight value vs delivery performance  
### ✔ Customer lifetime value (CLV)  
### ✔ Order volume by weekday  
### ✔ Percentage of repeat customers  

All insights are produced manually using custom SQL queries inside `insights.sql`.

---
## 🚀 How to Run the Project
1️⃣ Import the dataset into MySQL

Download CSV files from Kaggle → Import into MySQL tables.
2️⃣ Run the SQL script

Use MySQL Workbench or CLI:
SOURCE insights.sql;

3️⃣ View results
Each query will output a different insight table.

---
## 📈 Future Improvements
Power BI / Tableau dashboard

Product category analytics

Delivery delay prediction model

Customer segmentation (RFM)
