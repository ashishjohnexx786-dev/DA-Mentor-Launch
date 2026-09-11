DROP DATABASE IF EXISTS c1_sqla_gate_c;
CREATE DATABASE c1_sqla_gate_c;
USE c1_sqla_gate_c;

CREATE TABLE accounts(account_id VARCHAR(10) PRIMARY KEY, account_name VARCHAR(80), region VARCHAR(30), tier VARCHAR(30));
CREATE TABLE plans(plan_id VARCHAR(10) PRIMARY KEY, plan_name VARCHAR(80), family VARCHAR(30), monthly_rate DECIMAL(12,2));
CREATE TABLE invoices(invoice_id VARCHAR(10) PRIMARY KEY, account_id VARCHAR(10), invoice_date DATE, status VARCHAR(20), paid_date DATE NULL, processing_fee DECIMAL(12,2));
CREATE TABLE invoice_lines(invoice_id VARCHAR(10), line_no INT, plan_id VARCHAR(10), quantity INT, line_amount DECIMAL(12,2), PRIMARY KEY(invoice_id,line_no));
CREATE TABLE payment_events(payment_event_id VARCHAR(10) PRIMARY KEY, invoice_id VARCHAR(10), event_date DATE, event_type VARCHAR(40), event_amount DECIMAL(12,2));

