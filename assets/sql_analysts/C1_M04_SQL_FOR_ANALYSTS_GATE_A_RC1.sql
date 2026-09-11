DROP DATABASE IF EXISTS c1_sqla_gate_a;
CREATE DATABASE c1_sqla_gate_a;
USE c1_sqla_gate_a;

CREATE TABLE accounts(account_id VARCHAR(10) PRIMARY KEY, account_name VARCHAR(80), region VARCHAR(30), segment VARCHAR(30));
CREATE TABLE products(product_id VARCHAR(10) PRIMARY KEY, product_name VARCHAR(80), category VARCHAR(30), standard_cost DECIMAL(12,2));
CREATE TABLE orders(order_id VARCHAR(10) PRIMARY KEY, order_date DATE, account_id VARCHAR(10), status VARCHAR(20), ship_date DATE NULL, freight_amount DECIMAL(12,2));
CREATE TABLE order_items(order_id VARCHAR(10), line_no INT, product_id VARCHAR(10), quantity INT, unit_price DECIMAL(12,2), discount_pct DECIMAL(6,2), line_sales DECIMAL(12,2), PRIMARY KEY(order_id,line_no));
CREATE TABLE return_events(return_id VARCHAR(10) PRIMARY KEY, order_id VARCHAR(10), event_date DATE, reason VARCHAR(50), units_returned INT);

