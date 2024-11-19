-- Lab 3 exercise 3.1
SELECT 
    p.product_name, 
    SUM(s.quantity * s.price) AS total_sales,
    ROW_NUMBER() OVER (ORDER BY SUM(s.quantity * s.price) DESC) AS product_rank
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.order_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY p.product_name
ORDER BY product_rank;

SELECT 
    p.product_name, 
    SUM(s.quantity * s.price) AS total_sales,
    RANK() OVER (ORDER BY SUM(s.quantity * s.price) DESC) AS product_rank
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.order_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY p.product_name
ORDER BY product_rank;

SELECT 
    p.product_name, 
    SUM(s.quantity * s.price) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(s.quantity * s.price) DESC) AS product_rank
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.order_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY p.product_name
ORDER BY product_rank;


-- Lab 3 exercise 3.2
SELECT 
    p.category,          
    p.product_name,
    s.order_date,
    SUM(s.quantity * s.price) OVER (PARTITION BY p.category ORDER BY s.order_date) AS running_total
FROM sales s
JOIN products p ON s.product_id = p.product_id
ORDER BY p.category, s.order_date;

-- Lab 3 exercise 3.3
SELECT 
    o.customer_id,
    c.customer_name,
    o.order_id,
    SUM(oi.quantity * p.price) AS total_order_value,  
    AVG(SUM(oi.quantity * p.price)) OVER (PARTITION BY o.customer_id) AS avg_order_value
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id  
JOIN products p ON oi.product_id = p.product_id  
GROUP BY o.customer_id, o.order_id, c.customer_name, o.order_date  
ORDER BY o.customer_id, o.order_date; 

--3.4
SELECT 
    year,
    month,
    SUM(total_revenue) AS monthly_sales,   
    LAG(SUM(total_revenue), 1) OVER (ORDER BY year, month) AS previous_month_sales,  
    LEAD(SUM(total_revenue), 1) OVER (ORDER BY year, month) AS next_month_sales    
FROM sales
GROUP BY year, month  
ORDER BY year, month;  

-- 3.5
SELECT 
    year,
    month,
    SUM(total_revenue) AS monthly_sales,   
    COALESCE(LAG(SUM(total_revenue), 1) OVER (ORDER BY year, month), 0) AS previous_month_sales,  -- Replace NULL with 0
    COALESCE(LEAD(SUM(total_revenue), 1) OVER (ORDER BY year, month), 0) AS next_month_sales      -- Replace NULL with 0
FROM sales
GROUP BY year, month
ORDER BY year, month;
