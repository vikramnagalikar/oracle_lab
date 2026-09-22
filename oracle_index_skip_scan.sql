DROP TABLE employees PURGE;

CREATE TABLE employees (
    emp_id   NUMBER,
    dept_id  NUMBER,
    salary   NUMBER
);

INSERT INTO employees
SELECT LEVEL,
       MOD(LEVEL, 10) + 1,   -- Only 10 distinct departments
       30000 + LEVEL         -- Highly selective salary
FROM dual
CONNECT BY LEVEL <= 100000;

COMMIT;
--
-- Select - 
SELECT * FROM employees;

-- Index 
CREATE INDEX idx_emp_dept_salary
ON employees(dept_id, salary);

-- Gather Stats 
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'EMPLOYEES');

-- Plans 
EXPLAIN PLAN FOR
SELECT *
FROM employees
WHERE salary = 90000;

-- Plans 
EXPLAIN PLAN FOR
SELECT /*+ FULL(e) */
       *
FROM employees e
WHERE salary = 80000;
--
-- Look into Plan 
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
