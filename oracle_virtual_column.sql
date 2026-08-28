-- cleanup -- 
drop table orders;
-- Create table -- 
CREATE TABLE orders (
    order_id    NUMBER,
    quantity    NUMBER,
    unit_price  NUMBER,
    total_value NUMBER
    GENERATED ALWAYS AS (quantity * unit_price) VIRTUAL
);

--- Insert sample values -- 
INSERT INTO orders (order_id, quantity, unit_price) 
VALUES (1, 10, 500);
INSERT INTO orders (order_id, quantity, unit_price) 
VALUES (2, 100, 50);
INSERT INTO orders (order_id, quantity, unit_price) 
VALUES (3, 5, 2000);

commit;

-- Check metadata 
select TABLE_NAME, COLUMN_NAME, column_id, DATA_DEFAULT, VIRTUAL_COLUMN 
from dba_tab_cols
where table_name = 'ORDERS';

-- Query the calculated value
SELECT order_id, quantity, unit_price, total_value
FROM orders;
