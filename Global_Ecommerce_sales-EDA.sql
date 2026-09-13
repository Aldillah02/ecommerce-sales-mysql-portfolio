-- ============================================
-- EXPLORATORY DATA ANALYSIS (EDA)
-- Explore sales performance, customer behavior,
-- product performance, and business trends
-- ============================================

-- Check the overall dataset

SELECT	COUNT(*) AS total_rows,
		COUNT(DISTINCT Order_ID) AS total_orders,
		COUNT(DISTINCT Customer_ID) AS unique_customers,
		COUNT(DISTINCT Product_Name) AS unique_products,
		COUNT(DISTINCT Category) AS unique_categories
FROM ecommerce_sales_staging;


-- Explore value ranges, discount levels, profit metrics, and order date coverage


SELECT	MIN(Discount),
		MAX(Discount)
FROM ecommerce_sales_staging;

SELECT *
FROM ecommerce_sales_staging
WHERE Discount = '0.5';

SELECT	MIN(Profit),
		MAX(Profit)
FROM ecommerce_sales_staging;

SELECT	MIN(`Profit_Margin_%`),
		MAX(`Profit_Margin_%`)
FROM ecommerce_sales_staging;

SELECT	MIN(Order_Date) AS earliest_order,
		MAX(Order_Date) AS latest_order
FROM ecommerce_sales_staging;

SELECT	MIN(`Year`) AS earliest_year,
		MAX(`Year`) AS latest_year
FROM ecommerce_sales_staging;

SELECT	MIN(`Month`) AS earliest_Month,
		MAX(`Month`) AS latest_Month
FROM ecommerce_sales_staging;

SELECT	MIN(`Quarter`),
		MAX(`Quarter`)
FROM ecommerce_sales_staging;




-- Validate the relationships between price, quantity, discount, revenue, cost, and profit


SELECT Order_ID, Unit_Price, Quantity, Discount, Revenue, Cost, Profit
FROM ecommerce_sales_staging
LIMIT 10;

SELECT Order_ID, Revenue, Cost, Profit,
	(Revenue - Cost) AS calculated_profit
FROM ecommerce_sales_staging
WHERE ABS(Profit - (Revenue - Cost)) > 0.01;

SELECT Order_ID, Revenue, Cost, Profit,
    (Revenue - Cost) AS calculated_profit
FROM ecommerce_sales_staging
WHERE Profit <> (Revenue - Cost);

SELECT Order_ID, Revenue, Cost, Profit,
    (Revenue - Cost) AS calculated_profit
FROM ecommerce_sales_staging
WHERE ROUND(Profit, 2) <> ROUND(Revenue - Cost, 2);

SELECT Order_ID, Unit_Price, Quantity, Discount, Revenue,
    (Unit_Price * Quantity * (1 - Discount)) AS calculated_revenue,
    Revenue - (Unit_Price * Quantity * (1 - Discount)) AS difference
FROM ecommerce_sales_staging
WHERE ROUND(Revenue, 2) <>
      ROUND(Unit_Price * Quantity * (1 - Discount), 2);
      
SELECT
    COUNT(*) AS total_different_records
FROM ecommerce_sales_staging
WHERE ROUND(Revenue, 2) <>
      ROUND(Unit_Price * Quantity * (1 - Discount), 2);

-- 264 records showed very small decimal differences.
-- The differences were negligible and were considered
-- rounding/decimal precision differences.
-- No records were removed or modified.



-- Analyze sales and profit performance overall and by product category

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Revenue), 2) AS avg_revenue,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM ecommerce_sales_staging;

SELECT Category,
			COUNT(*) AS total_orders,
			ROUND(SUM(Revenue), 2) AS total_revenue,
			ROUND(SUM(Profit), 2) AS total_profit,
			ROUND(AVG(Revenue), 2) AS avg_revenue,
			ROUND(AVG(Profit), 2) AS avg_profit
FROM ecommerce_sales_staging
GROUP BY Category
ORDER BY total_revenue DESC;

SELECT Region,
		COUNT(*) AS total_orders,
		ROUND(SUM(Revenue), 2) AS total_revenue,
		ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales_staging
GROUP BY Region
ORDER BY total_revenue DESC;


-- Analyze total profit by product category

SELECT Category, ROUND (SUM(Profit),2) AS total_profit
FROM ecommerce_sales_staging
GROUP BY Category
ORDER BY 2 DESC;


-- To Analyze order volume and quantity sold by year

SELECT 
    `Year`,
    COUNT(*) AS total_orders,
    SUM(Quantity) AS total_quantity_sold
FROM ecommerce_sales_staging
GROUP BY `Year`
ORDER BY `Year`;


-- Analyze yearly trends in order volume, revenue, and profit

SELECT
    YEAR(Order_Date) AS year,
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales_staging
GROUP BY YEAR(Order_Date)
ORDER BY year DESC;



-- Analyze the top 5 products by revenue, including order volume and profit

SELECT Product_Name,
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales_staging
GROUP BY Product_Name
ORDER BY total_revenue DESC
LIMIT 5;


-- Analyze sales and profit performance by discount level

SELECT Discount,
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales_staging
GROUP BY Discount
ORDER BY Discount;