DROP DATABASE IF EXISTS c1_sqla_gate_b;
CREATE DATABASE c1_sqla_gate_b;
USE c1_sqla_gate_b;

CREATE TABLE guests(guest_id VARCHAR(10) PRIMARY KEY, guest_name VARCHAR(80), city VARCHAR(40), tier VARCHAR(30));
CREATE TABLE room_types(room_type_id VARCHAR(10) PRIMARY KEY, room_type VARCHAR(50), class_name VARCHAR(30), base_rate DECIMAL(12,2));
CREATE TABLE reservations(reservation_id VARCHAR(10) PRIMARY KEY, guest_id VARCHAR(10), checkin_date DATE, checkout_date DATE, status VARCHAR(20), service_fee DECIMAL(12,2));
CREATE TABLE reservation_nights(reservation_id VARCHAR(10), night_no INT, room_type_id VARCHAR(10), night_date DATE, room_rate DECIMAL(12,2), PRIMARY KEY(reservation_id,night_no));
CREATE TABLE service_events(event_id VARCHAR(10) PRIMARY KEY, reservation_id VARCHAR(10), event_date DATE, event_type VARCHAR(40), amount DECIMAL(12,2));

INSERT INTO guests (guest_id,guest_name,city,tier) VALUES
('G01','Aarav Shah','Delhi','Silver'),
('G02','Meera Rao','Mumbai','Gold'),
('G03','Kabir Sen','Pune','Silver'),
('G04','Nisha Das','Kolkata','Platinum'),
('G05','Rohan Jain','Jaipur','Gold'),
('G06','Isha Bose','Delhi','Silver'),
('G07','Vikram Nair','Kochi','Gold'),
('G08','Sara Ali','Lucknow','Platinum');
INSERT INTO room_types (room_type_id,room_type,class_name,base_rate) VALUES
('RT01','Standard','Standard',3200),
('RT02','Deluxe','Premium',5200),
('RT03','Suite','Premium',9000),
('RT04','Family','Standard',6100),
('RT05','Business','Business',7400);
INSERT INTO reservations (reservation_id,guest_id,checkin_date,checkout_date,status,service_fee) VALUES
('B001','G06','2026-02-01','2026-02-03','CheckedOut',450),
('B002','G03','2026-02-06','2026-02-09','CheckedOut',600),
('B003','G08','2026-02-11','2026-02-15','CheckedOut',750),
('B004','G05','2026-02-16','2026-02-17','CheckedOut',300),
('B005','G02','2026-02-21','2026-02-23','Cancelled',450),
('B006','G07','2026-02-26','2026-03-01','CheckedOut',600),
('B007','G04','2026-03-03','2026-03-07','CheckedOut',750),
('B008','G01','2026-03-08','2026-03-09','CheckedOut',300),
('B009','G06','2026-03-13','2026-03-15','CheckedOut',450),
('B010','G03','2026-03-18','2026-03-21','Cancelled',600),
('B011','G08','2026-03-23','2026-03-27','CheckedOut',750),
('B012','G05','2026-03-28','2026-03-29','CheckedOut',300),
('B013','G02','2026-04-02','2026-04-04','CheckedOut',450),
('B014','G07','2026-04-07','2026-04-10','CheckedOut',600),
('B015','G04','2026-04-12','2026-04-16','Cancelled',750),
('B016','G01','2026-04-17','2026-04-18','CheckedOut',300),
('B017','G06','2026-04-22','2026-04-24','CheckedOut',450),
('B018','G03','2026-04-27','2026-04-30','CheckedOut',600),
('B019','G08','2026-05-02','2026-05-06','CheckedOut',750),
('B020','G05','2026-05-07','2026-05-08','Cancelled',300),
('B021','G02','2026-05-12','2026-05-14','CheckedOut',450),
('B022','G07','2026-05-17','2026-05-20','CheckedOut',600),
('B023','G04','2026-05-22','2026-05-26','CheckedOut',750),
('B024','G01','2026-05-27','2026-05-28','CheckedOut',300),
('B025','G06','2026-06-01','2026-06-03','Cancelled',450),
('B026','G03','2026-06-06','2026-06-09','CheckedOut',600),
('B027','G08','2026-06-11','2026-06-15','CheckedOut',750),
('B028','G05','2026-06-16','2026-06-17','CheckedOut',300);
INSERT INTO reservation_nights (reservation_id,night_no,room_type_id,night_date,room_rate) VALUES
('B001',1,'RT03','2026-02-01',9000.0),
('B001',2,'RT04','2026-02-02',6405.0),
('B002',1,'RT04','2026-02-06',6405.0),
('B002',2,'RT05','2026-02-07',6660.0),
('B002',3,'RT01','2026-02-08',3040.0),
('B003',1,'RT05','2026-02-11',6660.0),
('B004',1,'RT01','2026-02-16',3040.0),
('B004',2,'RT02','2026-02-17',5200.0),
('B005',1,'RT02','2026-02-21',5200.0),
('B005',2,'RT03','2026-02-22',9450.0),
('B005',3,'RT04','2026-02-23',5490.0),
('B006',1,'RT03','2026-02-26',9450.0),
('B007',1,'RT04','2026-03-03',5490.0),
('B007',2,'RT05','2026-03-04',7030.0),
('B008',1,'RT05','2026-03-08',7030.0),
('B008',2,'RT01','2026-03-09',3200.0),
('B008',3,'RT02','2026-03-10',5460.0),
('B009',1,'RT01','2026-03-13',3200.0),
('B010',1,'RT02','2026-03-18',5460.0),
('B010',2,'RT03','2026-03-19',8100.0),
('B011',1,'RT03','2026-03-23',8100.0),
('B011',2,'RT04','2026-03-24',5795.0),
('B011',3,'RT05','2026-03-25',7400.0),
('B012',1,'RT04','2026-03-28',5795.0),
('B013',1,'RT05','2026-04-02',7400.0),
('B013',2,'RT01','2026-04-03',3360.0),
('B014',1,'RT01','2026-04-07',3360.0),
('B014',2,'RT02','2026-04-08',4680.0),
('B014',3,'RT03','2026-04-09',8550.0),
('B015',1,'RT02','2026-04-12',4680.0),
('B016',1,'RT03','2026-04-17',8550.0),
('B016',2,'RT04','2026-04-18',6100.0),
('B017',1,'RT04','2026-04-22',6100.0),
('B017',2,'RT05','2026-04-23',7770.0),
('B017',3,'RT01','2026-04-24',2880.0),
('B018',1,'RT05','2026-04-27',7770.0),
('B019',1,'RT01','2026-05-02',2880.0),
('B019',2,'RT02','2026-05-03',4940.0),
('B020',1,'RT02','2026-05-07',4940.0),
('B020',2,'RT03','2026-05-08',9000.0),
('B020',3,'RT04','2026-05-09',6405.0),
('B021',1,'RT03','2026-05-12',9000.0),
('B022',1,'RT04','2026-05-17',6405.0),
('B022',2,'RT05','2026-05-18',6660.0),
('B023',1,'RT05','2026-05-22',6660.0),
('B023',2,'RT01','2026-05-23',3040.0),
('B023',3,'RT02','2026-05-24',5200.0),
('B024',1,'RT01','2026-05-27',3040.0),
('B025',1,'RT02','2026-06-01',5200.0),
('B025',2,'RT03','2026-06-02',9450.0),
('B026',1,'RT03','2026-06-06',9450.0),
('B026',2,'RT04','2026-06-07',5490.0),
('B026',3,'RT05','2026-06-08',7030.0),
('B027',1,'RT04','2026-06-11',5490.0),
('B028',1,'RT05','2026-06-16',7030.0),
('B028',2,'RT01','2026-06-17',3200.0);
INSERT INTO service_events (event_id,reservation_id,event_date,event_type,amount) VALUES
('E004','B004','2026-02-17','Complaint',0),
('E009','B009','2026-03-14','Complaint',0),
('EX009','B009','2026-03-15','Recovery Credit',500),
('E014','B014','2026-04-08','Complaint',0),
('E019','B019','2026-05-03','Complaint',0),
('EX019','B019','2026-05-04','Recovery Credit',500),
('E024','B024','2026-05-28','Complaint',0);