INSERT INTO accounts (account_id,account_name,region,segment) VALUES
('A01','Orbit Retail','East','SMB'),
('A02','Nova Market','West','Mid'),
('A03','Blue Bazaar','North','SMB'),
('A04','Metro Cart','South','Enterprise'),
('A05','Prime Shop','East','Mid'),
('A06','Urban Basket','West','SMB'),
('A07','Green Store','North','Enterprise'),
('A08','Quick Mart','South','Mid');
INSERT INTO products (product_id,product_name,category,standard_cost) VALUES
('P01','Chair','Furniture',3200),
('P02','Desk','Furniture',5400),
('P03','Keyboard','Technology',900),
('P04','Monitor','Technology',6200),
('P05','Paper Pack','Office',180),
('P06','Pen Set','Office',120);
INSERT INTO orders (order_id,order_date,account_id,status,ship_date,freight_amount) VALUES
('O001','2026-01-02','A04','Complete','2026-01-04',330),
('O002','2026-01-08','A07','Complete','2026-01-11',410),
('O003','2026-01-14','A02','Complete','2026-01-18',490),
('O004','2026-01-20','A05','Pending',NULL,570),
('O005','2026-01-26','A08','Complete','2026-01-27',250),
('O006','2026-02-01','A03','Complete','2026-02-03',330),
('O007','2026-02-07','A06','Complete','2026-02-10',410),
('O008','2026-02-13','A01','Pending',NULL,490),
('O009','2026-02-19','A04','Complete','2026-02-24',570),
('O010','2026-02-25','A07','Complete','2026-02-26',250),
('O011','2026-03-03','A02','Complete','2026-03-05',330),
('O012','2026-03-09','A05','Pending',NULL,410),
('O013','2026-03-15','A08','Complete','2026-03-19',490),
('O014','2026-03-21','A03','Complete','2026-03-26',570),
('O015','2026-03-27','A06','Complete','2026-03-28',250),
('O016','2026-04-02','A01','Pending',NULL,330),
('O017','2026-04-08','A04','Complete','2026-04-11',410),
('O018','2026-04-14','A07','Complete','2026-04-18',490),
('O019','2026-04-20','A02','Complete','2026-04-25',570),
('O020','2026-04-26','A05','Pending',NULL,250),
('O021','2026-05-02','A08','Complete','2026-05-04',330),
('O022','2026-05-08','A03','Complete','2026-05-11',410),
('O023','2026-05-14','A06','Complete','2026-05-18',490),
('O024','2026-05-20','A01','Pending',NULL,570),
('O025','2026-05-26','A04','Complete','2026-05-27',250),
('O026','2026-06-01','A07','Complete','2026-06-03',330),
('O027','2026-06-07','A02','Complete','2026-06-10',410),
('O028','2026-06-13','A05','Pending',NULL,490),
('O029','2026-06-19','A08','Complete','2026-06-24',570),
('O030','2026-06-25','A03','Complete','2026-06-26',250);
INSERT INTO order_items (order_id,line_no,product_id,quantity,unit_price,discount_pct,line_sales) VALUES
('O001',1,'P03',3,1305.0,10,3523.5),
('O001',2,'P04',4,8370.0,0,33480.0),
('O002',1,'P04',4,8370.0,0,33480.0),
('O002',2,'P05',1,252.0,5,239.4),
('O002',3,'P06',2,174.0,10,313.2),
('O003',1,'P05',1,252.0,5,239.4),
('O004',1,'P06',2,174.0,10,313.2),
('O004',2,'P01',3,4320.0,0,12960.0),
('O005',1,'P01',3,4320.0,0,12960.0),
('O005',2,'P02',4,7560.0,5,28728.0),
('O005',3,'P03',1,1305.0,10,1174.5),
('O006',1,'P02',4,7560.0,5,28728.0),
('O007',1,'P03',1,1305.0,10,1174.5),
('O007',2,'P04',2,8370.0,0,16740.0),
('O008',1,'P04',2,8370.0,0,16740.0),
('O008',2,'P05',3,252.0,5,718.2),
('O008',3,'P06',4,174.0,10,626.4),
('O009',1,'P05',3,252.0,5,718.2),
('O010',1,'P06',4,174.0,10,626.4),
('O010',2,'P01',1,4320.0,0,4320.0),
('O011',1,'P01',1,4320.0,0,4320.0),
('O011',2,'P02',2,7560.0,5,14364.0),
('O011',3,'P03',3,1305.0,10,3523.5),
('O012',1,'P02',2,7560.0,5,14364.0),
('O013',1,'P03',3,1305.0,10,3523.5),
('O013',2,'P04',4,8370.0,0,33480.0),
('O014',1,'P04',4,8370.0,0,33480.0),
('O014',2,'P05',1,252.0,5,239.4),
('O014',3,'P06',2,174.0,10,313.2),
('O015',1,'P05',1,252.0,5,239.4),
('O016',1,'P06',2,174.0,10,313.2),
('O016',2,'P01',3,4320.0,0,12960.0),
('O017',1,'P01',3,4320.0,0,12960.0),
('O017',2,'P02',4,7560.0,5,28728.0),
('O017',3,'P03',1,1305.0,10,1174.5),
('O018',1,'P02',4,7560.0,5,28728.0),
('O019',1,'P03',1,1305.0,10,1174.5),
('O019',2,'P04',2,8370.0,0,16740.0),
('O020',1,'P04',2,8370.0,0,16740.0),
('O020',2,'P05',3,252.0,5,718.2),
('O020',3,'P06',4,174.0,10,626.4),
('O021',1,'P05',3,252.0,5,718.2),
('O022',1,'P06',4,174.0,10,626.4),
('O022',2,'P01',1,4320.0,0,4320.0),
('O023',1,'P01',1,4320.0,0,4320.0),
('O023',2,'P02',2,7560.0,5,14364.0),
('O023',3,'P03',3,1305.0,10,3523.5),
('O024',1,'P02',2,7560.0,5,14364.0),
('O025',1,'P03',3,1305.0,10,3523.5),
('O025',2,'P04',4,8370.0,0,33480.0),
('O026',1,'P04',4,8370.0,0,33480.0),
('O026',2,'P05',1,252.0,5,239.4),
('O026',3,'P06',2,174.0,10,313.2),
('O027',1,'P05',1,252.0,5,239.4),
('O028',1,'P06',2,174.0,10,313.2),
('O028',2,'P01',3,4320.0,0,12960.0),
('O029',1,'P01',3,4320.0,0,12960.0),
('O029',2,'P02',4,7560.0,5,28728.0),
('O029',3,'P03',1,1305.0,10,1174.5),
('O030',1,'P02',4,7560.0,5,28728.0);
INSERT INTO return_events (return_id,order_id,event_date,reason,units_returned) VALUES
('R003','O003','2026-01-22','Damaged',1),
('R008','O008','2026-02-21','Damaged',1),
('RX008','O008','2026-02-24','Second review',0),
('R013','O013','2026-03-23','Damaged',1),
('R018','O018','2026-04-22','Damaged',1),
('RX018','O018','2026-04-25','Second review',0),
('R023','O023','2026-05-22','Damaged',1),
('R028','O028','2026-06-21','Damaged',1),
('RX028','O028','2026-06-24','Second review',0);

