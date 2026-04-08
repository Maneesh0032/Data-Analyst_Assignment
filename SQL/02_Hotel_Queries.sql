-- =====================================================
-- HOTEL MANAGEMENT SYSTEM - QUERY SOLUTIONS
-- Covers Questions 1 to 5
-- =====================================================


-- =====================================================
-- Q1: For every user, get the last booked room
-- =====================================================
-- Logic:
-- Find the latest booking_date per user and return the corresponding room

SELECT u.user_id, b.room_no
FROM users u
JOIN bookings b 
    ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date)
    FROM bookings b2
    WHERE b2.user_id = u.user_id
);

-- Note:
-- If two bookings have the same timestamp, multiple rows may appear



-- =====================================================
-- Q2: Get booking_id and total billing amount for bookings in Nov 2021
-- =====================================================
-- Logic:
-- Join bookings → booking_commercials → items
-- Calculate total bill using (quantity * rate)

SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM bookings b
JOIN booking_commercials bc 
    ON b.booking_id = bc.booking_id
JOIN items i 
    ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11
  AND YEAR(bc.bill_date) = 2021
GROUP BY b.booking_id;



-- =====================================================
-- Q3: Get bill_id and bill amount > 1000 in Oct 2021
-- =====================================================
-- Logic:
-- Aggregate bill amount per bill_id and filter using HAVING

SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;



-- =====================================================
-- Q4: Most and Least ordered item per month in 2021
-- =====================================================
-- Logic:
-- Step 1: Aggregate item quantities per month
-- Step 2: Rank items within each month
-- Step 3: Pick highest and lowest ranked items

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



-- =====================================================
-- Q5: Customers with 2nd highest bill per month (2021)
-- =====================================================
-- Logic:
-- Step 1: Calculate bill totals per bill_id
-- Step 2: Rank bills within each month
-- Step 3: Pick rank = 2

WITH bill_totals AS (
    SELECT 
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount,
        MONTH(bc.bill_date) AS month
    FROM booking_commercials bc
    JOIN bookings b 
        ON bc.booking_id = b.booking_id
    JOIN items i 
        ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY bc.bill_id, b.user_id, MONTH(bc.bill_date)
),

ranked AS (
    SELECT 
        user_id,
        bill_id,
        bill_amount,
        month,
        DENSE_RANK() OVER (
            PARTITION BY month 
            ORDER BY bill_amount DESC
        ) AS rnk
    FROM bill_totals
)

SELECT 
    user_id, 
    bill_id, 
    bill_amount, 
    month
FROM ranked
WHERE rnk = 2
ORDER BY month;
