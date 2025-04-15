/*
-------------------------------------------------------------------------------
Change Over Time Analysis
-------------------------------------------------------------------------------
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: EXTRACT (YEAR  FROM),TO_CHAR(),DATE_TRUNC ()
    - Aggregate Functions: SUM(), COUNT()
    - CAST () , ROUND ()
-------------------------------------------------------------------------------
*/

--- Analyse sales performance over time ---
--- Quick Date Functions ---

SELECT 
	EXTRACT (YEAR  FROM c."date") AS order_year,
	TO_CHAR(c."date", 'Month') AS order_month,
	sum (total_sales) AS Total_Sales,
	sum (total_customer) AS Total_Customer,
	sum (total_quantity) AS Total_Quantity
FROM 
(SELECT 
	a.order_id,
	round(CAST (sum( a.quantity * b.price) AS NUMERIC),2) AS total_sales,
	count( DISTINCT a.order_id) AS total_customer,
	sum(a.quantity) AS total_quantity 
FROM order_details a
LEFT JOIN pizzas b
ON a.pizza_id = b.pizza_id 
GROUP BY a.order_id ) m
LEFT JOIN orders c
ON c.order_id  = m.order_id
GROUP BY order_year, order_month
ORDER BY MIN(c."date")


--- DATE_TRUNC () ---

SELECT 
	DATE_TRUNC ('year', c."date") AS order_date,
	sum (total_sales) AS Total_Sales,
	sum (total_customer) AS Total_Customer,
	sum (total_quantity) AS Total_Quantity
FROM 
(SELECT 
	a.order_id,
	round(CAST (sum( a.quantity * b.price) AS NUMERIC),2) AS total_sales,
	count(DISTINCT a.order_id) AS total_customer,
	sum(a.quantity) AS total_quantity 
FROM order_details a
LEFT JOIN pizzas b
ON a.pizza_id = b.pizza_id 
GROUP BY a.order_id ) m
LEFT JOIN orders c
ON c.order_id  = m.order_id
GROUP BY DATE_TRUNC ('year', c."date")
