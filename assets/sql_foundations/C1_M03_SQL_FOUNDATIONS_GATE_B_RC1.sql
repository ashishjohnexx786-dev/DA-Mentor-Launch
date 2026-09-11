-- COURSE 1 - M03 SQL FOUNDATIONS - PROTECTED GATE B RC1
-- DOMAIN: inventory replenishment events
-- ROLE: fresh remediation retest
-- STATE MACHINE: Gate B is attempted only after failed A + repair + explicit assignment. A clean B pass ends M03. Gate C is only after failed B + Review B + targeted repair + explicit assignment.
-- MODULE BOUNDARY: single-table SELECT/WHERE/ORDER BY/LIMIT/aggregates/GROUP BY/HAVING/CASE only.

DROP DATABASE IF EXISTS da_sql_foundations_gate_b;
CREATE DATABASE da_sql_foundations_gate_b;
USE da_sql_foundations_gate_b;

CREATE TABLE replenishment_events (
  event_id VARCHAR(10) PRIMARY KEY,
  request_date DATE NOT NULL,
  warehouse VARCHAR(20) NOT NULL,
  sku_family VARCHAR(20) NOT NULL,
  requested_qty INT NOT NULL,
  fulfilled_qty INT NOT NULL,
  priority VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  lead_days INT NULL,
  supplier_tier VARCHAR(5) NOT NULL,
  request_channel VARCHAR(20) NOT NULL
);

INSERT INTO replenishment_events (event_id,request_date,warehouse,sku_family,requested_qty,fulfilled_qty,priority,status,lead_days,supplier_tier,request_channel) VALUES
('RE001','2026-05-01','WH-East','Standard',200,200,'Low','Fulfilled',NULL,'C','Urgent'),
('RE002','2026-05-02','WH-East','Fast',250,250,'High','Open',1,'C','Auto'),
('RE003','2026-05-03','WH-North','Fast',30,0,'High','Open',11,'C','Planner'),
('RE004','2026-05-04','WH-South','Standard',70,70,'High','Fulfilled',7,'C','Urgent'),
('RE005','2026-05-05','WH-West','Fast',100,100,'High','Partial',2,'A','Urgent'),
('RE006','2026-05-06','WH-South','Fast',230,100,'High','Fulfilled',3,'C','Urgent'),
('RE007','2026-05-07','WH-South','Fast',60,60,'Medium','Fulfilled',12,'A','Planner'),
('RE008','2026-05-08','WH-East','Bulk',160,160,'Low','Fulfilled',NULL,'B','Urgent'),
('RE009','2026-05-09','WH-South','Bulk',290,290,'High','Open',11,'C','Planner'),
('RE010','2026-05-10','WH-South','Bulk',220,220,'Medium','Fulfilled',4,'C','Auto'),
('RE011','2026-05-11','WH-North','Fast',300,300,'Medium','Partial',4,'C','Auto'),
('RE012','2026-05-12','WH-West','Standard',120,120,'Medium','Partial',11,'C','Planner'),
('RE013','2026-05-13','WH-South','Fast',20,20,'High','Fulfilled',8,'B','Urgent'),
('RE014','2026-05-14','WH-North','Fast',190,190,'Low','Fulfilled',4,'C','Auto'),
('RE015','2026-05-15','WH-West','Standard',260,260,'Low','Fulfilled',NULL,'A','Urgent'),
('RE016','2026-05-16','WH-South','Standard',60,60,'High','Fulfilled',9,'B','Urgent'),
('RE017','2026-05-17','WH-West','Fast',230,230,'High','Partial',7,'B','Planner'),
('RE018','2026-05-18','WH-East','Standard',110,0,'High','Fulfilled',8,'A','Planner'),
('RE019','2026-05-19','WH-South','Bulk',230,230,'Medium','Open',10,'A','Planner'),
('RE020','2026-05-20','WH-West','Fast',280,140,'Medium','Partial',5,'B','Planner'),
('RE021','2026-05-21','WH-East','Bulk',140,140,'Low','Fulfilled',10,'C','Auto'),
('RE022','2026-05-22','WH-West','Standard',100,100,'Low','Fulfilled',NULL,'C','Auto'),
('RE023','2026-05-23','WH-North','Bulk',150,150,'Medium','Fulfilled',3,'B','Auto'),
('RE024','2026-05-24','WH-East','Fast',210,210,'Low','Partial',9,'B','Urgent'),
('RE025','2026-05-25','WH-West','Bulk',190,10,'Medium','Partial',10,'B','Urgent'),
('RE026','2026-05-26','WH-South','Fast',300,300,'Low','Fulfilled',9,'B','Planner'),
('RE027','2026-05-27','WH-North','Standard',290,290,'Medium','Partial',3,'C','Urgent'),
('RE028','2026-05-28','WH-West','Fast',220,220,'Medium','Partial',9,'B','Urgent'),
('RE029','2026-05-29','WH-West','Bulk',70,70,'High','Partial',NULL,'A','Planner'),
('RE030','2026-05-30','WH-West','Fast',230,230,'Medium','Partial',2,'C','Planner'),
('RE031','2026-05-31','WH-South','Fast',20,0,'Medium','Fulfilled',5,'C','Planner'),
('RE032','2026-06-01','WH-East','Standard',110,110,'Low','Fulfilled',9,'A','Urgent'),
('RE033','2026-06-02','WH-North','Fast',220,220,'High','Open',2,'C','Urgent'),
('RE034','2026-06-03','WH-West','Fast',170,0,'Low','Partial',5,'B','Planner'),
('RE035','2026-06-04','WH-East','Standard',210,210,'High','Fulfilled',10,'A','Auto'),
('RE036','2026-06-05','WH-North','Fast',180,180,'High','Partial',NULL,'B','Urgent'),
('RE037','2026-06-06','WH-North','Bulk',130,40,'High','Fulfilled',7,'A','Urgent'),
('RE038','2026-06-07','WH-South','Fast',160,160,'Medium','Fulfilled',7,'C','Auto'),
('RE039','2026-06-08','WH-East','Bulk',90,40,'Low','Fulfilled',3,'C','Urgent'),
('RE040','2026-06-09','WH-North','Fast',180,180,'Medium','Fulfilled',11,'C','Urgent');

