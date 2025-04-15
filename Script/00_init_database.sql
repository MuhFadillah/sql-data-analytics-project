/*
-------------------------------------------------------------
Create Database and Schemas
-------------------------------------------------------------
Script Purpose:
    This script creates a new database named 'ProjectsAnalytics'. Additionally, this script creates a schema called Pizza_sales
*/

--- Create the 'ProjectsAnalytics' database ---

CREATE DATABASE ProjectsAnalytics

--- Create Schema ---

CREATE SCHEMA Pizza_sales

CREATE TABLE order_details(
	order_details_id integereger ,
	order_id integereger ,
	pizza_id varchar(75),
	quantity integereger
);

CREATE TABLE orders(
	order_id integereger,
	"date"  date,
	"time" time
);

DROP TABLE pizza_types ;

CREATE TABLE pizza_types(
	pizza_type_id varchar(75),
	name varchar(75),
	category varchar(75),
	ingredients varchar(250)
);

CREATE TABLE pizzas(
	pizza_id varchar(75),
	pizza_type_id varchar(75),
	size varchar(75),
	price float4
);

BEGIN;
LOCK TABLE order_details IN EXCLUSIVE MODE;
COPY order_details
FROM 'C:/temp/pizza/Awalan/order_details.csv'
WITH CSV HEADER;
COMMIT;

BEGIN;
LOCK TABLE orders IN EXCLUSIVE MODE;
COPY orders
FROM 'C:/temp/pizza/Awalan/orders.csv'
WITH CSV HEADER;
COMMIT;

BEGIN;
LOCK TABLE pizza_types IN EXCLUSIVE MODE;
COPY pizza_types
FROM 'C:/temp/pizza/Awalan/pizza_types.csv'
WITH CSV HEADER;
COMMIT;

BEGIN;
LOCK TABLE pizzas IN EXCLUSIVE MODE;
COPY pizzas
FROM 'C:/temp/pizza/Awalan/pizzas.csv'
WITH CSV HEADER;
COMMIT;

ROLLBACK;  --- USE ROLLBACK WHEN INPUT 'BEGIN ... COMMIT' IS failed AND find OUT the mistake, this query ONLY FOR rollback EXECUTE SQL query ---