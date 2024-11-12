-- Lab 5 
DELIMITER $$

CREATE TRIGGER update_inventory
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Get the current stock for the ordered product
    SELECT stock_quantity
    INTO current_stock
    FROM Inventories
    WHERE product_id = NEW.product_id;

    -- Check if there is sufficient stock
    IF current_stock >= NEW.quantity THEN
        -- Decrease the stock by the ordered quantity
        UPDATE Inventories
        SET stock_quantity = stock_quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    ELSE
        -- Raise an exception or log a message if there is insufficient stock
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Insufficient stock for product ID: ', NEW.product_id);
    END IF;
END $$

DELIMITER ;


