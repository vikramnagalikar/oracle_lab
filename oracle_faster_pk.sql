-- Cleanup
DROP TABLE employees PURGE;

-- Create test table
CREATE TABLE employees (
    emp_id   NUMBER,
    emp_name VARCHAR2(50)
) tablespace sysaux nologging;

-- Generate 10 million rows
INSERT /*+ APPEND */ INTO employees
SELECT ROWNUM,
       'Employee ' || ROWNUM
FROM
    (SELECT 1 FROM dual CONNECT BY LEVEL <= 10000) a,
    (SELECT 1 FROM dual CONNECT BY LEVEL <= 1000) b;

COMMIT;

-- Option 1 ---  
SET TIMING ON;
ALTER TABLE employees
ADD CONSTRAINT emp_pk PRIMARY KEY (emp_id);
SET TIMING OFF;

-- Cleanup -- 
ALTER TABLE employees DROP CONSTRAINT emp_pk;


-- Option 2 ---  

SET TIMING ON;
-- 1st Unique Index 
CREATE UNIQUE INDEX emp_pk_idx
ON employees(emp_id);

-- 2nd Add constraint 
ALTER TABLE employees
ADD CONSTRAINT emp_pk PRIMARY KEY (emp_id)
USING INDEX emp_pk_idx;

SET TIMING OFF;
--
