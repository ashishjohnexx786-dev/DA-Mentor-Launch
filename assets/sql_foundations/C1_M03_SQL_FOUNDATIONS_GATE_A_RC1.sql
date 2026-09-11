-- COURSE 1 - M03 SQL FOUNDATIONS - PROTECTED GATE A RC1
-- DOMAIN: marketplace seller orders
-- ROLE: normal Gate
-- STATE MACHINE: A clean pass ends M03. Gate B is only after failed A + Review A + targeted repair + explicit assignment.
-- MODULE BOUNDARY: single-table SELECT/WHERE/ORDER BY/LIMIT/aggregates/GROUP BY/HAVING/CASE only.

DROP DATABASE IF EXISTS da_sql_foundations_gate_a;
CREATE DATABASE da_sql_foundations_gate_a;
USE da_sql_foundations_gate_a;

CREATE TABLE seller_orders (
  order_id VARCHAR(10) PRIMARY KEY,
  order_date DATE NOT NULL,
  seller_id VARCHAR(10) NOT NULL,
  region VARCHAR(20) NOT NULL,
  category VARCHAR(30) NOT NULL,
  order_value DECIMAL(12,2) NOT NULL,
  status VARCHAR(20) NOT NULL,
  channel VARCHAR(20) NOT NULL,
  rating INT NULL,
  fulfillment_days INT NOT NULL
);

INSERT INTO seller_orders (order_id,order_date,seller_id,region,category,order_value,status,channel,rating,fulfillment_days) VALUES
('MO001','2026-04-01','S07','East','Home',16600,'Completed','App',NULL,3),
('MO002','2026-04-03','S02','South','Electronics',26100,'Completed','Web',3,7),
('MO003','2026-04-05','S06','West','Electronics',10000,'Cancelled','Phone',3,5),
('MO004','2026-04-07','S03','West','Electronics',27100,'Completed','App',5,4),
('MO005','2026-04-09','S02','West','Electronics',2300,'Cancelled','Phone',4,1),
('MO006','2026-04-11','S09','West','Office',32100,'Completed','Web',2,6),
('MO007','2026-04-13','S04','East','Home',5800,'Completed','App',NULL,8),
('MO008','2026-04-15','S06','East','Electronics',900,'Completed','Phone',2,6),
('MO009','2026-04-17','S05','East','Office',16100,'Pending','Phone',3,7),
('MO010','2026-04-19','S09','North','Home',32800,'Completed','App',2,6),
('MO011','2026-04-21','S08','North','Office',9000,'Completed','Web',2,7),
('MO012','2026-04-23','S06','North','Home',35600,'Completed','Phone',3,1),
('MO013','2026-04-25','S02','South','Office',32300,'Completed','Web',NULL,6),
('MO014','2026-04-27','S08','West','Office',29100,'Cancelled','Web',5,6),
('MO015','2026-04-29','S09','South','Office',30800,'Completed','Phone',2,1),
('MO016','2026-05-01','S08','East','Office',24500,'Pending','Web',4,9),
('MO017','2026-05-03','S03','South','Office',1700,'Pending','App',2,4),
('MO018','2026-05-05','S04','West','Electronics',2800,'Pending','Web',5,1),
('MO019','2026-05-07','S04','South','Electronics',38400,'Completed','App',NULL,5),
('MO020','2026-05-09','S09','North','Electronics',39900,'Pending','Web',5,2),
('MO021','2026-05-11','S09','North','Home',37800,'Completed','App',4,5),
('MO022','2026-05-13','S01','North','Office',33800,'Pending','Web',2,4),
('MO023','2026-05-15','S07','South','Electronics',34700,'Pending','Web',3,3),
('MO024','2026-05-17','S09','South','Electronics',39200,'Pending','Web',2,2),
('MO025','2026-05-19','S08','East','Home',38500,'Completed','Phone',NULL,9),
('MO026','2026-05-21','S03','North','Electronics',9800,'Completed','Phone',4,7),
('MO027','2026-05-23','S06','West','Office',6800,'Pending','Phone',2,9),
('MO028','2026-05-25','S05','West','Office',35000,'Completed','Phone',3,2),
('MO029','2026-05-27','S05','North','Electronics',16400,'Pending','Phone',4,9),
('MO030','2026-05-29','S04','North','Home',23400,'Completed','App',2,4),
('MO031','2026-05-31','S04','West','Office',38500,'Completed','App',NULL,1),
('MO032','2026-06-02','S08','South','Electronics',14700,'Completed','Phone',5,8),
('MO033','2026-06-04','S09','East','Home',36500,'Cancelled','Web',4,2),
('MO034','2026-06-06','S02','West','Home',38700,'Pending','App',4,8),
('MO035','2026-06-08','S05','West','Office',28800,'Completed','Phone',2,1),
('MO036','2026-06-10','S06','East','Home',30100,'Completed','Web',3,4),
('MO037','2026-06-12','S03','West','Home',10400,'Completed','App',NULL,4),
('MO038','2026-06-14','S04','South','Office',36400,'Completed','Phone',2,6),
('MO039','2026-06-16','S01','North','Home',34200,'Completed','App',4,1),
('MO040','2026-06-18','S02','East','Electronics',4700,'Completed','Phone',3,6),
('MO041','2026-06-20','S03','South','Office',19000,'Completed','Phone',2,7),
('MO042','2026-06-22','S07','South','Office',22600,'Pending','Web',5,1);

SELECT COUNT(*) AS rows_loaded FROM seller_orders; -- expected 42

-- GATE A TASKS - SINGLE TABLE ONLY
-- Protected first attempt: learner book, protected reviews, tutorial solving and AI-generated solutions are closed.
-- Source table: seller_orders. State its source grain before Task 1.
-- 1. Return order_id, order_date, region, status and order_value for the first 8 rows. State result grain.
-- 2. Return DISTINCT channel values and DISTINCT status values in two separate queries. State each DISTINCT result grain.
-- 3. Return rows where status='Completed' AND region equals one valid group of your choice. Write the rule in plain English first.
-- 4. Return rows where rating IS NULL. Explain why = NULL is wrong.
-- 5. Return the five largest order_value rows using ORDER BY order_value DESC + LIMIT 5. Rerun without LIMIT to prove the fifth-row boundary.
-- 6. For status='Completed', return COUNT(*) AS row_count, SUM(order_value) AS measure_total and AVG(fulfillment_days) AS avg_duration. Explain COUNT(*) vs COUNT(fulfillment_days).
-- 7. For status='Completed', return one row per region with row_count and SUM(order_value). State grouped result grain.
-- 8. Return channel groups having at least 10 rows. Include row_count. Use GROUP BY + HAVING.
-- 9. Create size_band with CASE: WHEN order_value >= 30000 THEN 'Large' WHEN order_value >= 15000 THEN 'Medium' ELSE 'Small'. Return order_id, order_value and size_band.
-- 10. Summarize size_band with COUNT(*) per band and reconcile the band counts to total table rows.
-- 11. In SQL comments explain: source grain; Task-7 result grain; WHERE vs HAVING; why LIMIT without ORDER BY is not top-N; one validation you used.
-- CRITICAL FAIL: wrong result grain, unsafe NULL logic, non-deterministic top-N, wrong aggregate/group logic, CASE boundary failure, or no validation can block a pass.
-- MODULE BOUNDARY: JOIN, CTE, subquery and window-function syntax is outside M03 and cannot substitute for the requested foundation reasoning.
-- Save as SQL_Foundations_Gate_A_<yourname>.sql and evidence as G-SQLF-A before opening Gate A Review.
