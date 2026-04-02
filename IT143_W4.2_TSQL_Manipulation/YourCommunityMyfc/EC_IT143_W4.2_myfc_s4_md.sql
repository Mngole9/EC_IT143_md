-- =============================================
-- EC_IT143_W4.2_myfc_s4_md.sql
-- Step 4: Turn the ad hoc SQL query into a view.
-- Author: Mangole Dorothy
-- Date: April 2026
-- Description: View that shows number of players per team.
-- =============================================

USE mycommunitiesDB;
GO

CREATE OR ALTER VIEW vw_MyFC_PlayersByTeam
AS
SELECT 
    t.t_code AS TeamCode,
    COUNT(*) AS NumberOfPlayers
FROM MyFC.dbo.tblPlayerFact f
INNER JOIN MyFC.dbo.tblTeamDim t ON f.pl_id = t.t_id
GROUP BY t.t_code;