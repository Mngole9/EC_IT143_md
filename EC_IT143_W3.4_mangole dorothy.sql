/***************************************************************************************************
EC_IT143_W3.4_mangoledorothy.sql
Student: MANGOLE DOROTHY (Initials: xx)
Assignment: 3.4 Adventure Works—Create Answers
Date: March 21, 2026

Purpose: Provide SQL answers to 8 questions posted by Ricky Simona in W3.3
         Exactly 2 questions from each required category.
         Formatted cleanly following SQL style guidelines.

Estimated runtime: ~5–20 seconds total (depending on machine)
Database: AdventureWorks2022 (OLTP version)

All questions sourced from: Ricky Simona's post (Mar 21)
***************************************************************************************************/

USE AdventureWorks2022;
GO

-- =============================================================================
-- Q1 – Business User – Marginal complexity
-- Original author: Ricky Simona
-- Question: What are the ten most expensive products by list price?
-- =============================================================================
SELECT TOP 10
    ProductID,
    Name           AS ProductName,
    ListPrice
FROM Production.Product
WHERE ListPrice > 0
ORDER BY ListPrice DESC;
-- Returns: Highest priced items first (mostly high-end bikes)


-- =============================================================================
-- Q2 – Business User – Marginal complexity
-- Original author: Ricky Simona
-- Question: Which products are listed as red in color?
-- =============================================================================
SELECT
    ProductID,
    Name           AS ProductName,
    Color
FROM Production.Product
WHERE Color = 'Red'
ORDER BY Name;
-- Returns: All red-colored products (bikes, components, etc.)


-- =============================================================================
-- Q3 – Business User – Moderate complexity
-- Original author: Ricky Simona
-- Question: I want to compare selling price and cost. Which five products have the highest difference between list price and standard cost?
-- =============================================================================
SELECT TOP 5
    ProductID,
    Name                 AS ProductName,
    ListPrice,
    StandardCost,
    (ListPrice - StandardCost) AS MarginPerUnit
FROM Production.Product
WHERE ListPrice > StandardCost
  AND StandardCost > 0
ORDER BY (ListPrice - StandardCost) DESC;
-- Returns: Products with the largest profit margin per unit


-- =============================================================================
-- Q4 – Business User – Moderate complexity
-- Original author: Ricky Simona
-- Question: I need to understand recent customer activity better. Which ten customers placed the most sales orders, based on total order count?
-- =============================================================================
SELECT TOP 10
    c.CustomerID,
    COALESCE(p.FirstName + ' ' + p.LastName, s.Name, 'Unknown') AS CustomerName,
    COUNT(soh.SalesOrderID)                             AS TotalOrderCount
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
GROUP BY c.CustomerID, p.FirstName, p.LastName, s.Name
ORDER BY TotalOrderCount DESC;
-- Returns: Top 10 customers by number of orders (handles individuals & stores)


-- =============================================================================
-- Q5 – Business User – Increased complexity
-- Original author: Ricky Simona
-- Question: Please show monthly order quantity, list price, standard cost, and estimated revenue for mountain bike products sold during 2011, grouped by month and product name.
-- =============================================================================
SELECT
    YEAR(soh.OrderDate)                 AS OrderYear,
    MONTH(soh.OrderDate)                AS OrderMonth,
    p.Name                              AS ProductName,
    SUM(sod.OrderQty)                   AS TotalQuantitySold,
    SUM(sod.LineTotal)                  AS TotalListPrice,
    SUM(sod.OrderQty * p.StandardCost)  AS TotalStandardCost,
    SUM(sod.LineTotal - (sod.OrderQty * p.StandardCost)) AS EstimatedNetRevenue
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes'
  AND psc.Name = 'Mountain Bikes'
  AND YEAR(soh.OrderDate) = 2011
GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate), p.Name
ORDER BY OrderYear, OrderMonth, TotalQuantitySold DESC;
-- Returns: Monthly breakdown for mountain bikes in 2011


-- =============================================================================
-- Q6 – Business User – Increased complexity
-- Original author: Ricky Simona
-- Question: Can you show total quantity sold, average selling price, and estimated revenue by product category for all online orders in 2012?
-- =============================================================================
SELECT
    pc.Name                                 AS ProductCategory,
    SUM(sod.OrderQty)                       AS TotalQuantitySold,
    AVG(sod.UnitPrice)                      AS AvgSellingPrice,
    SUM(sod.LineTotal)                      AS TotalRevenue,
    SUM(sod.LineTotal - (sod.OrderQty * p.StandardCost)) AS EstimatedNetRevenue
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE soh.OnlineOrderFlag = 1                  -- Online orders only
  AND YEAR(soh.OrderDate) = 2012
GROUP BY pc.Name
ORDER BY TotalRevenue DESC;
-- Returns: Category performance for 2012 online sales


-- =============================================================================
-- Q7 – Metadata question
-- Original author: Ricky Simona
-- Question: Which AdventureWorks tables contain a column named ProductID or ProductSubcategoryID?
-- =============================================================================
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME IN ('ProductID', 'ProductSubcategoryID')
ORDER BY TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME;
-- Returns: All tables that use these common product keys


-- =============================================================================
-- Q8 – Metadata question
-- Original author: Ricky Simona
-- Question: Which columns in the AdventureWorks Production schema allow NULL values, and what tables are they in?
-- =============================================================================
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Production'
  AND IS_NULLABLE = 'YES'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
-- Returns: Nullable columns in Production schema (e.g. Color, Size in Product table)

-- =============================================================================
-- END OF SCRIPT
***************************************************************************************************/