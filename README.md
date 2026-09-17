# E-Commerce Sales Analysis Using MySQL

## Project Overview

This project analyzes an e-commerce sales dataset using MySQL.

The main objectives of this project are to practice data cleaning, data validation, exploratory data analysis (EDA), and extracting business insights from sales data.

The analysis focuses on sales performance, profitability, product categories, regions, yearly trends, and the impact of discounts.

---

## Dataset
- https://www.kaggle.com/datasets/abdelfattahibrahim/global-e-commerce-sales-dataset-20212024
- Dataset: Global E-Commerce Sales Dataset
- Total Records: 10,000
- Total Columns: 26
- Date Range: January 5, 2021 – December 24, 2024

The dataset contains information about orders, customers, products, sales, costs, discounts, shipping, payment methods, and order status.

### Main Data Fields

- Order information
- Customer information
- Product and category information
- Revenue and cost
- Profit and profit margin
- Discount
- Shipping information
- Payment method
- Order status

---

## Tools Used

- MySQL
- SQL
- GitHub
- Microsoft Excel

---

## Project Workflow

### 1. Raw Data

The original dataset was imported into a separate `raw` schema to preserve the original data.

File:

`Global_Ecommerce_sales-Raw_data.sql`

### 2. Data Cleaning

A staging table was created from the raw data for data validation and cleaning.

The following checks were performed:

- Duplicate records
- NULL and blank values
- Invalid quantity values
- Invalid unit prices
- Invalid revenue values
- Invalid cost values
- Invalid shipping costs
- Data consistency checks
- Revenue calculation validation

File:

`Global_Ecommerce_sales-Data-Cleaning.sql`

### 3. Exploratory Data Analysis

After data validation, SQL queries were used to explore:

- Overall sales and profit
- Sales by product category
- Sales and profit by region
- Yearly sales performance
- Discount and profitability
- Average revenue and profit

File:

`Global_Ecommerce_sales-EDA.sql`

---

## Key Findings

### Overall Performance

- Total Revenue: **5,284,387.70**
- Total Profit: **1,437,638.31**
- Average Revenue per Record: **528.44**
- Average Profit per Record: **143.76**

### Performance by Category

**Electronics** generated the highest revenue and profit among the product categories.

- Revenue: **3,382,028.46**
- Profit: **925,448.15**

Other categories included:

- Home & Kitchen
- Clothing
- Books & Media
- Beauty & Health

### Performance by Region

The **Middle East** recorded the highest revenue and profit among the regions analyzed.

- Revenue: **1,348,593.22**
- Profit: **384,522.85**

### Yearly Performance

**2023** recorded the highest revenue and profit in the dataset.

- Revenue: **2,308,640.02**
- Profit: **625,276.12**

### Discount Analysis

The analysis also examined profitability across different discount levels.

Higher discount levels showed a significant relationship with lower profitability in the dataset. At a **50% discount**, the total profit was negative:

- Total Profit: **-53,847.48**

---

## Business Insights

Based on the exploratory analysis:

1. Electronics was the strongest product category in terms of revenue and profit.
2. The Middle East generated the highest regional revenue and profit.
3. 2023 was the strongest year in the analyzed period.
4. Higher discounts were associated with lower profitability, with the 50% discount level producing negative total profit.
5. Profitability should be considered alongside revenue when evaluating sales performance.

---

## SQL Skills Demonstrated

This project demonstrates the use of:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- Aggregate functions such as `SUM()`, `COUNT()`, and `AVG()`
- `ROUND()`
- `DISTINCT`
- `CASE`
- Common Table Expressions (CTEs)
- Window functions
- Date functions
- Data validation techniques
- Duplicate detection
- NULL and blank value checks
- Data consistency checks

---
