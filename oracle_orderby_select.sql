-- cleanup -- 
DROP TABLE employees;

-- Create table
CREATE TABLE employees (
    emp_id   NUMBER,
    emp_name VARCHAR2(50),
    salary   NUMBER
);

-- Sample data
INSERT INTO employees VALUES (101, 'John',   5000);
INSERT INTO employees VALUES (102, 'David',  8000);
INSERT INTO employees VALUES (103, 'Mike',   6000);
INSERT INTO employees VALUES (104, 'Robert', 9000);

COMMIT;

-- salary is NOT in SELECT
SELECT emp_id, emp_name
FROM employees
ORDER BY salary DESC;

-- With one exception -- 
SELECT DISTINCT emp_name
FROM employees
ORDER BY salary;

-- BEFORE DISTINCT
/*

John   → 5000
John   → 9000
David  → 7000

       ↓ DISTINCT

John   → ???     ← Which salary?
David  → 7000

*/
