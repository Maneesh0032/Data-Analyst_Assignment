

SELECT u.user_id, b.room_no
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(booking_date)
    FROM bookings b2
    WHERE b2.user_id = u.user_id
);



SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11 AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id;



SELECT 
    bill_id,
    SUM(item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bill_date) = 10 AND YEAR(bill_date) = 2021
GROUP BY bill_id
HAVING bill_amount > 1000;



WITH monthly_items AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, bc.item_id
),
ranked AS (
    SELECT 
        month,
        item_id,
        total_qty,
        RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS rnk_desc,
        RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS rnk_asc
    FROM monthly_items
)
SELECT 
    month,
    item_id,
    total_qty,
    CASE
        WHEN rnk_desc = 1 THEN 'Most Ordered'
        WHEN rnk_asc = 1 THEN 'Least Ordered'
    END AS category
FROM ranked
WHERE rnk_desc = 1 OR rnk_asc = 1
ORDER BY month, category;



WITH bill_totals AS (
    SELECT 
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount,
        MONTH(bc.bill_date) AS month
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY bc.bill_id, b.user_id, MONTH(bc.bill_date)
),
ranked AS (
    SELECT 
        user_id,
        bill_id,
        bill_amount,
        month,
        DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_amount DESC) AS rnk
    FROM bill_totals
)
SELECT user_id, bill_id, bill_amount, month
FROM ranked
WHERE rnk = 2
ORDER BY month;
