/*
-------------------------------------------------------------------------------
Date Range Exploration 
-------------------------------------------------------------------------------
Purpose:
    - To determine the temporal boundaries of key data pointegers.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), EXTRACT(MONTH FROM), AGE ()
-------------------------------------------------------------------------------
*/

--- Determine the first and last order date and the total duration in months ---

SELECT 
    MIN("date") AS first_order_date,
    MAX("date") AS last_order_date,
    EXTRACT (MONTH FROM age ('2015-12-31', '2015-01-01')) AS order_range_by_month,
    age('2015-12-31', '2015-01-01') AS order_range_by_detail_date
FROM orders o ;
