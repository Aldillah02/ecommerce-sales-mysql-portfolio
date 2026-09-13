-- https://www.kaggle.com/datasets/abdelfattahibrahim/global-e-commerce-sales-dataset-20212024

SELECT *
FROM ecommerce_sales_dataset;

SELECT COUNT(*) AS total_rows
FROM ecommerce_sales_dataset;
 
USE raw_ecommerce ;
DESCRIBE ecommerce_sales_dataset;

SELECT *
FROM raw_ecommerce;
SHOW DATABASES;
SHOW TABLES;
SELECT *
FROM raw_ecommerce.ecommerce_sales_dataset;