-- COURSE 1 - M03 SQL FOUNDATIONS - CANONICAL PRACTICE TASKS RC1
-- Rule: learner book teaches first. Save a genuine attempt before protected review.
-- Setup: run C1_M03_SQL_FOUNDATIONS_LAB_SETUP_RC1.sql once.
USE da_sql_foundations;

==============================================================================
-- SF0 - Set up MySQL Workbench and run your first query
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Run the canonical lab setup file once. Verify customer_rows = 12 and order_rows = 48. Then return every column from orders for 5 rows and a four-column result for 10 rows.
-- VALIDATE
-- Connection test returns 1; course setup returns 12 customers and 48 orders; the transfer query returns exactly 7 rows with the requested columns; no UPDATE/DELETE/DROP/ALTER is used outside the controlled setup script.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- Close the guided query. From a blank query tab, select order_id, order_date, category and sales_amount for 7 rows. Add a separate COUNT(*) query and explain why the count is a validation check rather than part of the 7-row answer.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain server, connection, schema, query tab and result grid in beginner language. Then explain why running SELECT does not normally modify the stored table.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF1 - Relational basics, keys and NULL
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Inspect customers and orders. Write SQL comments stating each table's grain, identify orders.order_id as the primary key and orders.customer_id as the foreign key, then return rows whose satisfaction_score is NULL.
-- VALIDATE
-- The NULL query contains only NULL scores. The NOT NULL query contains no NULL scores. COUNT(*) is greater than COUNT(satisfaction_score) on the course data. Your explanation says repeated customer_id values in orders can be legitimate because order grain is one row per order.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- Without the lesson open, write a query returning rows whose satisfaction_score is NOT NULL, then compare COUNT(*) with COUNT(satisfaction_score). Explain what the difference tells you about missingness.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain grain, primary key, foreign key and NULL with one example from the course tables. State why a foreign key can repeat and why NULL is not the same as 0 or an empty string.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF2 - SELECT, aliases and DISTINCT
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Return order_id, category and sales_amount AS gross_sales. Return unique channel values. Return unique region + category combinations and state the result grain in a SQL comment.
-- VALIDATE
-- Alias labels appear only in the result. DISTINCT status + channel has no duplicate pairs. The result grain explanation matches the selected combination rather than the source-table grain.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- Return unique status + channel combinations. Then return only order_id and sales_amount with readable aliases for completed orders. Explain why selecting fewer columns does not delete data from the table.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain SELECT, AS and DISTINCT. Give one example where DISTINCT on one column and DISTINCT on two columns answer different questions.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF3 - WHERE and filter logic
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Write filters for East + Completed, sales between 20000 and 35000 inclusive, Online/Phone channels, customer names starting A, and Completed Technology orders in North/South.
-- VALIDATE
-- Every returned transfer row satisfies status <> Cancelled, region in East/West and sales >= 25000. Inspect at least three rows and separately count qualifying rows.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- Return non-cancelled orders from East or West whose sales_amount is at least 25000. Use explicit parentheses so the logic cannot be misread. Then write the business rule as a comment directly above the SQL.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain WHERE, BETWEEN, IN, LIKE and the need for parentheses with mixed AND/OR. State one validation method for an important filter.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF4 - ORDER BY and LIMIT
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Return the five highest-sales orders. Then return Completed orders ordered by delivery_days DESC and sales_amount DESC. Explain why LIMIT alone cannot define highest/lowest.
-- VALIDATE
-- The first 7 rows are the smallest eligible sales values under the specified tie rule; the no-LIMIT version confirms row 8 is not smaller than row 7 under the sort definition.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- Return the 7 smallest Completed orders by sales_amount; for equal sales, sort newer order_date first. Remove LIMIT once to verify the boundary between row 7 and row 8.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain why ORDER BY defines what 'top' means and LIMIT only restricts how many already-ordered rows you keep.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF5 - Aggregate functions
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Count all orders, count Completed orders, sum Completed sales, average Completed delivery days, get min/max sales, and compare COUNT(*) to COUNT(satisfaction_score).
-- VALIDATE
-- Completed checkpoint remains 30 rows and 691500 sales. Transfer pending_count matches the independent count. Explain whether AVG(sales_amount) averages orders, customers or months - it averages the eligible rows.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- For Pending orders only, return pending_count, pending_sales, average sales and maximum sales in one row. Then independently count Pending rows with a separate query.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain COUNT(*), COUNT(column), SUM, AVG, MIN and MAX using the idea of an eligible row set.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF6 - GROUP BY and result grain
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Return order_count and total_sales per region; average delivery_days per category; order_count per region + status. Add SQL comments stating the result grain for the first and third queries.
-- VALIDATE
-- The transfer result grain is one row per channel among Completed orders. Sum of completed_count across channels equals 30 on the locked course data.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- For Completed orders only, return one row per channel with completed_count and completed_sales. Reconcile the sum of group counts to the independent Completed-order count.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain how GROUP BY changes result grain. Give one example of a one-column group and a two-column group, plus one reconciliation check.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF7 - HAVING vs WHERE
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Return regions with total sales > 280000; channels with at least 15 orders; categories with average delivery_days > 4. Explain WHY HAVING is used for aggregate conditions.
-- VALIDATE
-- All source rows entering the transfer groups are Completed. Every surviving region meets the aggregate threshold. A version without HAVING shows the groups that were filtered out.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- Using only Completed orders, show regions whose completed_sales is at least 150000. Include completed_count and completed_sales. State the result grain and explain the WHERE/HAVING split.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain WHERE vs HAVING without saying only 'HAVING comes later'. Use the row-rule versus group-rule distinction.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.

==============================================================================
-- SF8 - CASE for business classification
-- GUIDED FOLLOW-ALONG (after learner-book teacher demonstration)
-- Create order_size and delivery_band, then group by order_size and count orders in each band. Document threshold rules in SQL comments.
-- VALIDATE
-- Transfer band counts sum to 48. NULL rows land only in Unrated. Boundary scores 3 and 4 land in the intended bands. No row is silently excluded.
-- YOUR GUIDED SQL / COMMENTS BELOW:


-- FRESH INDEPENDENT TRY (close learner book/review first)
-- Create service_band from satisfaction_score: NULL -> 'Unrated', >=4 -> 'Strong', =3 -> 'Neutral', else 'Weak'. Summarize counts by band and reconcile them to total orders.
-- YOUR FRESH SQL / COMMENTS BELOW:


-- EXPLAIN BACK
-- Explain CASE evaluation order, threshold boundaries and why classification rules need documented business meaning.
-- EVIDENCE: save query + validation + result-grain statement + one recovery note.
