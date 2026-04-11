-- =============================================
-- W6.4 Performance Analysis - Missing Index Demo
-- AdventureWorks2022 Database
-- =============================================

USE AdventureWorks2022;
GO

-- ======================
-- QUERY 1: Person.Person table (Before Index)
-- ======================
PRINT '=== QUERY 1 BEFORE INDEX ===';
SELECT 
    BusinessEntityID,
    FirstName,
    MiddleName,
    LastName,
    EmailPromotion
FROM Person.Person
WHERE LastName = 'Smith'; 


-- ======================
-- Create Index for Query 1
-- ======================
CREATE NONCLUSTERED INDEX IX_Person_LastName 
ON Person.Person (LastName)
INCLUDE (FirstName, MiddleName, EmailPromotion);
GO

-- ======================
-- QUERY 1 AFTER INDEX
-- ======================
PRINT '=== QUERY 1 AFTER INDEX ===';
SELECT 
    BusinessEntityID,
    FirstName,
    MiddleName,
    LastName,
    EmailPromotion
FROM Person.Person
WHERE LastName = 'Smith';   

GO


-- ======================
-- QUERY 2: Sales.SalesOrderHeader table (Before Index)
-- ======================
PRINT '=== QUERY 2 BEFORE INDEX ===';
SELECT 
    SalesOrderID,
    OrderDate,
    CustomerID,
    SalesPersonID
FROM Sales.SalesOrderHeader
WHERE AccountNumber = '10-4020-000002';   



-- ======================
-- Create Index for Query 2
-- ======================
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_AccountNumber 
ON Sales.SalesOrderHeader (AccountNumber)
INCLUDE (OrderDate, CustomerID, SalesPersonID);
GO

-- ======================
-- QUERY 2 AFTER INDEX
-- ======================
PRINT '=== QUERY 2 AFTER INDEX ===';
SELECT 
    SalesOrderID,
    OrderDate,
    CustomerID,
    SalesPersonID
FROM Sales.SalesOrderHeader
WHERE AccountNumber = '10-4020-000002';   
GO