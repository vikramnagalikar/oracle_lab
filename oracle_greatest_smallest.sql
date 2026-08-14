CREATE TABLE employee_scores (
    emp_id         NUMBER,
    emp_name       VARCHAR2(30),
    sql_score      NUMBER,
    plsql_score    NUMBER,
    java_score     NUMBER
);
INSERT INTO employee_scores VALUES (101, 'Alice',   85, 92, 78);
INSERT INTO employee_scores VALUES (102, 'Bob',     95, 89, 97);
INSERT INTO employee_scores VALUES (103, 'Charlie', 70, 68, 72);

COMMIT;

SELECT *
FROM employee_scores;

-- Greatest - 
SELECT emp_name,
GREATEST(sql_score, plsql_score, java_score) AS highest_score
FROM employee_scores;

-- Least - 
SELECT emp_name,
LEAST(sql_score, plsql_score, java_score) AS lowest_score
FROM employee_scores;

-- Value of one with Null  
INSERT INTO employee_scores
VALUES (105, 'Sam',   88, 88, null);
