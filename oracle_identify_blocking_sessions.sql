-- Cleanup -- 
DROP TABLE lock_demo PURGE;

-- Sample Table 
CREATE TABLE lock_demo (
    id   NUMBER PRIMARY KEY,
    name VARCHAR2(50)
);

INSERT INTO lock_demo VALUES (1, 'Vikram');
INSERT INTO lock_demo VALUES (2, 'Oracle');

COMMIT;

-- Update 
UPDATE lock_demo
SET name = 'LOCKED'
WHERE id = 1;

-- DON'T COMMIT

-- Check Sesison ID 
SELECT
    SYS_CONTEXT('USERENV', 'SID') AS sid,
    SYS_CONTEXT('USERENV', 'SESSIONID') AS session_id
FROM dual;

-- Open a New Session - 

-- Check Session ID - 
SELECT
    SYS_CONTEXT('USERENV', 'SID') AS sid,
    SYS_CONTEXT('USERENV', 'SESSIONID') AS session_id
FROM dual;

-- Update the same row 
UPDATE lock_demo
SET name = 'WAITING'
WHERE id = 1;

-- Identify Blocking Sessions 
SELECT
    w.sid              AS waiting_sid,
    w.username         AS waiting_user,
    w.event            AS wait_event,
    b.sid              AS blocking_sid,
    b.username         AS blocking_user,
    o.object_name      AS locked_object,
    o.object_type      AS object_type
FROM v$session w
JOIN v$session b
    ON b.sid = w.blocking_session
LEFT JOIN v$locked_object lo
    ON lo.session_id = b.sid
LEFT JOIN dba_objects o
    ON o.object_id = lo.object_id
WHERE w.blocking_session IS NOT NULL;
