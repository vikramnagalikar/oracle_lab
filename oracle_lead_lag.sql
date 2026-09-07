-- Cleanup --
DROP TABLE monthly_sales;

-- Create table 
CREATE TABLE monthly_sales (
    month_date DATE,
    sales      NUMBER
);

-- Data Setup 
INSERT INTO monthly_sales VALUES (DATE '2026-01-01', 10000);
INSERT INTO monthly_sales VALUES (DATE '2026-02-01', 12000);
INSERT INTO monthly_sales VALUES (DATE '2026-03-01', 11500);
INSERT INTO monthly_sales VALUES (DATE '2026-04-01', 15000);
INSERT INTO monthly_sales VALUES (DATE '2026-05-01', 18000);

COMMIT;

-- Data - 
SELECT * FROM monthly_sales;

-- Better Way 
SELECT TO_CHAR(month_date, 'Mon') AS month_name,
       sales,
       LAG(sales) OVER (ORDER BY month_date) AS previous_sales,
       sales - LAG(sales) OVER (ORDER BY month_date) AS difference
FROM monthly_sales
ORDER BY month_date;
