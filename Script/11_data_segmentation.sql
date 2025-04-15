/*
-------------------------------------------------------------------------------
Data Segmentation Analysis
-------------------------------------------------------------------------------
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
-------------------------------------------------------------------------------
*/

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than 2,000.
	- Regular: Customers with at least 12 months of history but spending 2,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customer_spending AS (
	SELECT 
	a.order_id ,
	sum( a.quantity * b.price)  AS total_spending,
	min(c."date") AS first_order,
	max(c."date") AS last_order,
	EXTRACT (MONTH FROM age (max(c."date"), min(c."date"))) AS lifespan
	FROM order_details a
	LEFT JOIN pizzas b
	ON a.pizza_id = b.pizza_id 
	LEFT JOIN orders c
	ON a.order_id = c.order_id 
	GROUP BY a.order_id
)
SELECT 
    customer_segment,
    COUNT(order_id) AS total_customers
FROM (
    SELECT 
        order_id,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 2000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 2000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;