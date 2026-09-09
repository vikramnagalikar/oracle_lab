-- cleanup -- 
DROP TABLE customer_sales;

-- Setup 
CREATE TABLE customer_sales (
    customer_id  NUMBER,
    customer_name VARCHAR2(30),
    total_spend  NUMBER
);

-- Data Setup 
INSERT INTO customer_sales VALUES (1, 'Amit',    95000);
INSERT INTO customer_sales VALUES (2, 'Priya',   82000);
INSERT INTO customer_sales VALUES (3, 'Rahul',   75000);
INSERT INTO customer_sales VALUES (4, 'Sneha',   68000);
INSERT INTO customer_sales VALUES (5, 'Vikram',  61000);
INSERT INTO customer_sales VALUES (6, 'Neha',    55000);
INSERT INTO customer_sales VALUES (7, 'Arjun',   48000);
INSERT INTO customer_sales VALUES (8, 'Pooja',   42000);
INSERT INTO customer_sales VALUES (9, 'Karan',   35000);
INSERT INTO customer_sales VALUES (10, 'Riya',   28000);
INSERT INTO customer_sales VALUES (11, 'Nikhil', 22000);
INSERT INTO customer_sales VALUES (12, 'Anita',  15000);

COMMIT;
--
-- Select --
SELECT * FROM customer_sales;

-- 
SELECT
    customer_name,
    total_spend,
    CASE NTILE(4) OVER (ORDER BY total_spend DESC)
        WHEN 1 THEN 'VIP'
        WHEN 2 THEN 'High Value'
        WHEN 3 THEN 'Medium Value'
        WHEN 4 THEN 'Low Value'
    END AS customer_segment
FROM customer_sales
ORDER BY total_spend DESC;
--
-- Update --
update customer_sales
set total_spend = 76000
where customer_name = 'Sneha';
