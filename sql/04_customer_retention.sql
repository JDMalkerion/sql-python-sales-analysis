-- ============================================================
-- Query: Customer Order Frequency Distribution
-- Business question: How does order frequency vary across the
--                     customer base? Note: initial one-time vs
--                     repeat-buyer split showed 100% repeat buyers
--                     (small, mature customer base over 11 years),
--                     so this bucket-based version is more useful.
-- Useful for: understanding customer engagement homogeneity
-- ============================================================

WITH customer_order_counts AS (
    SELECT c.CustomerID, COUNT(DISTINCT o.OrderID) AS NumberOfOrders
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID
)
SELECT
    CASE
        WHEN NumberOfOrders < 100 THEN 'Low (<100 orders)'
        WHEN NumberOfOrders < 200 THEN 'Medium (100-199)'
        ELSE 'High (200+)'
    END AS FrequencyTier,
    COUNT(*) AS NumberOfCustomers,
    ROUND(AVG(NumberOfOrders), 1) AS AvgOrders
FROM customer_order_counts
GROUP BY FrequencyTier
ORDER BY AvgOrders;
