-- COURSE 1 - M04 SQL FOR ANALYSTS - CANONICAL PRACTICE TASKS RC1
-- ATTEMPT FIRST: learner book teaches; protected review opens only after a saved genuine attempt.
-- Run C1_M04_SQL_FOR_ANALYSTS_LAB_SETUP_RC1.sql once before SA1.
USE da_sql_analysts;

========================================================================================
-- SA1 - INNER JOIN and LEFT JOIN
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA1 on the canonical lab. Write the grain of both source tables and each result before running the join. Add a matched/unmatched count.
-- VALIDATE
-- State result grain correctly; INNER/LEFT behavior matches the business rule; unmatched count is explicit; no many-side table is treated as one-side without a uniqueness check.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- On a fresh query, join order_items to products for product/category enrichment, then LEFT JOIN a one-row-per-order return summary to orders. Explain why directly joining raw return_events could create extra rows.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain INNER vs LEFT JOIN with one business example and state why result grain must be decided before interpreting totals.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA2 - Cardinality, row multiplication and join validation
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA2: source counts, joined count, freight inflation demonstration, correct order-level item summary, and product-key uniqueness check.
-- VALIDATE
-- Counts before/after are saved; expected multiplication is explained; right-side uniqueness is checked when assumed; at least one monetary total reconciles at the correct grain.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Create a second validation for return_events: prove how multiple events/order can multiply order rows. Build a one-row-per-order return summary and show the row-count difference.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain one-to-one, one-to-many and many-to-many risk using the course tables. Explain why DISTINCT is not a general fix for bad joins.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA3 - String functions for analyst cleaning
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA3 with raw + cleaned columns visible side by side.
-- VALIDATE
-- Raw and cleaned values remain comparable; only justified presentation changes are made; no UPDATE is used; one potentially ambiguous change is left for investigation.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Build a normalized segment label and a customer display label on a fresh result. Flag any row where raw and cleaned city differ; do not update the source table.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain the difference between standardizing text and deciding that two entities are the same.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA4 - Dates and time analysis
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA4 and identify orders shipped more than 3 days after order_date.
-- VALIDATE
-- Elapsed days are correct on a manual sample; NULL ship dates are not treated as zero-day shipping; month results sort chronologically; one monthly count reconciles.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Build a monthly completed-order summary and a late-shipment rate. Validate one month by filtering the source orders directly.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain why DATE_FORMAT text can be useful for display but a true date/month key is safer for chronological analysis.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA5 - Subqueries
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA5 and annotate what the inner query returns at each level.
-- VALIDATE
-- Inner result shape matches how the outer query uses it; thresholds are independently queryable; result contains only rows/groups that satisfy the comparison.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Return products whose total line_sales exceed the average product total. Use a subquery and validate the threshold separately.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain scalar vs list/table-like subquery roles with a simple example.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA6 - CTEs and readable multi-step logic
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA6 and save row counts/totals at each CTE stage.
-- VALIDATE
-- Each CTE has a stated grain; stage counts are plausible; aggregate totals reconcile to the source; final output uses the intended stage rather than raw many-side rows.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Create a monthly_sales CTE and a second CTE for regional monthly sales. Use the final query to compare region share by month and reconcile each month to the monthly total.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain why CTEs improve reasoning/validation even when the same query could be written as one nested statement.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA7 - Window functions and PARTITION BY
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA7 and compare row count with a GROUP BY customer query.
-- VALIDATE
-- Window query preserves the intended detail row count; partition totals match a separate GROUP BY check; ordering is deterministic where sequence matters.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Create one row/order with customer cumulative order sales using an order-level sales CTE plus SUM(...) OVER(PARTITION BY customer_id ORDER BY order_date, order_id).
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain PARTITION BY and why a window can show customer totals without reducing to one row/customer.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA8 - Ranking, latest-row logic and LAG/LEAD
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA8 including latest order/customer, monthly LAG and product ranking.
-- VALIDATE
-- Latest/second-latest logic has deterministic tie-breaker; row count is one/customer where expected; monthly LAG aligns to chronological month_start; percentage change handles NULL/zero safely.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Find each customer's second-most-recent order and build month-over-month absolute + percentage sales change with a safe zero/NULL denominator rule.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain the difference between ROW_NUMBER, RANK and DENSE_RANK, then explain what LAG returns.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.

========================================================================================
-- SA9 - UNION, views and performance awareness
-- TEACHER-GUIDED FOLLOW-ALONG
-- Complete P-SA9 and write concise awareness definitions for view, temp table and index.
-- VALIDATE
-- SELECT lists are type/column compatible; UNION ALL keeps meaningful duplicates; UNION use is justified rather than automatic; no server-administration task is performed.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY - close learner book/review first
-- Create two compatible result sets labeling customers as HighSales and RecentBuyer, combine with UNION ALL, and explain why one customer may legitimately have two rows with different labels.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain UNION vs UNION ALL and give one sentence each for view, temporary table and index at analyst awareness level.
-- EVIDENCE: save runnable SQL + source/result grain + key/row-count check + reconciliation + recovery note.
