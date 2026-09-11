-- COURSE 1 - M03 SQL FOUNDATIONS - CANONICAL LAB SETUP RC1
-- PURPOSE: controlled course database setup/reset. Run the ENTIRE file once before SF0 practice.
-- BEGINNER SAFETY: this file intentionally contains DROP/CREATE/INSERT because it builds the disposable course database.
-- Normal lesson practice should not use UPDATE/DELETE/DROP/ALTER.
-- EXPECTED AFTER SETUP: customers = 12 rows; orders = 48 rows.
-- If the file stops part-way, rerun the entire setup from the top rather than guessing which object exists.

DROP DATABASE IF EXISTS da_sql_foundations;
CREATE DATABASE da_sql_foundations;
USE da_sql_foundations;

CREATE TABLE customers (
  customer_id VARCHAR(10) PRIMARY KEY,
  customer_name VARCHAR(80) NOT NULL,
  home_region VARCHAR(20) NOT NULL,
  customer_segment VARCHAR(20) NOT NULL
);

CREATE TABLE orders (
  order_id VARCHAR(10) PRIMARY KEY,
  order_date DATE NOT NULL,
  customer_id VARCHAR(10) NOT NULL,
  region VARCHAR(20) NOT NULL,
  category VARCHAR(30) NOT NULL,
  sales_amount DECIMAL(12,2) NOT NULL,
  discount_pct DECIMAL(5,2) NOT NULL,
  delivery_days INT NOT NULL,
  status VARCHAR(20) NOT NULL,
  channel VARCHAR(20) NOT NULL,
  satisfaction_score INT NULL,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id,customer_name,home_region,customer_segment) VALUES
  ('C001','Asha Retail','East','Small'),
  ('C002','Metro Home','West','Medium'),
  ('C003','Nova Mart','North','Small'),
  ('C004','Quick Basket','South','Medium'),
  ('C005','Blue Stores','East','Large'),
  ('C006','Urban Shop','West','Small'),
  ('C007','Green Cart','North','Medium'),
  ('C008','Prime Retail','South','Large'),
  ('C009','Alpha Bazaar','East','Medium'),
  ('C010','City Needs','West','Large'),
  ('C011','Daily Box','North','Small'),
  ('C012','Evermart','South','Medium');

