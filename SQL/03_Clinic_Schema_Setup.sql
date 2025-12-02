CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);
INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ Clinic', 'Lorem', 'Ipsum', 'Dolor'),
('cnc-0100002', 'ABC Clinic', 'Metro', 'Delta', 'USA'),
('cnc-0100003', 'HealthPlus', 'Gamma', 'Sigma', 'USA'),
('cnc-0100004', 'CareWell', 'Lambda', 'Theta', 'USA'),
('cnc-0100005', 'MediCenter', 'Omega', 'Alpha', 'USA');


INSERT INTO customer (uid, name, mobile) VALUES
('bk-09f3e-95hj', 'Jon Doe', '9700000001'),
('bk-09f3e-95hk', 'Jane Smith', '9700000002'),
('bk-09f3e-95hl', 'Alice Johnson', '9700000003'),
('bk-09f3e-95hm', 'Bob Brown', '9700000004'),
('bk-09f3e-95hn', 'Charlie Davis', '9700000005');


INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'online'),
('ord-00100-00101', 'bk-09f3e-95hk', 'cnc-0100002', 15000, '2021-09-24 10:15:00', 'offline'),
('ord-00100-00102', 'bk-09f3e-95hl', 'cnc-0100003', 18000, '2021-10-05 14:20:12', 'online'),
('ord-00100-00103', 'bk-09f3e-95hm', 'cnc-0100004', 22000, '2021-10-12 09:45:30', 'referral'),
('ord-00100-00104', 'bk-09f3e-95hn', 'cnc-0100005', 12000, '2021-11-01 11:30:45', 'online'),
('ord-00100-00105', 'bk-09f3e-95hj', 'cnc-0100001', 30000, '2021-11-15 15:20:10', 'offline'),
('ord-00100-00106', 'bk-09f3e-95hk', 'cnc-0100002', 5000,  '2021-12-03 16:10:00', 'online'),
('ord-00100-00107', 'bk-09f3e-95hl', 'cnc-0100003', 7500,  '2021-12-10 12:00:00', 'referral'),
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-0100-00100', 'cnc-0100001', 'First-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100002', 'Medicines', 1200, '2021-09-24 08:15:00'),
('exp-0100-00102', 'cnc-0100003', 'Lab equipment', 5000, '2021-10-05 10:00:00'),
('exp-0100-00103', 'cnc-0100004', 'Staff salaries', 8000, '2021-10-12 09:00:00'),
('exp-0100-00104', 'cnc-0100005', 'Utilities', 700, '2021-11-01 11:00:00'),
('exp-0100-00105', 'cnc-0100001', 'Cleaning', 300, '2021-11-15 14:00:00'),
('exp-0100-00106', 'cnc-0100002', 'Maintenance', 400, '2021-12-03 15:30:00'),
('exp-0100-00107', 'cnc-0100003', 'Insurance', 1200, '2021-12-10 12:15:00');