/*
-------------------------------------------------------------------------------
Cumulative Analysis
-------------------------------------------------------------------------------
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
-------------------------------------------------------------------------------
*/

--- Calculate the total sales per month ---
--- and the running total of sales over time ---

SELECT 
	order_year,
	TO_CHAR(TO_DATE(order_month::text, 'MM'), 'Month') AS order_month,
	round(CAST (total_sales AS NUMERIC),0) AS total_sales,
	round(CAST (sum(total_sales) OVER (ORDER BY order_year, order_month) AS NUMERIC),0) AS running_total_sales,
	round(CAST (avg_price AS NUMERIC),2) AS moving_average_price
FROM (
	SELECT 
	EXTRACT (YEAR FROM c."date") AS order_year,
	EXTRACT (MONTH FROM c."date") AS order_month,
	sum(a.quantity * b.price) AS total_sales,
	avg(b.price) AS avg_price 
	FROM order_details a
	LEFT JOIN pizzas b 
	ON a.pizza_id = b.pizza_id 
	LEFT JOIN orders c 
	ON a.order_id = c.order_id 
	GROUP BY EXTRACT(YEAR FROM c."date"), EXTRACT (MONTH FROM c."date") 
	ORDER BY order_month
) m