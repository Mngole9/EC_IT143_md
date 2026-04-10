CREATE OR ALTER FUNCTION dbo.fn_GetFirstName (@ContactName VARCHAR(100))
RETURNS VARCHAR(100) AS BEGIN
    RETURN (SELECT LEFT(@ContactName, CHARINDEX(' ', @ContactName) - 1))
END;
GO
CREATE OR ALTER FUNCTION dbo.fn_GetLastName (@ContactName VARCHAR(100))
RETURNS VARCHAR(100) AS BEGIN
    RETURN (SELECT SUBSTRING(@ContactName, CHARINDEX(' ', @ContactName) + 1, LEN(@ContactName)))
END;
GO
SELECT ContactName, 
       dbo.fn_GetFirstName(ContactName) AS First_Name,
       dbo.fn_GetLastName(ContactName) AS Last_Name
FROM dbo.t_w3_schools_customers;