-- Cleanup -- 
DROP TABLE employees;
drop synonym emp;
-- Create a demo table
CREATE TABLE employees (
    emp_id    NUMBER PRIMARY KEY,
    emp_name  VARCHAR2(100),
    salary    NUMBER
);

-- Create an index
CREATE INDEX idx_emp_salary
ON employees(salary);

-- Grant access
GRANT SELECT ON employees TO ANONYMOUS;

-- Create a synonym
CREATE SYNONYM emp FOR employees;

SET SERVEROUTPUT ON;

DECLARE
  PROCEDURE show_ddl(p_type VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('--- ' || p_type || ' ---');
    DBMS_OUTPUT.PUT_LINE(
    DBMS_METADATA.GET_DDL(p_type, 'EMPLOYEES', 'SYSTEM'));
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('No ' || p_type || ' found.');
  END;
BEGIN
  show_ddl('TABLE');
  --
  -- For Indexes --
  FOR r IN (SELECT index_name FROM user_indexes
            WHERE table_name = 'EMPLOYEES') LOOP
    DBMS_OUTPUT.PUT_LINE('--- INDEX ---');
    DBMS_OUTPUT.PUT_LINE
    (DBMS_METADATA.GET_DDL('INDEX', r.index_name, 'SYSTEM'));
  END LOOP;

  -- Grnats -- 
  DBMS_OUTPUT.PUT_LINE('--- GRANTS ---');
  dbms_output.put_line(DBMS_METADATA.GET_DEPENDENT_DDL(
    'OBJECT_GRANT',
    'EMPLOYEES',
    'SYSTEM'
    ));
  -- Synonyms -- 
  DBMS_OUTPUT.PUT_LINE('--- SYNONYMS ---');
  FOR r IN (SELECT owner, synonym_name
            FROM dba_synonyms
            WHERE table_owner = USER
              AND table_name = 'EMPLOYEES') LOOP
    DBMS_OUTPUT.PUT_LINE(
      DBMS_METADATA.GET_DDL('SYNONYM', r.synonym_name, r.owner));
  END LOOP;
END;
/
