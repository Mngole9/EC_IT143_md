-- =============================================
-- EC_IT143_W4.2_simpsons_s4_md.sql
-- Step 4: Turn the ad hoc SQL query into a view.
-- Author: Mangole Dorothy
-- Date: April 2026
-- Description: View showing number of characters per department.
-- =============================================

USE mycommunitiesDB;
GO

CREATE OR ALTER VIEW vw_Simpsons_CharactersByDepartment
AS
SELECT 
    Department,
    COUNT(*) AS NumberOfCharacters
FROM Simpsons.dbo.Family_Data
GROUP BY Department;