INSERT INTO orders (order_id,order_date,customer_id,region,category,sales_amount,discount_pct,delivery_days,status,channel,satisfaction_score) VALUES
  ('O0001','2026-01-03','C001','East','Office',8500.00,0.00,1,'Completed','Online',NULL),
  ('O0002','2026-01-07','C006','South','Technology',11600.00,5.00,3,'Completed','Store',3),
  ('O0003','2026-01-11','C011','North','Furniture',14700.00,10.00,5,'Completed','Phone',4),
  ('O0004','2026-01-15','C004','West','Office',17800.00,0.00,7,'Pending','Online',NULL),
  ('O0005','2026-01-19','C009','East','Technology',20900.00,15.00,1,'Cancelled','Store',NULL),
  ('O0006','2026-01-23','C002','South','Furniture',24000.00,5.00,3,'Completed','Phone',3),
  ('O0007','2026-01-27','C007','North','Office',27100.00,0.00,5,'Completed','Online',4),
  ('O0008','2026-01-31','C012','West','Technology',30200.00,5.00,7,'Completed','Store',NULL),
  ('O0009','2026-02-04','C005','East','Furniture',33300.00,10.00,1,'Pending','Phone',NULL),
  ('O0010','2026-02-08','C010','South','Office',9900.00,0.00,3,'Cancelled','Online',NULL),
  ('O0011','2026-02-12','C003','North','Technology',13000.00,15.00,5,'Completed','Store',4),
  ('O0012','2026-02-16','C008','West','Furniture',16100.00,5.00,7,'Completed','Phone',5),
  ('O0013','2026-02-20','C001','East','Office',19200.00,0.00,1,'Completed','Online',2),
  ('O0014','2026-02-24','C006','South','Technology',22300.00,5.00,3,'Pending','Store',NULL),
  ('O0015','2026-02-28','C011','North','Furniture',25400.00,10.00,5,'Cancelled','Phone',NULL),
  ('O0016','2026-03-04','C004','West','Office',28500.00,0.00,7,'Completed','Online',5),
  ('O0017','2026-03-08','C009','East','Technology',31600.00,15.00,1,'Completed','Store',2),
  ('O0018','2026-03-12','C002','South','Furniture',34700.00,5.00,3,'Completed','Phone',3),
  ('O0019','2026-03-16','C007','North','Office',11300.00,0.00,5,'Pending','Online',NULL),
  ('O0020','2026-03-20','C012','West','Technology',14400.00,5.00,7,'Cancelled','Store',NULL),
  ('O0021','2026-03-24','C005','East','Furniture',17500.00,10.00,1,'Completed','Phone',2),
  ('O0022','2026-03-28','C010','South','Office',20600.00,0.00,3,'Completed','Online',NULL),
  ('O0023','2026-04-01','C003','North','Technology',23700.00,15.00,5,'Completed','Store',4),
  ('O0024','2026-04-05','C008','West','Furniture',26800.00,5.00,7,'Pending','Phone',NULL),
  ('O0025','2026-04-09','C001','East','Office',29900.00,0.00,1,'Cancelled','Online',NULL),
  ('O0026','2026-04-13','C006','South','Technology',33000.00,5.00,3,'Completed','Store',3),
  ('O0027','2026-04-17','C011','North','Furniture',36100.00,10.00,5,'Completed','Phone',4),
  ('O0028','2026-04-21','C004','West','Office',12700.00,0.00,7,'Completed','Online',5),
  ('O0029','2026-04-25','C009','East','Technology',15800.00,15.00,1,'Pending','Store',NULL),
  ('O0030','2026-04-29','C002','South','Furniture',18900.00,5.00,3,'Cancelled','Phone',NULL),
  ('O0031','2026-05-03','C007','North','Office',22000.00,0.00,5,'Completed','Online',4),
  ('O0032','2026-05-07','C012','West','Technology',25100.00,5.00,7,'Completed','Store',5),
  ('O0033','2026-05-11','C005','East','Furniture',28200.00,10.00,1,'Completed','Phone',2),
  ('O0034','2026-05-15','C010','South','Office',31300.00,0.00,3,'Pending','Online',NULL),
  ('O0035','2026-05-19','C003','North','Technology',34400.00,15.00,5,'Cancelled','Store',NULL),
  ('O0036','2026-05-23','C008','West','Furniture',37500.00,5.00,7,'Completed','Phone',NULL),
  ('O0037','2026-05-27','C001','East','Office',14100.00,0.00,1,'Completed','Online',2),
  ('O0038','2026-05-31','C006','South','Technology',17200.00,5.00,3,'Completed','Store',3),
  ('O0039','2026-06-04','C011','North','Furniture',20300.00,10.00,5,'Pending','Phone',NULL),
  ('O0040','2026-06-08','C004','West','Office',23400.00,0.00,7,'Cancelled','Online',NULL),
  ('O0041','2026-06-12','C009','East','Technology',26500.00,15.00,1,'Completed','Store',2),
  ('O0042','2026-06-16','C002','South','Furniture',29600.00,5.00,3,'Completed','Phone',3),
  ('O0043','2026-06-20','C007','North','Office',32700.00,0.00,5,'Completed','Online',NULL),
  ('O0044','2026-06-24','C012','West','Technology',35800.00,5.00,7,'Pending','Store',NULL),
  ('O0045','2026-06-28','C005','East','Furniture',38900.00,10.00,1,'Cancelled','Phone',NULL),
  ('O0046','2026-07-02','C010','South','Office',15500.00,0.00,3,'Completed','Online',3),
  ('O0047','2026-07-06','C003','North','Technology',18600.00,15.00,5,'Completed','Store',4),
  ('O0048','2026-07-10','C008','West','Furniture',21700.00,5.00,7,'Completed','Phone',5);

-- Verification: these are not answers to practice; they only confirm setup.
SELECT COUNT(*) AS customer_rows FROM customers; -- expected 12
SELECT COUNT(*) AS order_rows FROM orders;       -- expected 48


-- END CHECKS
SELECT COUNT(*) AS customer_rows FROM customers; -- expected 12
SELECT COUNT(*) AS order_rows FROM orders; -- expected 48
