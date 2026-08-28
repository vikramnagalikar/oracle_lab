-- Sample data
WITH sales AS (
    SELECT DATE '2026-01-01' sale_date, 100 amount FROM dual UNION ALL
    SELECT DATE '2026-01-02', 250 FROM dual UNION ALL
    SELECT DATE '2026-01-03', 150 FROM dual UNION ALL
    SELECT DATE '2026-01-04', 300 FROM dual UNION ALL
    SELECT DATE '2026-01-05', 200 FROM dual
)
SELECT
    sale_date,
    amount,
    SUM(amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM sales
ORDER BY sale_date;
