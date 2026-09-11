-- COURSE 1 - M03 SQL FOUNDATIONS - PROTECTED GATE C RC1
-- DOMAIN: customer success renewals
-- ROLE: fresh remediation retest
-- STATE MACHINE: Gate C is attempted only after failed B + repair + explicit assignment. A clean C pass ends M03. There is no Gate D; failed C returns to targeted repair + changed evidence.
-- MODULE BOUNDARY: single-table SELECT/WHERE/ORDER BY/LIMIT/aggregates/GROUP BY/HAVING/CASE only.

DROP DATABASE IF EXISTS da_sql_foundations_gate_c;
CREATE DATABASE da_sql_foundations_gate_c;
USE da_sql_foundations_gate_c;

CREATE TABLE renewal_cases (
  renewal_id VARCHAR(10) PRIMARY KEY,
  renewal_date DATE NOT NULL,
  region VARCHAR(20) NOT NULL,
  customer_segment VARCHAR(20) NOT NULL,
  plan VARCHAR(20) NOT NULL,
  renewal_value DECIMAL(12,2) NOT NULL,
  status VARCHAR(20) NOT NULL,
  days_to_close INT NULL,
  health_score INT NULL,
  owner_team VARCHAR(20) NOT NULL,
  channel VARCHAR(20) NOT NULL
);

INSERT INTO renewal_cases (renewal_id,renewal_date,region,customer_segment,plan,renewal_value,status,days_to_close,health_score,owner_team,channel) VALUES
('CR001','2026-06-01','South','MidMarket','Basic',41500,'Renewed',NULL,NULL,'Alpha','Email'),
('CR002','2026-06-03','West','MidMarket','Basic',51000,'Renewed',42,3,'Alpha','Email'),
('CR003','2026-06-05','North','MidMarket','Plus',60500,'Renewed',8,4,'Beta','Email'),
('CR004','2026-06-07','North','Enterprise','Pro',62000,'Renewed',44,2,'Gamma','Email'),
('CR005','2026-06-09','East','Enterprise','Plus',47000,'Renewed',26,3,'Beta','Email'),
('CR006','2026-06-11','South','SMB','Plus',38000,'Renewed',16,5,'Gamma','Partner'),
('CR007','2026-06-13','South','Enterprise','Basic',45500,'Renewed',43,NULL,'Alpha','Partner'),
('CR008','2026-06-15','East','Enterprise','Plus',31000,'AtRisk',29,4,'Gamma','Email'),
('CR009','2026-06-17','East','Enterprise','Plus',57500,'Renewed',NULL,2,'Beta','Email'),
('CR010','2026-06-19','East','SMB','Plus',5500,'AtRisk',6,1,'Gamma','Partner'),
('CR011','2026-06-21','East','Enterprise','Pro',60000,'Renewed',42,5,'Gamma','CSM'),
('CR012','2026-06-23','East','MidMarket','Plus',42000,'Renewed',11,3,'Alpha','Email'),
('CR013','2026-06-25','North','SMB','Plus',25000,'Renewed',32,NULL,'Beta','CSM'),
('CR014','2026-06-27','North','Enterprise','Plus',54000,'AtRisk',26,5,'Beta','Email'),
('CR015','2026-06-29','East','MidMarket','Basic',63500,'Renewed',24,1,'Alpha','CSM'),
('CR016','2026-07-01','West','MidMarket','Basic',13000,'Renewed',6,4,'Gamma','Partner'),
('CR017','2026-07-03','North','Enterprise','Pro',36000,'AtRisk',NULL,1,'Beta','Partner'),
('CR018','2026-07-05','South','MidMarket','Plus',41500,'AtRisk',43,4,'Beta','Email'),
('CR019','2026-07-07','West','MidMarket','Pro',10000,'AtRisk',21,NULL,'Beta','CSM'),
('CR020','2026-07-09','West','MidMarket','Plus',41500,'Renewed',43,2,'Alpha','Email'),
('CR021','2026-07-11','East','Enterprise','Pro',21500,'Renewed',20,2,'Gamma','CSM'),
('CR022','2026-07-13','West','SMB','Basic',72000,'Renewed',39,5,'Gamma','Partner'),
('CR023','2026-07-15','East','MidMarket','Pro',41000,'AtRisk',23,3,'Gamma','Partner'),
('CR024','2026-07-17','South','MidMarket','Plus',64500,'Renewed',3,3,'Alpha','CSM'),
('CR025','2026-07-19','South','MidMarket','Plus',64500,'AtRisk',NULL,NULL,'Beta','Email'),
('CR026','2026-07-21','North','MidMarket','Basic',38000,'AtRisk',16,5,'Gamma','Partner'),
('CR027','2026-07-23','North','Enterprise','Pro',81500,'AtRisk',39,5,'Beta','Partner'),
('CR028','2026-07-25','North','MidMarket','Basic',48000,'Renewed',45,1,'Alpha','Partner'),
('CR029','2026-07-27','North','MidMarket','Pro',41500,'AtRisk',11,1,'Beta','CSM'),
('CR030','2026-07-29','North','Enterprise','Plus',30500,'AtRisk',33,4,'Gamma','Email'),
('CR031','2026-07-31','North','SMB','Basic',11500,'AtRisk',6,NULL,'Beta','Email'),
('CR032','2026-08-02','South','SMB','Pro',77000,'Renewed',42,4,'Beta','Partner'),
('CR033','2026-08-04','West','MidMarket','Plus',80000,'Renewed',NULL,1,'Alpha','CSM'),
('CR034','2026-08-06','North','MidMarket','Basic',56500,'Lost',7,2,'Gamma','Email'),
('CR035','2026-08-08','West','MidMarket','Basic',81500,'Renewed',35,3,'Alpha','CSM'),
('CR036','2026-08-10','East','MidMarket','Pro',69500,'Renewed',2,4,'Gamma','CSM'),
('CR037','2026-08-12','East','Enterprise','Basic',19000,'AtRisk',16,NULL,'Alpha','Email'),
('CR038','2026-08-14','North','SMB','Basic',17500,'AtRisk',38,1,'Beta','CSM'),
('CR039','2026-08-16','North','SMB','Basic',24000,'Renewed',31,1,'Alpha','Email'),
('CR040','2026-08-18','West','SMB','Basic',29000,'Renewed',43,1,'Gamma','CSM'),
('CR041','2026-08-20','West','SMB','Basic',26500,'Renewed',NULL,3,'Beta','Email'),
('CR042','2026-08-22','East','MidMarket','Pro',79500,'AtRisk',26,4,'Alpha','Partner'),
('CR043','2026-08-24','West','SMB','Pro',71000,'Renewed',6,NULL,'Beta','Partner'),
('CR044','2026-08-26','North','SMB','Plus',14000,'AtRisk',4,2,'Beta','CSM');

