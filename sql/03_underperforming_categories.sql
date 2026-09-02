-- ============================================================
-- Query: Category Performance (Revenue + Order Volume)
-- Business question: Which product categories underperform —
--                     low revenue, low order volume, or both?
-- Useful for: inventory/purchasing decisions, marketing focus,
--             deciding whether to discontinue weak categories
-- ============================================================

SELECT
    c.CategoryName,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalRevenue,
    COUNT(DISTINCT o.OrderID) AS NumberOfOrders,
    COUNT(DISTINCT p.ProductID) AS NumberOfProducts,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) 
          / COUNT(DISTINCT p.ProductID), 2) AS RevenuePerProduct
FROM Categories c
JOIN Products p
    ON c.CategoryID = p.CategoryID
JOIN "Order Details" od
    ON p.ProductID = od.ProductID
JOIN Orders o
    ON od.OrderID = o.OrderID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue ASC;
