/*
-------------------------------------------------------------------------------
Magnitude Analysis
-------------------------------------------------------------------------------
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
-------------------------------------------------------------------------------
*/

--- Find total products by category ---
SELECT
    category,
    COUNT("name") AS total_products
FROM pizza_types pt 
GROUP BY category
ORDER BY total_products DESC;

--- What is the average price in each category? ---

SELECT
 category ,
 avg(price) AS Avg_price
FROM 
(SELECT
    pt.category,
    p.price
FROM pizza_types pt 
LEFT JOIN pizzas p 
ON pt.pizza_type_id = p.pizza_type_id ) e
GROUP BY category
ORDER BY Avg_price DESC 

--- What is the total revenue generated for each category? ---

SELECT 
	c.category ,
	round(CAST (sum( m.quantity * m.price ) AS NUMERIC),0) AS Total_Revenue
FROM 
(SELECT 
	b.pizza_type_id,
	a.quantity ,
	b.price
FROM order_details a
LEFT JOIN pizzas b
ON a.pizza_id = b.pizza_id ) m
LEFT JOIN pizza_types c
ON m.pizza_type_id = c.pizza_type_id 
GROUP BY c.category 
ORDER BY Total_Revenue DESC 
