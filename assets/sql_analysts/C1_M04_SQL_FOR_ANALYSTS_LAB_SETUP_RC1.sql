-- COURSE 1 - M04 SQL FOR ANALYSTS - CANONICAL LAB SETUP RC1
-- PURPOSE: controlled multi-table analytics lab. Run the WHOLE file once before SA1.
-- PREREQUISITE: M03 SQL Foundations competency pass.
-- SAFETY: DROP/CREATE/INSERT appear here only to build/reset this disposable course database.
-- Normal M04 practice is SELECT/CTE/window analysis; do not UPDATE/DELETE source fixtures.
-- CORE GRAINS:
--   customers     = one row/customer
--   products      = one row/product
--   orders        = one row/order
--   order_items   = one row/order line
--   return_events = one row/return event (an order can have multiple events)
-- CARDINALITY TRAP: freight_amount belongs to order grain and will repeat after joining to order_items.
-- EXPECTED COUNTS after setup: customers=8, products=6, orders=30, order_items=60, return_events=8.

DROP DATABASE IF EXISTS da_sql_analysts;
CREATE DATABASE da_sql_analysts;
USE da_sql_analysts;

CREATE TABLE customers(customer_id VARCHAR(10) PRIMARY KEY, customer_name VARCHAR(80), city VARCHAR(40), segment VARCHAR(30));
CREATE TABLE products(product_id VARCHAR(10) PRIMARY KEY, product_name VARCHAR(80), category VARCHAR(30), standard_cost DECIMAL(12,2));
CREATE TABLE orders(order_id VARCHAR(10) PRIMARY KEY, order_date DATE NOT NULL, customer_id VARCHAR(10) NOT NULL, status VARCHAR(20), ship_date DATE NULL, freight_amount DECIMAL(10,2), FOREIGN KEY(customer_id) REFERENCES customers(customer_id));
CREATE TABLE order_items(order_id VARCHAR(10), line_no INT, product_id VARCHAR(10), quantity INT, unit_price DECIMAL(12,2), discount_pct DECIMAL(5,2), line_sales DECIMAL(12,2), PRIMARY KEY(order_id,line_no), FOREIGN KEY(order_id) REFERENCES orders(order_id), FOREIGN KEY(product_id) REFERENCES products(product_id));
CREATE TABLE return_events(return_id VARCHAR(10) PRIMARY KEY, order_id VARCHAR(10), event_date DATE, reason VARCHAR(50), units_returned INT, FOREIGN KEY(order_id) REFERENCES orders(order_id));

INSERT INTO customers VALUES
('C001',' Asha Retail ','Delhi','SMB'),
('C002','Metro Home','Mumbai ','Mid'),
('C003','Nova Mart','DELHI','SMB'),
('C004','Quick Basket','Pune','Mid'),
('C005','Blue Stores','Mumbai','Enterprise'),
('C006','Urban Shop',' Pune ','SMB'),
('C007','Green Cart','Delhi','Mid'),
('C008','Prime Retail','Mumbai','Enterprise');

INSERT INTO products VALUES
('P01','Office Chair','Furniture',3500.00),
('P02','Desk','Furniture',6200.00),
('P03','Keyboard','Technology',1200.00),
('P04','Monitor','Technology',7800.00),
('P05','Paper Pack','Office',250.00),
('P06','Pen Set','Office',180.00);

INSERT INTO orders VALUES
('O001','2026-01-03','C001','Complete','2026-01-04',300.00),
('O002','2026-01-09','C004','Complete','2026-01-11',400.00),
('O003','2026-01-15','C007','Complete','2026-01-18',500.00),
('O004','2026-01-21','C002','Pending',NULL,600.00),
('O005','2026-01-27','C005','Complete','2026-02-01',300.00),
('O006','2026-02-02','C008','Complete','2026-02-03',400.00),
('O007','2026-02-08','C003','Complete','2026-02-10',500.00),
('O008','2026-02-14','C006','Pending',NULL,600.00),
('O009','2026-02-20','C001','Complete','2026-02-24',300.00),
('O010','2026-02-26','C004','Complete','2026-03-03',400.00),
('O011','2026-03-04','C007','Complete','2026-03-05',500.00),
('O012','2026-03-10','C002','Pending',NULL,600.00),
('O013','2026-03-16','C005','Complete','2026-03-19',300.00),
('O014','2026-03-22','C008','Complete','2026-03-26',400.00),
('O015','2026-03-28','C003','Complete','2026-04-02',500.00),
('O016','2026-04-03','C006','Pending',NULL,600.00),
('O017','2026-04-09','C001','Complete','2026-04-11',300.00),
('O018','2026-04-15','C004','Complete','2026-04-18',400.00),
('O019','2026-04-21','C007','Complete','2026-04-25',500.00),
('O020','2026-04-27','C002','Pending',NULL,600.00),
('O021','2026-05-03','C005','Complete','2026-05-04',300.00),
('O022','2026-05-09','C008','Complete','2026-05-11',400.00),
('O023','2026-05-15','C003','Complete','2026-05-18',500.00),
('O024','2026-05-21','C006','Pending',NULL,600.00),
('O025','2026-05-27','C001','Complete','2026-06-01',300.00),
('O026','2026-06-02','C004','Complete','2026-06-03',400.00),
('O027','2026-06-08','C007','Complete','2026-06-10',500.00),
('O028','2026-06-14','C002','Pending',NULL,600.00),
('O029','2026-06-20','C005','Complete','2026-06-24',300.00),
('O030','2026-06-26','C008','Complete','2026-07-01',400.00);

