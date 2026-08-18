-- Hard way — manually split the list
WITH data AS (
    SELECT 'Oracle,SQL,PLSQL,Python' str FROM dual
)
SELECT REGEXP_SUBSTR(str, '[^,]+', 1, LEVEL) AS item
FROM data
CONNECT BY REGEXP_SUBSTR(str, '[^,]+', 1, LEVEL) IS NOT NULL;

-- Easy way — SYS.ODCIVARCHAR2LIST
SELECT column_value AS item
FROM TABLE(
    SYS.ODCIVARCHAR2LIST('Oracle', 'SQL', 'PLSQL', 'Python')
);