SELECT COUNT(*) AS rows_loaded FROM replenishment_events; -- expected 40

-- GATE B TASKS - SINGLE TABLE ONLY
-- Protected first attempt: learner book, protected reviews, tutorial solving and AI-generated solutions are closed.
-- Source table: replenishment_events. State its source grain before Task 1.
-- 1. Return event_id, request_date, warehouse, status and requested_qty for the first 8 rows. State result grain.
-- 2. Return DISTINCT request_channel values and DISTINCT status values in two separate queries. State each DISTINCT result grain.
-- 3. Return rows where status='Fulfilled' AND warehouse equals one valid group of your choice. Write the rule in plain English first.
-- 4. Return rows where lead_days IS NULL. Explain why = NULL is wrong.
-- 5. Return the five largest requested_qty rows using ORDER BY requested_qty DESC + LIMIT 5. Rerun without LIMIT to prove the fifth-row boundary.
-- 6. For status='Fulfilled', return COUNT(*) AS row_count, SUM(requested_qty) AS measure_total and AVG(lead_days) AS avg_duration. Explain COUNT(*) vs COUNT(lead_days).
-- 7. For status='Fulfilled', return one row per warehouse with row_count and SUM(requested_qty). State grouped result grain.
-- 8. Return request_channel groups having at least 10 rows. Include row_count. Use GROUP BY + HAVING.
-- 9. Create size_band with CASE: WHEN requested_qty >= 200 THEN 'Large' WHEN requested_qty >= 100 THEN 'Medium' ELSE 'Small'. Return event_id, requested_qty and size_band.
-- 10. Summarize size_band with COUNT(*) per band and reconcile the band counts to total table rows.
-- 11. In SQL comments explain: source grain; Task-7 result grain; WHERE vs HAVING; why LIMIT without ORDER BY is not top-N; one validation you used.
-- CRITICAL FAIL: wrong result grain, unsafe NULL logic, non-deterministic top-N, wrong aggregate/group logic, CASE boundary failure, or no validation can block a pass.
-- MODULE BOUNDARY: JOIN, CTE, subquery and window-function syntax is outside M03 and cannot substitute for the requested foundation reasoning.
-- Save as SQL_Foundations_Gate_B_<yourname>.sql and evidence as G-SQLF-B before opening Gate B Review.