INSERT INTO order_items VALUES
('O001',1,'P01',1,6200.00,0.00,6200.00),
('O002',1,'P02',2,10500.00,5.00,19950.00),
('O002',2,'P04',3,13500.00,10.00,36450.00),
('O003',1,'P03',3,2200.00,10.00,5940.00),
('O003',2,'P05',4,450.00,0.00,1800.00),
('O003',3,'P01',1,6200.00,5.00,5890.00),
('O004',1,'P04',4,13500.00,0.00,54000.00),
('O005',1,'P05',1,450.00,5.00,427.50),
('O005',2,'P01',2,6200.00,10.00,11160.00),
('O006',1,'P06',2,350.00,10.00,630.00),
('O006',2,'P02',3,10500.00,0.00,31500.00),
('O006',3,'P04',4,13500.00,5.00,51300.00),
('O007',1,'P01',3,6200.00,0.00,18600.00),
('O008',1,'P02',4,10500.00,5.00,39900.00),
('O008',2,'P04',1,13500.00,10.00,12150.00),
('O009',1,'P03',1,2200.00,10.00,1980.00),
('O009',2,'P05',2,450.00,0.00,900.00),
('O009',3,'P01',3,6200.00,5.00,17670.00),
('O010',1,'P04',2,13500.00,0.00,27000.00),
('O011',1,'P05',3,450.00,5.00,1282.50),
('O011',2,'P01',4,6200.00,10.00,22320.00),
('O012',1,'P06',4,350.00,10.00,1260.00),
('O012',2,'P02',1,10500.00,0.00,10500.00),
('O012',3,'P04',2,13500.00,5.00,25650.00),
('O013',1,'P01',1,6200.00,0.00,6200.00),
('O014',1,'P02',2,10500.00,5.00,19950.00),
('O014',2,'P04',3,13500.00,10.00,36450.00),
('O015',1,'P03',3,2200.00,10.00,5940.00),
('O015',2,'P05',4,450.00,0.00,1800.00),
('O015',3,'P01',1,6200.00,5.00,5890.00),
('O016',1,'P04',4,13500.00,0.00,54000.00),
('O017',1,'P05',1,450.00,5.00,427.50),
('O017',2,'P01',2,6200.00,10.00,11160.00),
('O018',1,'P06',2,350.00,10.00,630.00),
('O018',2,'P02',3,10500.00,0.00,31500.00),
('O018',3,'P04',4,13500.00,5.00,51300.00),
('O019',1,'P01',3,6200.00,0.00,18600.00),
('O020',1,'P02',4,10500.00,5.00,39900.00),
('O020',2,'P04',1,13500.00,10.00,12150.00),
('O021',1,'P03',1,2200.00,10.00,1980.00),
('O021',2,'P05',2,450.00,0.00,900.00),
('O021',3,'P01',3,6200.00,5.00,17670.00),
('O022',1,'P04',2,13500.00,0.00,27000.00),
('O023',1,'P05',3,450.00,5.00,1282.50),
('O023',2,'P01',4,6200.00,10.00,22320.00),
('O024',1,'P06',4,350.00,10.00,1260.00),
('O024',2,'P02',1,10500.00,0.00,10500.00),
('O024',3,'P04',2,13500.00,5.00,25650.00),
('O025',1,'P01',1,6200.00,0.00,6200.00),
('O026',1,'P02',2,10500.00,5.00,19950.00),
('O026',2,'P04',3,13500.00,10.00,36450.00),
('O027',1,'P03',3,2200.00,10.00,5940.00),
('O027',2,'P05',4,450.00,0.00,1800.00),
('O027',3,'P01',1,6200.00,5.00,5890.00),
('O028',1,'P04',4,13500.00,0.00,54000.00),
('O029',1,'P05',1,450.00,5.00,427.50),
('O029',2,'P01',2,6200.00,10.00,11160.00),
('O030',1,'P06',2,350.00,10.00,630.00),
('O030',2,'P02',3,10500.00,0.00,31500.00),
('O030',3,'P04',4,13500.00,5.00,51300.00);

INSERT INTO return_events VALUES
('R001','O001','2026-01-06','Damaged',1),
('RX001','O001','2026-01-09','Second review',0),
('R007','O007','2026-02-12','Damaged',1),
('RX011','O011','2026-03-10','Second review',0),
('R013','O013','2026-03-21','Damaged',1),
('R019','O019','2026-04-27','Damaged',1),
('RX021','O021','2026-05-09','Second review',0),
('R025','O025','2026-06-03','Damaged',1);

SELECT (SELECT COUNT(*) FROM customers) customers, (SELECT COUNT(*) FROM orders) orders, (SELECT COUNT(*) FROM order_items) order_items, (SELECT COUNT(*) FROM return_events) return_events;


-- END CHECKS
SELECT COUNT(*) AS customer_rows FROM customers;       -- expected 8
SELECT COUNT(*) AS product_rows FROM products;         -- expected 6
SELECT COUNT(*) AS order_rows FROM orders;             -- expected 30
SELECT COUNT(*) AS order_item_rows FROM order_items;   -- expected 60
SELECT COUNT(*) AS return_event_rows FROM return_events; -- expected 8
SELECT SUM(line_sales) AS raw_line_sales_total FROM order_items;
SELECT SUM(freight_amount) AS raw_freight_total FROM orders;