-- COURSE 1 - M04 SQL FOR ANALYSTS - PROTECTED GATE B RC1
-- DOMAIN: Hotel Reservations
-- STATE MACHINE: Gate B is remediation-only after failed A + repair + explicit assignment. A clean B pass ends M04; C only after failed B + repair + explicit assignment.
-- FIRST ATTEMPT: learner book, protected reviews, tutorial solving and AI-generated solutions are closed.
-- Save the attempt + validation evidence BEFORE opening Gate B Review.

-- TASK 1 - GRAIN / KEYS
-- State the grain and intended key of every table. Prove the dimension keys you treat as one-side are unique.

-- TASK 2 - INNER + LEFT JOIN
-- Build one useful INNER JOIN and one useful LEFT JOIN. State output grain before running.
-- For the LEFT JOIN, count reservations rows with no matching service_events record instead of silently dropping them.

-- TASK 3 - CARDINALITY TRAP
-- Join reservations to reservation_nights. Record row counts before/after.
-- Demonstrate that naive SUM(service_fee) after this one-to-many join is inflated.
-- Repair the analysis by aggregating the line side or preserving the measure at reservation_id grain.
-- Do NOT use DISTINCT as a band-aid.

-- TASK 4 - STRING CLEANING
-- Return one raw descriptive text field beside TRIM/case/CONCAT cleaned display output.
-- Do not UPDATE source data or invent entity equivalence.

