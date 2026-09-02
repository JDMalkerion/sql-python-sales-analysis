-- ============================================================
-- Query: Employee / Sales Rep Performance
-- Business question: Which employees drive the most revenue
--                     and orders? Useful for performance review,
--                     identifying top performers and coaching needs
-- ============================================================

SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName AS EmployeeName,
    e.Title,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalRevenue,
    COUNT(DISTINCT o.OrderID) AS NumberOfOrders,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) 
          / COUNT(DISTINCT o.OrderID), 2) AS AvgRevenuePerOrder
FROM Employees e
JOIN Orders o
    ON e.EmployeeID = o.EmployeeID
JOIN "Order Details" od
    ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, EmployeeName, e.Title
ORDER BY TotalRevenue DESC;
