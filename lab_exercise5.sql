
-- Lab exercise 5.1
DELIMITER //

CREATE TRIGGER update_inventory
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Get the current stock quantity of the ordered product
    SELECT stock_quantity INTO current_stock
    FROM inventory
    WHERE product_id = NEW.product_id;

    -- Check if the stock is sufficient
    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for product';
    ELSE
        -- Decrease the inventory count by the ordered quantity
        UPDATE inventory
        SET stock_quantity = stock_quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END //

DELIMITER ;

-- Lab exercise 5.2

DELIMITER $$

CREATE PROCEDURE UpdateCustomerStatus(IN cust_id INT)
BEGIN
    DECLARE total_order_value DECIMAL(10, 2);

    SELECT SUM(total_revenue) INTO total_order_value
    FROM sales
    WHERE customer_id = cust_id;

    
    IF total_order_value IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer does not exist or has no orders.';
    ELSE
        -- Update customer status based on total order value
        IF total_order_value > 10000 THEN
            UPDATE customer
            SET customer_status = 'VIP'
            WHERE customer_id = cust_id;
        ELSE
            UPDATE customer
            SET customer_status = 'Regular'
            WHERE customer_id = cust_id;
        END IF;
    END IF;
END $$

DELIMITER ;
