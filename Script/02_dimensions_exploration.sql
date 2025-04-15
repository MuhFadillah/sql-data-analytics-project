/*
-------------------------------------------------------------------------------
Dimensions Exploration
-------------------------------------------------------------------------------
Purpose:
    - To explore the structure of dimension tables pizza sales.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
-------------------------------------------------------------------------------
*/

--- Retrieve a list of unique menu size order ---

SELECT DISTINCT 
    pizza_id AS menu_size_order
FROM order_details od 
ORDER BY menu_size_order;

--- Retrieve a list of unique name, category, ingredients ---

SELECT DISTINCT 
    "name" , 
    category , 
    ingredients 
FROM pizza_types pt 
ORDER BY "name", category, ingredients ;