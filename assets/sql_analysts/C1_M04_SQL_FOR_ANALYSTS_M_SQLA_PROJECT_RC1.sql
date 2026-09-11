-- COURSE 1 - M04 SQL FOR ANALYSTS - M-SQLA INTEGRATED PROJECT RC1
-- BUSINESS REQUEST:
-- Revenue is changing. Identify which customers/products drive it, whether shipping delays or returns appear related,
-- and which findings are trustworthy enough to discuss with a manager.
--
-- PREREQUISITE:
-- SA1-SA9 fresh practice evidence. Do not use a project query pattern before the lesson that teaches it.
--
USE da_sql_analysts;

-- STEP 1 - DEFINE BEFORE QUERYING
-- Write in comments:
--   source grain of orders, order_items, customers, products, return_events
--   exact definition of line sales used
--   which table owns freight_amount and why
--   what one row in your final management result should represent

-- STEP 2 - PROVE KEYS / CARDINALITY
-- Prove customers.customer_id and products.product_id are unique.
-- Count orders, order_items and return_events.
-- Show why orders -> order_items is one-to-many.
-- Show that some orders can have multiple return_events.
-- Do NOT use DISTINCT as a repair for unexplained multiplication.

-- STEP 3 - WORKED MICRO-EXAMPLE
-- Build one order-level CTE:
--   one row/order_id
--   SUM(order_items.line_sales) AS order_sales
-- Validate its row count and SUM(order_sales) against raw order_items.
-- Only after this works, join that one-row/order result to orders/customers.

-- STEP 4 - CLEAN / DATE ANALYSIS
-- Keep raw customer_name/city visible beside TRIM/case-standardized display fields.
-- For completed orders, calculate ship_days with DATEDIFF.
-- Build a true chronological month_start or YEAR+MONTH key.

-- STEP 5 - ANALYTICAL QUESTIONS
-- A) Customer drivers: customer sales + order count + share of total.
-- B) Product drivers: product/category sales + rank.
-- C) Monthly trend: monthly sales + LAG prior month + absolute/% change with safe NULL/zero handling.
-- D) Shipping: completed order count + late (>3 day) count/rate by month or region.
-- E) Returns: aggregate return_events to one row/order BEFORE joining to order-level sales; compare returned vs non-returned groups descriptively.
-- Do not claim that returns or delays caused revenue changes from this observational fixture.

-- STEP 6 - WINDOWS / LATEST ROW
-- Keep detail rows where useful and add a partition-level metric with a window.
-- Build one deterministic ROW_NUMBER latest-order/customer result with a tie-breaker.
-- Demonstrate RANK or DENSE_RANK on product/category sales with tie behavior explained.

-- STEP 7 - UNION ALL AWARENESS
-- Create two compatible labelled cohorts such as HighSales and RecentBuyer.
-- Stack with UNION ALL. Explain why one customer may legitimately appear twice with different labels.
-- Use UNION only if deduplication is actually intended.

-- STEP 8 - VALIDATION CONTRACT
-- Save at least:
--   source row counts
--   one-side key uniqueness checks
--   unmatched-key count(s)
--   joined row counts before/after each many-side join
--   raw line_sales total vs order-level CTE total
--   raw freight total vs corrected order-level freight total
--   one monthly total reconciled independently
--   one customer/product total reconciled independently

-- STEP 9 - FINDINGS / DECISION
-- Write three evidence-supported findings, one recommendation, and at least two limitations.
-- Separate observation from hypothesis.
-- Include one rejected interpretation that the data cannot prove.

-- STEP 10 - FRESH RETRY / DEFENSE
-- Change one question or cohort rule and rebuild the affected result without protected review open.
-- Give a 2-minute defense: business question -> grains -> cardinality risk -> query architecture -> validations -> finding -> limitation.
--
-- PROJECT PASS:
-- No critical grain/cardinality/reconciliation error; queries are readable; results can be reproduced and explained.
-- A polished output cannot compensate for inflated totals or an unexplained many-to-many join.
