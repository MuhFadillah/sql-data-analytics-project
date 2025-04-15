/*
-------------------------------------------------------------------------------
Measures Exploration (Key Metrics)
-------------------------------------------------------------------------------
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG(),CAST(), ROUND ()
-------------------------------------------------------------------------------
*/

--- Find the Total Sales ---

SELECT
	round(CAST (sum(sales) AS NUMERIC) ,0) AS total_sales
FROM 
(SELECT 
	a.order_id ,
	a.pizza_id ,
	a.quantity ,
	b.price ,
	a.quantity * b.price AS sales
FROM order_details a
LEFT JOIN pizzas b
ON a.pizza_id = b.pizza_id ) t

--- Find how many items are sold ---

SELECT 
	sum(quantity) AS total_quantity 
FROM order_details od 

--- Find the average selling price ---

SELECT 
 round(CAST(avg(price) AS NUMERIC),2) AS  avg_price
FROM pizzas p 

--- Find the Total number of Orders ---

SELECT 
	count(order_details_id) AS total_orders
FROM order_details od 

--- Find the total number of products ---

SELECT 
	count("name") AS total_product 
FROM pizza_types pt 

--- Find the total number of customers that has placed an order ---

SELECT 
	count(DISTINCT order_id) AS total_customers 
FROM order_details od ;


--- Generate a Report that shows all key metrics of the business ---

SELECT
	'Total Sales' AS measure_name,
	round(CAST (sum(sales) AS NUMERIC) ,0) AS measure_value
FROM 
(SELECT 
	a.order_id ,
	a.pizza_id ,
	a.quantity ,
	b.price ,
	a.quantity * b.price AS sales
FROM order_details a
LEFT JOIN pizzas b
ON a.pizza_id = b.pizza_id ) t
UNION ALL 
SELECT
	'Total Quantity',
	sum(quantity)
FROM order_details od 
UNION ALL
SELECT 
 'Average Price',
 round(CAST(avg(price) AS NUMERIC),2) 
FROM pizzas p 
UNION ALL	
SELECT 
	'Total Orders',
	count(order_details_id)
FROM order_details od 
UNION ALL 
SELECT 
	'Total Product',
	count("name")
FROM pizza_types pt
UNION ALL 
SELECT 
	'Total Customer',
	count(DISTINCT order_id)
FROM order_details od ;
