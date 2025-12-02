

SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;



SELECT 
    c.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM customer c
JOIN clinic_sales cs ON c.uid = cs.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;



WITH monthly_revenue AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
monthly_expense AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT 
    r.month,
    COALESCE(r.revenue,0) AS revenue,
    COALESCE(e.expense,0) AS expense,
    COALESCE(r.revenue,0) - COALESCE(e.expense,0) AS profit,
    CASE 
        WHEN COALESCE(r.revenue,0) - COALESCE(e.expense,0) >= 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM monthly_revenue r
LEFT JOIN monthly_expense e ON r.month = e.month
ORDER BY r.month;


WITH clinic_monthly AS (
    SELECT 
        cs.cid,
        cl.city,
        MONTH(cs.datetime) AS month,
        SUM(cs.amount) AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cs.cid, cl.city, MONTH(cs.datetime)
),
clinic_expenses AS (
    SELECT 
        cid,
        MONTH(datetime) AS month,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, MONTH(datetime)
),
clinic_profit AS (
    SELECT 
        c.cid,
        c.city,
        c.month,
        c.revenue - COALESCE(e.expense,0) AS profit
    FROM clinic_monthly c
    LEFT JOIN clinic_expenses e ON c.cid = e.cid AND c.month = e.month
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY city, month ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT city, month, cid, profit
FROM ranked
WHERE rnk = 1
ORDER BY city, month;


WITH clinic_monthly AS (
    SELECT 
        cs.cid,
        cl.state,
        MONTH(cs.datetime) AS month,
        SUM(cs.amount) AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cs.cid, cl.state, MONTH(cs.datetime)
),
clinic_expenses AS (
    SELECT 
        cid,
        MONTH(datetime) AS month,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, MONTH(datetime)
),
clinic_profit AS (
    SELECT 
        c.cid,
        c.state,
        c.month,
        c.revenue - COALESCE(e.expense,0) AS profit
    FROM clinic_monthly c
    LEFT JOIN clinic_expenses e ON c.cid = e.cid AND c.month = e.month
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY state, month ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT state, month, cid, profit
FROM ranked
WHERE rnk = 2
ORDER BY state, month;
