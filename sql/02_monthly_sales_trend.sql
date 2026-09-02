-- ============================================================
-- Query: Monthly Sales Trend / Seasonality
-- Business question: How does revenue move month over month?
--                     Are there seasonal peaks/dips?
-- Useful for: inventory planning, staffing, marketing calendar
-- ============================================================

SELECT
    strftime('%Y-%m', o.OrderDate) AS OrderMonth,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS MonthlyRevenue,
    COUNT(DISTINCT o.OrderID) AS NumberOfOrders
FROM Orders o
JOIN "Order Details" od
    ON o.OrderID = od.OrderID
GROUP BY OrderMonth
ORDER BY OrderMonth;