SELECT COUNT(*) AS rows_loaded FROM renewal_cases; -- expected 44

-- GATE C TASKS - SINGLE TABLE ONLY
-- Protected first attempt: learner book, protected reviews, tutorial solving and AI-generated solutions are closed.
-- Source table: renewal_cases. State its source grain before Task 1.
-- 1. Return renewal_id, renewal_date, region, status and renewal_value for the first 8 rows. State result grain.
-- 2. Return DISTINCT channel values and DISTINCT status values in two separate queries. State each DISTINCT result grain.
-- 3. Return rows where status='Renewed' AND region equals one valid group of your choice. Write the rule in plain English first.
-- 4. Return rows where health_score IS NULL. Explain why = NULL is wrong.
-- 5. Return the five largest renewal_value rows using ORDER BY renewal_value DESC + LIMIT 5. Rerun without LIMIT to prove the fifth-row boundary.
-- 6. For status='Renewed', return COUNT(*) AS row_count, SUM(renewal_value) AS measure_total and AVG(days_to_close) AS avg_duration. Explain COUNT(*) vs COUNT(days_to_close).
-- 7. For status='Renewed', return one row per region with row_count and SUM(renewal_value). State grouped result grain.
-- 8. Return channel groups having at least 10 rows. Include row_count. Use GROUP BY + HAVING.
-- 9. Create size_band with CASE: WHEN renewal_value >= 60000 THEN 'Large' WHEN renewal_value >= 25000 THEN 'Medium' ELSE 'Small'. Return renewal_id, renewal_value and size_band.
-- 10. Summarize size_band with COUNT(*) per band and reconcile the band counts to total table rows.
-- 11. In SQL comments explain: source grain; Task-7 result grain; WHERE vs HAVING; why LIMIT without ORDER BY is not top-N; one validation you used.
-- CRITICAL FAIL: wrong result grain, unsafe NULL logic, non-deterministic top-N, wrong aggregate/group logic, CASE boundary failure, or no validation can block a pass.
-- MODULE BOUNDARY: JOIN, CTE, subquery and window-function syntax is outside M03 and cannot substitute for the requested foundation reasoning.
-- Save as SQL_Foundations_Gate_C_<yourname>.sql and evidence as G-SQLF-C before opening Gate C Review.