INSERT INTO accounts (account_id,account_name,region,tier) VALUES
('C01','Acme Labs','East','Starter'),
('C02','Zen Works','West','Growth'),
('C03','Nimbus Co','North','Growth'),
('C04','Vertex Ltd','South','Scale'),
('C05','Cedar Tech','East','Scale'),
('C06','Moonlight','West','Starter'),
('C07','Delta House','North','Growth'),
('C08','Rapid Systems','South','Scale');
INSERT INTO plans (plan_id,plan_name,family,monthly_rate) VALUES
('PL01','Starter 10','Starter',12000),
('PL02','Growth 25','Growth',28000),
('PL03','Scale 50','Scale',52000),
('PL04','Analytics Addon','Addon',9000),
('PL05','Support Plus','Addon',6000);
INSERT INTO invoices (invoice_id,account_id,invoice_date,status,paid_date,processing_fee) VALUES
('I001','C04','2026-01-31','Paid','2026-02-03',300),
('I002','C07','2026-02-15','Paid','2026-02-19',400),
('I003','C02','2026-03-02','Paid','2026-03-07',500),
('I004','C05','2026-03-17','Open',NULL,600),
('I005','C08','2026-04-01','Paid','2026-04-08',200),
('I006','C03','2026-04-16','Paid','2026-04-18',300),
('I007','C06','2026-05-01','Paid','2026-05-04',400),
('I008','C01','2026-05-16','Open',NULL,500),
('I009','C04','2026-05-31','Paid','2026-06-05',600),
('I010','C07','2026-06-15','Paid','2026-06-21',200),
('I011','C02','2026-06-30','Paid','2026-07-07',300),
('I012','C05','2026-07-15','Open',NULL,400),
('I013','C08','2026-07-30','Paid','2026-08-02',500),
('I014','C03','2026-08-14','Paid','2026-08-18',600),
('I015','C06','2026-08-29','Paid','2026-09-03',200),
('I016','C01','2026-09-13','Open',NULL,300),
('I017','C04','2026-09-28','Paid','2026-10-05',400),
('I018','C07','2026-10-13','Paid','2026-10-15',500),
('I019','C02','2026-10-28','Paid','2026-10-31',600),
('I020','C05','2026-11-12','Open',NULL,200),
('I021','C08','2026-11-27','Paid','2026-12-02',300),
('I022','C03','2026-12-12','Paid','2026-12-18',400),
('I023','C06','2026-12-27','Paid','2027-01-03',500),
('I024','C01','2027-01-11','Open',NULL,600),
('I025','C04','2027-01-26','Paid','2027-01-29',200),
('I026','C07','2027-02-10','Paid','2027-02-14',300),
('I027','C02','2027-02-25','Paid','2027-03-02',400),
('I028','C05','2027-03-12','Open',NULL,500),
('I029','C08','2027-03-27','Paid','2027-04-03',600),
('I030','C03','2027-04-11','Paid','2027-04-13',200),
('I031','C06','2027-04-26','Paid','2027-04-29',300),
('I032','C01','2027-05-11','Open',NULL,400);
INSERT INTO invoice_lines (invoice_id,line_no,plan_id,quantity,line_amount) VALUES
('I001',1,'PL03',1,52000.0),
('I001',2,'PL04',1,9000.0),
('I002',1,'PL04',1,9000.0),
('I002',2,'PL05',2,12000.0),
('I002',3,'PL01',1,12000.0),
('I003',1,'PL05',2,12000.0),
('I004',1,'PL01',1,12000.0),
('I004',2,'PL02',1,28000.0),
('I005',1,'PL02',1,26600.0),
('I005',2,'PL03',1,49400.0),
('I005',3,'PL04',3,25650.0),
('I006',1,'PL03',1,52000.0),
('I007',1,'PL04',3,27000.0),
('I007',2,'PL05',1,6000.0),
('I008',1,'PL05',1,6000.0),
('I008',2,'PL01',1,12000.0),
('I008',3,'PL02',1,28000.0),
('I009',1,'PL01',1,12000.0),
('I010',1,'PL02',1,26600.0),
('I010',2,'PL03',1,49400.0),
('I011',1,'PL03',1,52000.0),
('I011',2,'PL04',2,18000.0),
('I011',3,'PL05',3,18000.0),
('I012',1,'PL04',2,18000.0),
('I013',1,'PL05',3,18000.0),
('I013',2,'PL01',1,12000.0),
('I014',1,'PL01',1,12000.0),
('I014',2,'PL02',1,28000.0),
('I014',3,'PL03',1,52000.0),
('I015',1,'PL02',1,26600.0),
('I016',1,'PL03',1,52000.0),
('I016',2,'PL04',1,9000.0),
('I017',1,'PL04',1,9000.0),
('I017',2,'PL05',2,12000.0),
('I017',3,'PL01',1,12000.0),
('I018',1,'PL05',2,12000.0),
('I019',1,'PL01',1,12000.0),
('I019',2,'PL02',1,28000.0),
('I020',1,'PL02',1,26600.0),
('I020',2,'PL03',1,49400.0),
('I020',3,'PL04',3,25650.0),
('I021',1,'PL03',1,52000.0),
('I022',1,'PL04',3,27000.0),
('I022',2,'PL05',1,6000.0),
('I023',1,'PL05',1,6000.0),
('I023',2,'PL01',1,12000.0),
('I023',3,'PL02',1,28000.0),
('I024',1,'PL01',1,12000.0),
('I025',1,'PL02',1,26600.0),
('I025',2,'PL03',1,49400.0),
('I026',1,'PL03',1,52000.0),
('I026',2,'PL04',2,18000.0),
('I026',3,'PL05',3,18000.0),
('I027',1,'PL04',2,18000.0),
('I028',1,'PL05',3,18000.0),
('I028',2,'PL01',1,12000.0),
('I029',1,'PL01',1,12000.0),
('I029',2,'PL02',1,28000.0),
('I029',3,'PL03',1,52000.0),
('I030',1,'PL02',1,26600.0),
('I031',1,'PL03',1,52000.0),
('I031',2,'PL04',1,9000.0),
('I032',1,'PL04',1,9000.0),
('I032',2,'PL05',2,12000.0),
('I032',3,'PL01',1,12000.0);
INSERT INTO payment_events (payment_event_id,invoice_id,event_date,event_type,event_amount) VALUES
('P005','I005','2026-04-05','Attempt',0),
('P010','I010','2026-06-19','Attempt',0),
('PX010','I010','2026-06-22','Retry',0),
('P015','I015','2026-09-02','Attempt',0),
('P020','I020','2026-11-16','Attempt',0),
('PX020','I020','2026-11-19','Retry',0),
('P025','I025','2027-01-30','Attempt',0),
('P030','I030','2027-04-15','Attempt',0),
('PX030','I030','2027-04-18','Retry',0);

