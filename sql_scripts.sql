CREATE DATABASE shop_ease;

SET SQL_SAFE_UPDATES = 0;

USE shop_ease;

CREATE TABLE sales(
    customer_id INT NOT NULL,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    join_date DATE,
    order_id INT NOT NULL PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    product_name VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10, 2),
    year INT,
    month INT,
    day INT,
    total_revenue DECIMAL(10, 2)
);

SELECT * FROM shop_ease.sales;

CREATE TABLE CUSTOMER(
	customer_id int,
    customer_name varchar(255),
    email varchar(255),
    join_date date);
    
CREATE TABLE INVENTORY(
	product_name varchar(255),
    stock_quantity int,
    stock_date date,
    supplier varchar(50),
    warehouse_location varchar(50)
    );
    
CREATE TABLE ORDER_ITEMS(
order_detail_id int,
  order_id int,
  quantity int,
  product_id int);
  
CREATE TABLE ORDERS(
	 order_id int,
     customer_id int,
     order_date date,
     product_id int,
     quantity int
);

CREATE TABLE PRODUCTS(
	product_id int, 
    product_name varchar(255),
    category varchar(50),
    price int);
    
CREATE TABLE SUPPLIERS(
	id INT,
    supplier_name VARCHAR(255),
    supplier_address VARCHAR(255),
    email VARCHAR(255),
    contact_number VARCHAR(15),
    fax VARCHAR(15),
    account_number VARCHAR(15),
    order_history INT,
    contract VARCHAR(3),
    supplier_country VARCHAR(100),
    supplier_city VARCHAR(100),
    country_code VARCHAR(5)
	);


SELECT * FROM shop_ease.customer;
SELECT * FROM shop_ease.inventory;
SELECT * FROM shop_ease.orders;
SELECT * FROM shop_ease.products;
SELECT * FROM shop_ease.suppliers;
SELECT * FROM shop_ease.order_items;

INSERT INTO order_items (order_detail_id, product_id, quantity)
VALUES (1, 456, 10);

ALTER TABLE inventory ADD COLUMN product_id INT;

ALTER TABLE customer
ADD COLUMN customer_status VARCHAR(50);

CALL UpdateCustomerStatus(123);