-- TASK 5 - DATES
-- For CheckedOut records, calculate elapsed days using the fixture's true date fields including checkout_date, and build a chronological monthly key/result.
-- NULL end dates must remain NULL/not applicable, not zero-day completion.

-- TASK 6 - SUBQUERY
-- Answer one above-average question with a subquery. Run the inner query separately and state its result shape/grain.

-- TASK 7 - CTE PIPELINE
-- Build a first CTE at one row/reservation_id using SUM(room_rate).
-- Validate its row count and total. Build a second higher-level CTE/result and state each stage grain.

-- TASK 8 - WINDOW AGGREGATE
-- Keep a deliberate detail grain while adding a partition-level SUM/COUNT/AVG with OVER(PARTITION BY ...).
-- Validate one partition against a GROUP BY query.

-- TASK 9 - RANK / LATEST / LAG
-- Use ROW_NUMBER with deterministic ordering for latest-row logic.
-- Use RANK or DENSE_RANK with tie behavior explained.
-- Build monthly room_rate totals and use LAG for prior-month absolute + percentage change with safe NULL/zero handling.

-- TASK 10 - UNION ALL
-- Build two compatible labelled cohorts and combine them with UNION ALL.
-- Explain why the same entity can legitimately appear twice under different labels. Use UNION only if deduplication is intended.

-- TASK 11 - VALIDATION EVIDENCE
-- Save source counts, join counts, one-side uniqueness checks, unmatched count, raw room_rate total,
-- corrected service_fee total, at least one monthly reconciliation and one independent spot check.

-- TASK 12 - BUSINESS DEFENSE
-- Write three supported findings, one recommendation and limitations.
-- Separate observation from hypothesis and identify at least one conclusion the fixture cannot prove.

-- CRITICAL FAIL:
-- Wrong/unexplained result grain; unexplained row multiplication; inflated service_fee presented as correct;
-- missing key-uniqueness check; hidden unmatched records; non-deterministic latest-row logic; broken LAG denominator;
-- failed reconciliation; or inability to explain the query architecture can block a pass.