-- COURSE 1 - M04 SQL FOR ANALYSTS - PROTECTED GATE C RC1
-- DOMAIN: Subscription Invoices
-- STATE MACHINE: Gate C is remediation-only after failed B + repair + explicit assignment. A clean C pass ends M04. There is no Gate D.
-- FIRST ATTEMPT: learner book, protected reviews, tutorial solving and AI-generated solutions are closed.
-- Save the attempt + validation evidence BEFORE opening Gate C Review.

-- TASK 1 - GRAIN / KEYS
-- State the grain and intended key of every table. Prove the dimension keys you treat as one-side are unique.

-- TASK 2 - INNER + LEFT JOIN
-- Build one useful INNER JOIN and one useful LEFT JOIN. State output grain before running.
-- For the LEFT JOIN, count invoices rows with no matching payment_events record instead of silently dropping them.

-- TASK 3 - CARDINALITY TRAP
-- Join invoices to invoice_lines. Record row counts before/after.
-- Demonstrate that naive SUM(processing_fee) after this one-to-many join is inflated.
-- Repair the analysis by aggregating the line side or preserving the measure at invoice_id grain.
-- Do NOT use DISTINCT as a band-aid.

-- TASK 4 - STRING CLEANING
-- Return one raw descriptive text field beside TRIM/case/CONCAT cleaned display output.
-- Do not UPDATE source data or invent entity equivalence.

-- TASK 5 - DATES
-- For Paid records, calculate elapsed days using the fixture's true date fields including paid_date, and build a chronological monthly key/result.
-- NULL end dates must remain NULL/not applicable, not zero-day completion.

-- TASK 6 - SUBQUERY
-- Answer one above-average question with a subquery. Run the inner query separately and state its result shape/grain.

-- TASK 7 - CTE PIPELINE
-- Build a first CTE at one row/invoice_id using SUM(line_amount).
-- Validate its row count and total. Build a second higher-level CTE/result and state each stage grain.

-- TASK 8 - WINDOW AGGREGATE
-- Keep a deliberate detail grain while adding a partition-level SUM/COUNT/AVG with OVER(PARTITION BY ...).
-- Validate one partition against a GROUP BY query.

-- TASK 9 - RANK / LATEST / LAG
-- Use ROW_NUMBER with deterministic ordering for latest-row logic.
-- Use RANK or DENSE_RANK with tie behavior explained.
-- Build monthly line_amount totals and use LAG for prior-month absolute + percentage change with safe NULL/zero handling.

-- TASK 10 - UNION ALL
-- Build two compatible labelled cohorts and combine them with UNION ALL.
-- Explain why the same entity can legitimately appear twice under different labels. Use UNION only if deduplication is intended.

-- TASK 11 - VALIDATION EVIDENCE
-- Save source counts, join counts, one-side uniqueness checks, unmatched count, raw line_amount total,
-- corrected processing_fee total, at least one monthly reconciliation and one independent spot check.

-- TASK 12 - BUSINESS DEFENSE
-- Write three supported findings, one recommendation and limitations.
-- Separate observation from hypothesis and identify at least one conclusion the fixture cannot prove.

-- CRITICAL FAIL:
-- Wrong/unexplained result grain; unexplained row multiplication; inflated processing_fee presented as correct;
-- missing key-uniqueness check; hidden unmatched records; non-deterministic latest-row logic; broken LAG denominator;
-- failed reconciliation; or inability to explain the query architecture can block a pass.
