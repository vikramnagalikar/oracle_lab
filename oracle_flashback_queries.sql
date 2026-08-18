-- Setup
DROP TABLE employees PURGE;

CREATE TABLE employees (
    emp_id   NUMBER,
    emp_name VARCHAR2(50),
    salary   NUMBER
);

INSERT INTO employees VALUES (1, 'Vikram', 50000);
INSERT INTO employees VALUES (2, 'John',   60000);

COMMIT;

-- See the data -
select * from employees;

-- Take a snapshot point
SELECT CURRENT_SCN FROM v$database;


UPDATE employees
SET salary = 100000
WHERE emp_id = 1;

COMMIT;

-- Current data
SELECT * FROM employees;

-- Data based on SCN (System Change Number) -- 
SELECT *
FROM employees
AS OF SCN 73822311; -- this is the SCN which you would get from query - Take a snapshot point

-- Past data AS OF last 1 minute 
SELECT *
FROM employees
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' MINUTE);
