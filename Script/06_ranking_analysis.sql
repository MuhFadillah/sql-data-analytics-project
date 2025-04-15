/*
-------------------------------------------------------------------------------
Ranking Analysis
-------------------------------------------------------------------------------
Purpose:
    - To rank items (e.g., category, subcategory(name)) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), ROW_NUMBER(), LIMIT,ROUND (), CAST()
    - Clauses: GROUP BY, ORDER BY
-------------------------------------------------------------------------------
*/

--- Which 5 products Generating the Highest Revenue? ---
--- Simple Ranking ---

SELECT
	c."name" AS menu ,
	round(CAST (sum(m.quantity * m.price) AS NUMERIC),0) AS total_revenue
FROM 
(SELECT
	b.pizza_type_id ,
	a.quantity ,
	b.price 
FROM order_details a
LEFT JOIN pizzas b
ON a.pizza_id = b.pizza_id ) m
LEFT JOIN pizza_types c
ON m.pizza_type_id = c.pizza_type_id 
GROUP BY c."name"
ORDER BY total_revenue DESC 
LIMIT 5

--- What are the 5 worst-performing products in terms of sales? ---

SELECT
	c."name" AS menu ,
	round(CAST (sum(m.quantity * m.price) AS NUMERIC),0) AS total_revenue
FROM 
(SELECT
	b.pizza_type_id ,
	a.quantity ,
	b.price 
FROM order_details a
LEFT JOIN pizzas b
ON a.pizza_id = b.pizza_id ) m
LEFT JOIN pizza_types c
ON m.pizza_type_id = c.pizza_type_id 
GROUP BY c."name"
ORDER BY total_revenue ASC 
LIMIT 5

--- Complex but Flexibly Ranking Using Window Functions ---

SELECT *
FROM (
	SELECT 
		n."name" AS menu,
		round(CAST (sum(n.quantity * n.price) AS NUMERIC),0)  AS total_sales,
		RANK () OVER (ORDER BY sum(n.quantity * n.price) DESC) AS rank_menu
	FROM 
	(SELECT 
		m.pizza_type_id,
		c."name" ,
		m.quantity ,
		m.price
	FROM 
	(SELECT
		b.pizza_type_id ,
		a.quantity ,
		b.price 
	FROM order_details a
	LEFT JOIN pizzas b
	ON a.pizza_id = b.pizza_id ) m
	LEFT JOIN pizza_types c
	ON m.pizza_type_id = c.pizza_type_id ) n
	GROUP BY n."name"
) AS ranked_menu
WHERE rank_menu <= 5

--- Complex but Flexibly Worst Ranking Using Window Functions ---
SELECT *
FROM (
	SELECT 
		n."name" AS menu,
		round(CAST (sum(n.quantity * n.price) AS NUMERIC),0)  AS total_sales,
		RANK () OVER (ORDER BY sum(n.quantity * n.price) DESC) AS rank_menu
	FROM 
	(SELECT 
		m.pizza_type_id,
		c."name" ,
		m.quantity ,
		m.price
	FROM 
	(SELECT
		b.pizza_type_id ,
		a.quantity ,
		b.price 
	FROM order_details a
	LEFT JOIN pizzas b
	ON a.pizza_id = b.pizza_id ) m
	LEFT JOIN pizza_types c
	ON m.pizza_type_id = c.pizza_type_id ) n
	GROUP BY n."name"
	ORDER BY total_sales ASC 
) AS ranked_menu
WHERE rank_menu >= 28

SELECT *
FROM orders o 

SELECT *
FROM order_details od 

SELECT *
FROM pizza_types pt 

SELECT *
FROM pizzas p 