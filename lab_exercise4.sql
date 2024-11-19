-- lab 4 exercise 4.1
EXPLAIN 
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_spending  -- Calculate the total revenue for each customer
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id  -- Join with order_items to get product details
JOIN products p ON oi.product_id = p.product_id  -- Join with products to get product price
WHERE o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY c.customer_id, c.customer_name;  -- Include customer_name in GROUP BY

-- Lab 4 exercise 4.2
 -- Index on `customer_id` in the `orders` table (for JOIN operations)
CREATE INDEX idx_customer_id ON orders(customer_id);

-- Index on `order_date` in the `orders` table (for filtering by date range)
CREATE INDEX idx_order_date ON orders(order_date);
-- Composite index on `customer_id` and `order_date` in the `orders` table
CREATE INDEX idx_customer_order_date ON orders(customer_id, order_date);

-- Index on `product_name` in the `products` table (for fast searches and sorting)
CREATE INDEX idx_product_name ON products(product_name);
-- Index on `category` in the `products` table (for filtering products by category)
CREATE INDEX idx_category ON products(category);
-- Composite index on `category` and `price` in the `products` table
CREATE INDEX idx_category_price ON products(category, price);
-- Index on `customer_id` for optimizing GROUP BY queries
CREATE INDEX idx_customer_id_group ON orders(customer_id);

-- Index on `order_date` for optimizing ORDER BY operations
CREATE INDEX idx_order_date_group ON orders(order_date);

-- Lab 4 exercise 4.3
-- refer to lab1.jpg


-- lab4 4.4
-- Implementation partitioning by RANGE
SELECT CONVERT(total_revenue, SIGNED) AS total_sales FROM shop_ease.sales;
ALTER TABLE shop_ease.sales ADD COLUMN total_sales INT;
ALTER TABLE sales
PARTITION BY RANGE (total_sales) (
    PARTITION p_low VALUES LESS THAN (1000),   -- Small revenue
    PARTITION p_medium VALUES LESS THAN (5000), -- Medium revenue
    PARTITION p_high VALUES LESS THAN (10000),  -- Large revenue
    PARTITION p_vhigh VALUES LESS THAN (100000)  -- Very large revenue
);
-- Implementation of partitioning by HASH

ALTER TABLE sales
PARTITION BY HASH (customer_id)
PARTITIONS 4;

-- Lab exercise 4.5
SET profiling = 1;
SHOW PROFILES;
SHOW PROFILE FOR QUERY 8;

-- bottlenecks
