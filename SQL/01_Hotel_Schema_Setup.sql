-- ==============================
-- USERS TABLE
-- Stores basic customer details
-- ==============================
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,   -- unique identifier for each user
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- ==============================
-- BOOKINGS TABLE
-- Stores room booking info
-- ==============================
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,   -- unique booking id
    booking_date DATETIME,                -- when booking was made
    room_no VARCHAR(50),                 -- room assigned
    user_id VARCHAR(50),                 -- who made the booking

    -- foreign key ensures booking belongs to valid user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ==============================
-- ITEMS TABLE
-- Stores food/service items
-- ==============================
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,   -- unique item id
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)            -- price per unit
);

-- ==============================
-- BOOKING COMMERCIALS TABLE
-- Stores billing details per booking
-- ==============================
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,        -- unique row id
    booking_id VARCHAR(50),            -- booking reference
    bill_id VARCHAR(50),               -- bill reference
    bill_date DATETIME,                -- when bill was generated
    item_id VARCHAR(50),               -- item billed
    item_quantity DECIMAL(10,2),       -- quantity ordered

    -- maintaining relationships
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);


-- ==============================
-- Insert sample users
-- ==============================
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('21wrcxuy-67erfn1', 'John Doe1', '93XXXXXXXX', 'johnw.doe@example.com', 'XX, Street B, ABC City');
-- Note: user_id must be unique (you handled it correctly 👍)

-- ==============================
-- Insert bookings
-- ==============================
INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o', '2021-09-23 07:36:48', 'rm-bhf9-aerjm', '21wrcxuy-67erfn1');

-- ==============================
-- Insert items
-- ==============================
INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg', 89),
('itm-w978-23u4', 'Tawa Paratha', 18);
-- Note: duplicate item_name is allowed, but item_id keeps them unique

-- ==============================
-- Insert booking commercial details
-- ==============================
INSERT INTO booking_commercials 
(id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4', 0.5);

-- Note:
-- Same bill_id can appear multiple times → each row represents one item in the bill
-- Total bill = sum(item_quantity * item_rate)
