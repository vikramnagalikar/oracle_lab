-- Cleanup
DROP TABLE employees_demo PURGE;

-- Create test data
CREATE TABLE employees_demo (
    emp_id  NUMBER,
    salary  NUMBER
);

-- Existing bad data
INSERT INTO employees_demo VALUES (1, 50000);
INSERT INTO employees_demo VALUES (2, -1000);
INSERT INTO employees_demo VALUES (3, 70000);

COMMIT;

select * from employees_demo;

-- Try to add a normal constraint
ALTER TABLE employees_demo
ADD CONSTRAINT chk_salary
CHECK (salary > 0);
--
-- Try NOVALIDATE 
ALTER TABLE employees_demo
ADD CONSTRAINT chk_salary
CHECK (salary > 0)
ENABLE NOVALIDATE;

-- Try to insert new row volating cnstraint -- 
INSERT INTO employees_demo
VALUES (4, -5000);
