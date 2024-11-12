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
