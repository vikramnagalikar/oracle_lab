DROP TABLE employees PURGE;
-- Create table 
CREATE TABLE employees (
    emp_id NUMBER,
    status VARCHAR2(10),
    salary NUMBER
);

-- Highly skewed data
INSERT INTO employees
SELECT LEVEL,
       CASE
           WHEN LEVEL <= 99000 THEN 'ACTIVE'
           WHEN LEVEL <= 99900 THEN 'INACTIVE'
           ELSE 'SUSPENDED'
       END,
       30000 + LEVEL
FROM dual
CONNECT BY LEVEL <= 100000;

COMMIT;
--
-- Index 
CREATE INDEX idx_salary on employees(salary);

-- 3. Check the execution plan
EXPLAIN PLAN FOR
SELECT *
FROM employees
WHERE salary = 80000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 4. Make the index INVISIBLE
ALTER INDEX idx_salary INVISIBLE;

-- 5. Run the same query again
EXPLAIN PLAN FOR
SELECT *
FROM employees
WHERE salary = 80000;

-- check plan
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Metadata to check index status 
SELECT index_name, visibility
FROM dba_indexes
WHERE index_name = 'IDX_SALARY';

-- To enable index for a session 
ALTER SESSION SET OPTIMIZER_USE_INVISIBLE_INDEXES = TRUE;

-- To Disable index for a session  
ALTER SESSION SET OPTIMIZER_USE_INVISIBLE_INDEXES = FALSE;




