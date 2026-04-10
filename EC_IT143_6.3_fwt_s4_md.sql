CREATE OR ALTER TRIGGER dbo.trg_UpdateCustomerMetadata
ON dbo.t_w3_schools_customers
AFTER UPDATE AS BEGIN
    UPDATE dbo.t_w3_schools_customers
    SET LastModifiedBy = SUSER_NAME(), 
        LastModifiedDate = GETDATE()
    FROM Inserted i WHERE dbo.t_w3_schools_customers.CustomerID = i.CustomerID;
END;
GO
UPDATE dbo.t_w3_schools_customers SET City = 'Kampala' WHERE CustomerID = 1;

SELECT CustomerID, ContactName, City, LastModifiedBy, LastModifiedDate 
FROM dbo.t_w3_schools_customers WHERE CustomerID = 1;