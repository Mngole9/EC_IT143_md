/*****************************************************************************************************************
NAME:    EC_IT143_W3.4_md,sql
PURPOSE: This SQL Script answers eightuser /buisness questions using the AdventureWorks sample database.The questions cover marginal,moderate
and increased buisness cmplexity as well as metadata queries using the system information schema.

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     07/10/2025  Mangole Dorothy       1. created this script to answer eight AdventureWorks Questions for IT143-week 3.4 assignment


RUNTIME: 
Approx. 2–3 minutes total depending on system performance.


NOTES: 
 This script includes SQL queries that answer a set of business and metadata
questions from the AdventureWorks database. Each question (Q1–Q8) is clearly 
commented, followed by the corresponding SQL answer
******************************************************************************************************************/

-- Q1: What are the top five products with the highest list price?
-- A1: This query selects the five products with the highest list price 
--     from the Production.Product table
 A1:
SELECT TOP (5)
    p.ProductID,
    p.Name AS ProductName,
    p.ListPrice
FROM Production.Product AS p
WHERE p.ListPrice IS NOT NULL
ORDER BY p.ListPrice DESC, p.ProductID;
GO
Q2: Employees who currently work in the Sales department
SELECT
    e.BusinessEntityID AS EmployeeID,
    p.FirstName + ' ' + p.LastName AS EmployeeName,
    e.JobTitle,
    d.Name AS DepartmentName,
    edh.StartDate
FROM HumanResources.Employee AS e
JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department AS d
    ON edh.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
  AND edh.EndDate IS NULL
ORDER BY p.LastName, p.FirstName;
GO

-- Q3: Top three product categories by product count
SELECT TOP (3)
    pc.Name AS ProductCategory,
    COUNT(p.ProductID) AS ProductCount
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY COUNT(p.ProductID) DESC, pc.Name;
GO

-- Q4: Customers who placed orders in 2013 and live in Washington (name + order date)
SELECT DISTINCT
    c.CustomerID,
    COALESCE(p.FirstName + ' ' + p.LastName, c.AccountNumber) AS CustomerName,
    soh.SalesOrderID,
    CONVERT(date, soh.OrderDate) AS OrderDate,
    sp.Name AS StateProvince
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c
    ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.PersonAddress AS pa
    ON p.BusinessEntityID = pa.BusinessEntityID
LEFT JOIN Person.Address AS a
    ON pa.AddressID = a.AddressID
LEFT JOIN Person.StateProvince AS sp
    ON a.StateProvinceID = sp.StateProvinceID
WHERE YEAR(soh.OrderDate) = 2013
  AND sp.Name = 'Washington'
ORDER BY CustomerName, soh.OrderDate;
GO

-- Q5: Helmet sales in Q2 2012 (Apr-Jun) by month, size, color
SELECT
    YEAR(soh.OrderDate) AS OrderYear,
    DATEPART(MONTH, soh.OrderDate) AS OrderMonth,
    DATENAME(MONTH, soh.OrderDate) AS MonthName,
    COALESCE(NULLIF(p.Size, ''), '(Unknown)') AS Size,
    COALESCE(NULLIF(p.Color, ''), '(Unknown)') AS Color,
    SUM(sod.OrderQty) AS TotalQuantity,
    SUM(sod.UnitPrice * sod.OrderQty) AS TotalListPrice,
    SUM((sod.UnitPrice * (1.0 - sod.UnitPriceDiscount)) * sod.OrderQty) AS EstimatedNetRevenue
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product AS p
    ON sod.ProductID = p.ProductID
WHERE soh.OrderDate >= '2012-04-01'
  AND soh.OrderDate <  '2012-07-01'
  AND p.Name LIKE '%helmet%'         -- adjust for case-sensitivity if needed
GROUP BY
    YEAR(soh.OrderDate),
    DATEPART(MONTH, soh.OrderDate),
    DATENAME(MONTH, soh.OrderDate),
    p.Size,
    p.Color
ORDER BY
    YEAR(soh.OrderDate),
    DATEPART(MONTH, soh.OrderDate),
    p.Size,
    p.Color;
GO

-- Q6: Employees hired before 2005 who still work at the company (department, title, hire date)
SELECT
    e.BusinessEntityID AS EmployeeID,
    p.FirstName + ' ' + p.LastName AS EmployeeName,
    e.JobTitle,
    e.HireDate,
    d.Name AS DepartmentName,
    edh.StartDate
FROM HumanResources.Employee AS e
JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department AS d
    ON edh.DepartmentID = d.DepartmentID
WHERE e.HireDate < '2005-01-01'
  AND edh.EndDate IS NULL
ORDER BY e.HireDate, p.LastName, p.FirstName;
GO

-- Q7: Which tables contain a column named 'ProductID'?
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ProductID'
ORDER BY TABLE_SCHEMA, TABLE_NAME;
GO

-- Q8: List all views that include the column 'SalesOrderID'
SELECT
    s.name AS SchemaName,
    v.name AS ViewName,
    c.name AS ColumnName
FROM sys.views AS v
JOIN sys.schemas AS s
    ON v.schema_id = s.schema_id
JOIN sys.columns AS c
    ON v.object_id = c.object_id
WHERE c.name = 'SalesOrderID'
ORDER BY s.name, v.name;
GO
SELECT GETDATE() AS my_date;