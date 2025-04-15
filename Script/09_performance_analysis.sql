/*
-------------------------------------------------------------------------------
Performance Analysis (Month-over-Month)
-------------------------------------------------------------------------------
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track monthly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
-------------------------------------------------------------------------------
*/

/* Analyze the monthly performance of products by comparing their sales 
to both the average sales performance of the product and the previous month sales */

WITH material AS (
SELECT 
a.quantity ,
b.price ,
c."date" ,
d."name" AS product_name
FROM order_details a
LEFT JOIN pizzas b ON a.pizza_id  = b.pizza_id 
LEFT JOIN orders c ON a.order_id  = c.order_id 
LEFT JOIN pizza_types d ON b.pizza_type_id  = d.pizza_type_id 
),
monthly_product_sales AS (
SELECT 
EXTRACT (MONTH FROM "date") AS order_month,
sum(quantity * price) AS current_sales,
product_name
FROM material
GROUP BY order_month ,product_name
),
monthly_product_sales2 AS (
SELECT 
order_month,
product_name,
round(CAST (current_sales AS NUMERIC ),0) AS current_sales,
round(CAST(avg(current_sales) OVER (PARTITION BY product_name) AS NUMERIC),2)  AS avg_sales,
round(CAST (current_sales - avg(current_sales) OVER (PARTITION BY product_name) AS NUMERIC),2)  AS diff_avg,
CASE 
	WHEN current_sales - avg(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
	WHEN current_sales - avg(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
	ELSE 'Avg'
END AS avg_change,
    --- Month-over-Month Analysis ---
round(CAST(LAG (current_sales) OVER (PARTITION BY product_name ORDER BY order_month) AS NUMERIC),0) AS pm_sales,
round(CAST(current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) AS NUMERIC),0) AS diff_pm,
CASE 
	WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) > 0 THEN 'Increase'
	WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) < 0 THEN 'Decrease'
	ELSE 'No Change'
END AS pm_change
FROM monthly_product_sales 
ORDER BY order_month, product_name
)
SELECT 
TO_CHAR(TO_DATE(order_month::text, 'MM'), 'Month') AS order_months,
product_name,
current_sales,
avg_sales,
diff_avg,
avg_change,
pm_sales,
diff_pm,
pm_change
FROM monthly_product_sales2
