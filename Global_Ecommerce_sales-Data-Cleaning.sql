-- ============================================
-- DATA STAGING
-- Create a staging table based on the raw dataset
-- and copy the raw data into the staging table
-- ============================================

-- Create staging table with the same structure as the raw table

CREATE TABLE staging_ecommerce.ecommerce_sales_staging
LIKE raw_ecommerce.ecommerce_sales_dataset;


-- Copy data from the raw table into the staging table

INSERT INTO staging_ecommerce.ecommerce_sales_staging
SELECT *
FROM raw_ecommerce.ecommerce_sales_dataset;


-- Verify the total number of rows in the staging table

SELECT COUNT(*)
FROM ecommerce_sales_staging;


-- ============================================
-- DATA CLEANING & DATA QUALITY CHECKS
-- Check data quality, missing values, duplicates,
-- and invalid values
-- ============================================


--  Checking and Removing if there any duplicate in the data

SELECT *, 
ROW_NUMBER()
OVER (PARTITION BY Order_ID, Order_Date, `Year`, `Month`, `Quarter`, Season, Customer_ID, Customer_Gender, Customer_Segment, Region, 
Country, Category, Sub_Category, Product_Name, Unit_Price, Quantity, Discount, Revenue, Cost, Profit,`Profit_Margin_%`, Shipping_Cost, 
Shipping_Method, Shipping_Days, Payment_Method, Order_Status ) AS row_num
FROM ecommerce_sales_staging;


--  Creating CTE to create another column call Row_num to chech if there any duplicate

WITH Duplicate_data AS
(
	SELECT *, 
	ROW_NUMBER()
	OVER (PARTITION BY Order_ID, Order_Date, `Year`, `Month`, `Quarter`, Season, Customer_ID, Customer_Gender, Customer_Segment, Region, 
	Country, Category, Sub_Category, Product_Name, Unit_Price, Quantity, Discount, Revenue, Cost, Profit,`Profit_Margin_%`, Shipping_Cost, 
	Shipping_Method, Shipping_Days, Payment_Method, Order_Status ) AS row_num
	FROM ecommerce_sales_staging
)
SELECT*
FROM Duplicate_data
WHERE row_num > 1;



--  To check distinct values to identify inconsistent values, NULLs and Blank values

SELECT DISTINCT Season
FROM ecommerce_sales_staging;

SELECT DISTINCT Customer_Segment
FROM ecommerce_sales_staging;

SELECT DISTINCT Region
FROM ecommerce_sales_staging;

SELECT DISTINCT Country
FROM ecommerce_sales_staging;

SELECT DISTINCT Category
FROM ecommerce_sales_staging;

SELECT DISTINCT Sub_Category
FROM ecommerce_sales_staging;

SELECT DISTINCT Product_Name
FROM ecommerce_sales_staging;

SELECT DISTINCT Shipping_Method
FROM ecommerce_sales_staging;

SELECT DISTINCT Payment_Method
FROM ecommerce_sales_staging;

SELECT DISTINCT Order_Status
FROM ecommerce_sales_staging;

--  checking total rows and identify NULLs values in order_status

SELECT COUNT(*) AS total_rows,
SUM(CASE WHEN Order_Status IS NULL THEN 1 ELSE 0 END) AS null_count
FROM ecommerce_sales_staging;

-- Check for NULL values across key columns in the staging table 


SELECT COUNT(*) AS total_rows,
    SUM(Order_ID IS NULL) AS null_order_id,
    SUM(Customer_ID IS NULL) AS null_customer_id,
    SUM(Product_Name IS NULL) AS null_product,
    SUM(Unit_Price IS NULL) AS null_unit_price,
    SUM(Quantity IS NULL) AS null_quantity,
    SUM(Discount IS NULL) AS null_discount,
    SUM(Revenue IS NULL) AS null_revenue,
    SUM(Profit IS NULL) AS null_profit
FROM ecommerce_sales_staging;


-- Checking total rows and identify NULL or blank values in Order_Status

SELECT COUNT(*) AS total_rows,
       SUM(CASE WHEN Order_Status IS NULL OR Order_Status = '' THEN 1 ELSE 0 END) AS null_or_blank_count
FROM ecommerce_sales_staging;

SELECT *
FROM ecommerce_sales_staging
WHERE Order_Status ='';


-- Check for invalid or negative values in key numeric columns



SELECT *
FROM ecommerce_sales_staging
WHERE Quantity <= 0 ;

SELECT *
FROM ecommerce_sales_staging
WHERE Unit_Price <= 0 ;

SELECT *
FROM ecommerce_sales_staging
WHERE Revenue < 0 ;

SELECT *
FROM ecommerce_sales_staging
WHERE Cost < 0 ;

SELECT *
FROM ecommerce_sales_staging
WHERE Shipping_Cost < 0 ;

SELECT *
FROM ecommerce_sales_staging
WHERE Shipping_Days < 0 ;
