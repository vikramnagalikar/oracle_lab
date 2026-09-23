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

-- Index 
CREATE INDEX idx_emp_status
ON employees(status);
/

-- Check Data - 
select status, count(1)
from employees
group by status;

-- Gather stats - This wont build histogram 
BEGIN
DBMS_STATS.GATHER_TABLE_STATS 
(USER,
'EMPLOYEES',
 METHOD_OPT => 'FOR COLUMNS STATUS SIZE 1');
END;
/

EXPLAIN PLAN FOR
SELECT *
FROM employees
WHERE status = 'SUSPENDED';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- GAther Stats with Histogram 
BEGIN
DBMS_STATS.GATHER_TABLE_STATS(
    USER,
    'EMPLOYEES',
    METHOD_OPT => 'FOR COLUMNS STATUS SIZE 254'
);
END;
/

-- Histogram Metadata 
SELECT column_name,
       histogram,
       num_buckets
FROM dba_tab_columns
WHERE table_name = 'EMPLOYEES'
AND column_name = 'STATUS';
