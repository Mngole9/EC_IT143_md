-- =============================================
-- EC_IT143_W4.2_myfc_s6_md.sql
-- Step 6: Load the table from the view.
-- =============================================

USE mycommunitiesDB;
GO

TRUNCATE TABLE tbl_MyFC_PlayersByTeam;

INSERT INTO tbl_MyFC_PlayersByTeam (TeamCode, NumberOfPlayers)
SELECT TeamCode, NumberOfPlayers
FROM vw_MyFC_PlayersByTeam;