-- COURSE 1 - M04 SQL FOR ANALYSTS - PROTECTED GATE A RC1
-- DOMAIN: Marketplace Orders
-- STATE MACHINE: A clean pass ends M04; B only after failed A + Review A + targeted repair + explicit assignment.
-- FIRST ATTEMPT: learner book, protected reviews, tutorial solving and AI-generated solutions are closed.
-- Save the attempt + validation evidence BEFORE opening Gate A Review.

-- TASK 1 - GRAIN / KEYS
-- State the grain and intended key of every table. Prove the dimension keys you treat as one-side are unique.

-- TASK 2 - INNER + LEFT JOIN
-- Build one useful INNER JOIN and one useful LEFT JOIN. State output grain before running.
-- For the LEFT JOIN, count orders rows with no matching return_events record instead of silently dropping them.

-- TASK 3 - CARDINALITY TRAP
-- Join orders to order_items. Record row counts before/after.
-- Demonstrate that naive SUM(freight_amount) after this one-to-many join is inflated.
-- Repair the analysis by aggregating the line side or preserving the measure at order_id grain.
-- Do NOT use DISTINCT as a band-aid.

-- TASK 4 - STRING CLEANING
-- Return one raw descriptive text field beside TRIM/case/CONCAT cleaned display output.
-- Do not UPDATE source data or invent entity equivalence.

-- TASK 5 - DATES
-- For Complete records, calculate elapsed days using the fixture's true date fields including ship_date, and build a chronological monthly key/result.
-- NULL end dates must remain NULL/not applicable, not zero-day completion.

-- TASK 6 - SUBQUERY
-- Answer one above-average question with a subquery. Run the inner query separately and state its result shape/grain.

-- TASK 7 - CTE PIPELINE
-- Build a first CTE at one row/order_id using SUM(line_sales).
-- Validate its row count and total. Build a second higher-level CTE/result and state each stage grain.

-- TASK 8 - WINDOW AGGREGATE
-- Keep a deliberate detail grain while adding a partition-level SUM/COUNT/AVG with OVER(PARTITION BY ...).
-- Validate one partition against a GROUP BY query.

-- TASK 9 - RANK / LATEST / LAG
-- Use ROW_NUMBER with deterministic ordering for latest-row logic.
-- Use RANK or DENSE_RANK with tie behavior explained.
-- Build monthly line_sales totals and use LAG for prior-month absolute + percentage change with safe NULL/zero handling.

-- TASK 10 - UNION ALL
-- Build two compatible labelled cohorts and combine them with UNION ALL.
-- Explain why the same entity can legitimately appear twice under different labels. Use UNION only if deduplication is intended.

-- TASK 11 - VALIDATION EVIDENCE
-- Save source counts, join counts, one-side uniqueness checks, unmatched count, raw line_sales total,
-- corrected freight_amount total, at least one monthly reconciliation and one independent spot check.

-- TASK 12 - BUSINESS DEFENSE
-- Write three supported findings, one recommendation and limitations.
-- Separate observation from hypothesis and identify at least one conclusion the fixture cannot prove.

-- CRITICAL FAIL:
-- Wrong/unexplained result grain; unexplained row multiplication; inflated freight_amount presented as correct;
-- missing key-uniqueness check; hidden unmatched records; non-deterministic latest-row logic; broken LAG denominator;
-- failed reconciliation; or inability to explain the query architecture can block a pass.
