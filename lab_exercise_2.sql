
SELECT * 
FROM CUSTOMER
JOIN ORDERS ON CUSTOMER.customer_id = ORDERS.customer_id
JOIN ORDER_ITEMS ON ORDERS.order_id = ORDER_ITEMS.order_id
JOIN PRODUCTS ON ORDER_ITEMS.product_id = PRODUCTS.product_id;


SELECT p.product_name, 
       SUM(s.quantity * s.price) AS total_sales
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH) 
GROUP BY p.product_name
ORDER BY total_sales DESC  
LIMIT 5;  

SELECT order_id,
       total_revenue,
       CASE
           WHEN total_revenue >= 1000 THEN 'High'   
           WHEN total_revenue >= 500  THEN 'Medium' 
           ELSE 'Low'                           
       END AS revenue_category
FROM sales;

EXPLAIN ANALYZE SELECT * 
FROM CUSTOMER
JOIN ORDERS ON CUSTOMER.customer_id = ORDERS.customer_id
JOIN ORDER_ITEMS ON ORDERS.order_id = ORDER_ITEMS.order_id
JOIN PRODUCTS ON ORDER_ITEMS.product_id = PRODUCTS.product_id;

CREATE INDEX idx_customer_id ON CUSTOMER(customer_id);
CREATE INDEX idx_orders_customer_id ON ORDERS(customer_id);
CREATE INDEX idx_orders_order_id ON ORDERS(order_id);
CREATE INDEX idx_order_items_order_id ON ORDER_ITEMS(order_id);
CREATE INDEX idx_order_items_product_id ON ORDER_ITEMS(product_id);
CREATE INDEX idx_products_product_id ON PRODUCTS(product_id);

EXPLAIN ANALYZE SELECT p.product_name, 
               SUM(s.quantity * s.price) AS total_sales
        FROM sales s
        JOIN products p ON s.product_id = p.product_id
        WHERE s.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)
        GROUP BY p.product_name
        ORDER BY total_sales DESC  
        LIMIT 5;

CREATE INDEX idx_sales_product_id ON sales(product_id);
CREATE INDEX idx_sales_order_date ON sales(order_date);
CREATE INDEX idx_products_product_name ON products(product_name);
CREATE INDEX idx_sales_order_date_product_id ON sales(order_date, product_id);


