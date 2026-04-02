-- =============================================
-- EC_IT143_W4.2_myfc_s3_md.sql
-- Step 3: Create an ad hoc SQL query.
-- Author: Mangole Dorothy
-- Date: April 2026
-- =============================================

SELECT 
    t.t_code AS TeamCode,
    COUNT(*) AS NumberOfPlayers
FROM MyFC.dbo.tblPlayerFact f
INNER JOIN MyFC.dbo.tblTeamDim t ON f.pl_id = t.t_id
GROUP BY t.t_code
ORDER BY NumberOfPlayers DESC;