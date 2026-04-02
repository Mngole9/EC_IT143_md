-- =============================================
-- EC_IT143_W4.2_simpsons_s3_md.sql
-- Step 3: Create an ad hoc SQL query.
-- Author: Mangole Dorothy
-- Date: April 2026
-- =============================================

SELECT 
    Department,
    COUNT(*) AS NumberOfCharacters
FROM Simpsons.dbo.Family_Data
GROUP BY Department
ORDER BY NumberOfCharacters DESC;