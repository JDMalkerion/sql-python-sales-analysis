-- ============================================================
-- Query: Top 10 Customers by Revenue
-- Business question: Which customers generate the most revenue?
-- Useful for: identifying key accounts, prioritizing retention
--             efforts, and spotting who to build loyalty programs for.
-- ============================================================

SELECT
    c.CustomerID,
    c.CompanyName,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalRevenue,
    COUNT(DISTINCT o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN "Order Details" od
    ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalRevenue DESC
LIMIT 10;
