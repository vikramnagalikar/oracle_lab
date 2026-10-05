
-- Cleanup -- 
DROP TABLE sales_demo purge;

-- Create a reasonably large table
CREATE TABLE sales_demo
AS
SELECT LEVEL AS sale_id,
       MOD(LEVEL, 100) AS customer_id,
       MOD(LEVEL, 20) AS product_id,
       DBMS_RANDOM.VALUE(100, 10000) AS amount
FROM dual
CONNECT BY LEVEL <= 100000;

-- Check the table's parallel setting
SELECT table_name, degree
FROM dba_tables
WHERE table_name = 'SALES_DEMO';

-- Plan 
EXPLAIN PLAN FOR
SELECT COUNT(*)
FROM sales_demo
WHERE amount > 5000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Change the table-level degree
ALTER TABLE sales_demo PARALLEL 4;

-- To revert - 
ALTER TABLE sales_demo NOPARALLEL;
