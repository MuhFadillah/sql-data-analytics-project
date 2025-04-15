/*
-------------------------------------------------------------------------------
Part-to-Whole Analysis
-------------------------------------------------------------------------------
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
-------------------------------------------------------------------------------
*/

--- Which categories contribute the most to overall sales? ---

WITH category_sales AS (
	SELECT 
	c.category,
	round( CAST(sum(a.quantity * b.price) AS NUMERIC),0) AS total_sales 
	FROM order_details a
	LEFT JOIN pizzas b
	ON a.pizza_id = b.pizza_id 
	LEFT  JOIN pizza_types c 
	ON b.pizza_type_id  = c.pizza_type_id 
	GROUP BY c.category 
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND(CAST(total_sales AS NUMERIC) / SUM(total_sales) OVER () * 100, 2)  AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;